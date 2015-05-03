library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use unisim.vcomponents.all;

entity sine_master is
    Generic ( 
      clock_divider_max_value : positive := 6; -- Number of base clock cycles required to toggle samp_clk
			reset_count : positive := 100_000_000 -- Number of cycles to pause in order to let the PHY reset
		);
    Port ( clk : in  STD_LOGIC; -- Input clock
           rst : in  STD_LOGIC; -- Reset signal
           tx_clk : in  STD_LOGIC; -- PHY transmit clock
           tx_er : out  STD_LOGIC; -- PHY transmit error (will be grounded)
           tx_en : out  STD_LOGIC; -- PHY transmit enable
           tx_data : out  STD_LOGIC_VECTOR (3 downto 0); -- PHY transmit data
           smi_clk : out STD_LOGIC; -- PHY SMI clock
           smi_mdio : inout STD_LOGIC; -- PHY SMI serial data line
           leds : out  STD_LOGIC_VECTOR (7 downto 0); -- LEDs for debugging
           eth_rst_n : out  STD_LOGIC; -- PHY reset signal (active low)
           sine_inc : in std_logic_vector(7 downto 0); -- Allows changing of the DDS output frequency
           sine_o : out std_logic_vector(7 downto 0); -- Debugging output of the DDS output and samp FIFO output
           divider_max_val : in std_logic_vector(3 downto 0); -- Debugging how fast the interface can run before getting errors
           source_select : in std_logic -- Allows selection of outputting the DDS value or samp FIFO output through sine_o
				);
end sine_master;

architecture Behavioral of sine_master is

	-- DDS sine wave generator
  signal sine_out : std_logic_vector(7 downto 0);
  COMPONENT sine_gen
    PORT (
      clk : IN STD_LOGIC;
      pinc_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

	-- FIFO that will buffer samples from the DDS and flush out to the UDP -> IP -> Ethernet -> PHY modules
  signal samp_din, samp_dout : std_logic_vector(7 downto 0);
  signal samp_wr_clk, samp_wr_en, samp_full, samp_prog_full, samp_rd_clk, samp_rd_en, samp_empty : std_logic;
  COMPONENT sampling_fifo
    PORT (
      wr_clk : in std_logic;
      din : in std_logic_vector(7 downto 0);
      wr_en : in std_logic;
      prog_full_thresh : in std_logic_vector(10 downto 0);
      full : out std_logic;
      prog_full : out std_logic;
      rd_clk : in std_logic;
      dout : out std_logic_vector(7 downto 0);
      rd_en : in std_logic;
      empty : out std_logic;
      rst : in std_logic
    );
  END COMPONENT;

	-- DCM to generate the clocks for data (rate for UDP, IP, and Ethernet modules) and SMI (PHY control)
  signal tx_clk_copy, data_clk, smi_clk_buffered : std_logic;
  COMPONENT ethernet_dcm
    PORT ( 
      tx_clk25Mhz : in std_logic;
      tx_clk_copy : out std_logic;
      data_clk : out std_logic;
      smi_clk : out std_logic
    );
  END COMPONENT;

	-- A lot of code that simply gets the value of the link established register of the PHY's SMI
  signal smi_working, smi_done, smi_rdy, smi_rd_en : std_logic;
  signal smi_dout : std_logic_vector(15 downto 0);
  type smi_state_t is (SMI_IDLE, SMI_WAIT_FOR_READY, SMI_START_READ, SMI_WAIT_BUSY, SMI_WAIT_DONE);
  signal smi_state : smi_state_t;
  COMPONENT smi_ramlike
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      rd_en : IN std_logic;
      wr_en : IN std_logic;
      addr : IN std_logic_vector(3 downto 0);
      data_in : IN std_logic_vector(15 downto 0);
      mdio : INOUT std_logic;
      data_out : OUT std_logic_vector(15 downto 0);
      working : OUT std_logic;
      done : OUT std_logic;
      rdy : OUT std_logic
      );
  END COMPONENT;
  
	-- Wrapper that puts a UDP header on the provided data
  signal udp_data_in, udp_data_out : std_logic_vector(7 downto 0);
  signal udp_wr_en, udp_prog_full, udp_full, udp_empty, udp_dv, udp_dropped, udp_busy : std_logic;
  COMPONENT udp_wrapper
  GENERIC( 
		src_port : std_logic_vector(15 downto 0) := x"1F90"; -- Source port
    dest_port : std_logic_vector(15 downto 0) := x"1F90" -- Destination port
	);
  PORT(
    clk : IN std_logic;
    rst : IN std_logic;
    data_in : IN std_logic_vector(7 downto 0);
    wr_en : IN std_logic;
    buffer_prog_full_val : IN std_logic_vector(10 downto 0);          
    busy : OUT std_logic;
    buffer_full : OUT std_logic;
    buffer_empty : OUT std_logic;
    buffer_prog_full : OUT std_logic;
    data_out : OUT std_logic_vector(7 downto 0);
    data_valid : OUT std_logic;
    dropped_frame : OUT std_logic
    );
  END COMPONENT;

	-- Wrapper that puts an IP header on the provided data
  signal ip_data_in, ip_data_out : std_logic_vector(7 downto 0);
  signal ip_wr_en, ip_prog_full, ip_full, ip_empty, ip_dv, ip_dropped, ip_busy : std_logic;
  COMPONENT ip_wrapper
  GENERIC( 
		src_ip : std_logic_vector(31 downto 0) := x"c0a801fb"; -- Source IP
    dest_ip : std_logic_vector(31 downto 0) := x"c0a80109"; -- Dest IP
		protocol : std_logic_vector(7 downto 0) := x"11" -- Next level protocol
	);
  PORT(
    clk : IN std_logic;
    rst : IN std_logic;
    data_in : IN std_logic_vector(7 downto 0);
    wr_en : IN std_logic;
    buffer_prog_full_val : IN std_logic_vector(10 downto 0);          
    busy : OUT std_logic;
    buffer_full : OUT std_logic;
    buffer_empty : OUT std_logic;
    buffer_prog_full : OUT std_logic;
    data_out : OUT std_logic_vector(7 downto 0);
    data_valid : OUT std_logic;
    dropped_frame : OUT std_logic
    );
  END COMPONENT;

	-- Modified version of the ethernet_wrapper that also adds in the Ethernet sync sequence as well
  signal e_data_in, e_data_out : std_logic_vector(7 downto 0);
  signal e_wr_en, e_prog_full, e_full, e_empty, e_dv, e_dropped, e_busy : std_logic;
  COMPONENT ethernet_wrapper_with_preamble
  GENERIC ( 
		dest_mac : std_logic_vector(47 downto 0) := x"0050b60a6ae7"; -- Destination MAC address
		src_mac : std_logic_vector(47 downto 0) := x"010203040506"; -- Source MAC address
    protocol : std_logic_vector(15 downto 0) := x"0800" -- Next level protocol
	);
  PORT(
    clk : IN std_logic;
    rst : IN std_logic;
    data_in : IN std_logic_vector(7 downto 0);
    wr_en : IN std_logic;
    buffer_prog_full_val : IN std_logic_vector(10 downto 0);          
    busy : OUT std_logic;
    buffer_full : OUT std_logic;
    buffer_empty : OUT std_logic;
    buffer_prog_full : OUT std_logic;
    data_out : OUT std_logic_vector(7 downto 0);
    data_valid : OUT std_logic;
    dropped_frame : OUT std_logic
    );
  END COMPONENT;

	-- Handles the actual transmission of each byte over the Ethernet PHY
  COMPONENT ethernet_tx
  PORT(
    tx_clk : IN std_logic;
    rst : IN std_logic;
    link_established : IN std_logic;
    reset_complete : IN std_logic;
    wr_en : IN std_logic;
    data_in : IN std_logic_vector(7 downto 0);          
    tx_er : OUT std_logic;
    tx_data : OUT std_logic_vector(3 downto 0);
    tx_en : OUT std_logic
    );
  END COMPONENT;

	-- These two signals are used to bring in the reset signal (button).  The resulting signal
	-- (rst_valid) should not have any metastability issues
  signal rst_sync : std_logic_vector(3 downto 0);
  signal rst_valid : std_logic;

	-- Used to keep track of if the PHY link has been established (read from the SMI)
  signal eth_link_established : std_logic;
	-- The PHY needs to be reset using it's active low reset line.  This is used to let it sit
	-- low long enough
  signal eth_reset_counter : unsigned(26 downto 0);
	-- Used to know when the PHY reset has been completed
  signal eth_reset_complete : std_logic;

	-- Used for the pattern generator (commented out now)
  --signal zeros_gen_counter : unsigned(26 downto 0);
  --signal zeros_gen_state : unsigned(0 downto 0);
  --signal zeros_gen_actual_data : std_logic_vector(7 downto 0);
  
	-- Used to catch when a packet is dropped by and of the protocol wrappers
  signal fault : std_logic;

	-- The state machine type that controls unloading data from the sampling FIFO
  type samp_state_t is (SAMP_WAIT_FOR_FULL, SAMP_UNLOAD);
  signal samp_state : samp_state_t;
	-- Used to unload only the specified number of bytes from the sampling FIFO at a time
  signal samp_counter : unsigned(10 downto 0);

	-- Counter used to divide down the data clock to create the sampling clock
  signal samp_clk_counter : unsigned(7 downto 0);
	-- Clock created by a process that controls how often the DDS sampled
  signal samp_clk : std_logic;

	-- Number of samples that make up one frame.  This is how many bytes will be sent at a time
	-- over the Ethernet connection.
	constant samp_frame_size : positive := 600;
begin

	-- Debugging output
  leds <= "01" & eth_link_established & samp_prog_full & samp_empty & e_empty & e_busy & fault;

	-- The IP wrapper feeds the Ethernet wrapper
  e_data_in <= ip_data_out;
  e_wr_en <= ip_dv;

	-- The UDP wrapper feeds the IP wrapper
  ip_data_in <= udp_data_out;
  ip_wr_en <= udp_dv;

	-- The output of the sampling FIFO feeds the UDP wrapper
  udp_data_in <= samp_dout;
	-- Only allow the frames to be written if the sampling state machine is waiting for more data
	-- TODO: This actuall might be causing a bug.  Might need to put this in the process that drives
	--       the state machine...
  udp_wr_en <= '0' when samp_state = SAMP_WAIT_FOR_FULL else '1';

	-- The input to the sampling FIFO is the OUTPUT of the DDS converted to unsigned (+128)
  --samp_din <= std_logic_vector(unsigned(sine_out) + 128);
	-- The write enable signal of the sampling FIFO that is controlled by the link established and reset signals
  samp_wr_en <= eth_link_established and eth_reset_complete;
	-- The sampling FIFO write clock is the sampling clock
  samp_wr_clk <= samp_clk;
	-- The sampling FIFO read clock is the data clock (same that drives the wrapper modules)
  samp_rd_clk <= data_clk;
	
	-- This is the debugging output of the DDS sine wave.  By using the bottom button, the output can be
	-- switched between the sampling FIFO output or the sampling FIFO input (this is just the output of the DDS)
  sine_o <= samp_dout when source_select = '1' else samp_din;

	-- Controlls the generation of the sampling clock.  This cannot be the same rate as the 
	-- data clock since it would overflow the wrapper FIFOs.
	-- The sampling clock is also what will determine the final data rate flowing out of the PHY
  process(clk, rst_valid)
  begin
    if(rst_valid = '1') then
      samp_clk_counter <= (others => '0');
      samp_clk <= '0';
    elsif(rising_edge(clk)) then
      samp_clk_counter <= samp_clk_counter + 1;

			-- Increase this value to slow the sampling clock down
      if(samp_clk_counter = unsigned(divider_max_val)) then
        samp_clk <= not samp_clk;
        samp_clk_counter <= (others => '0');
      end if;
    end if;
  end process;

  process(samp_clk, rst_valid)
    variable counter : integer range 0 to 255;
  begin
    if(rst_valid = '1') then
      counter := 0;
      samp_din <= (others => '0');
    elsif(rising_edge(samp_clk)) then
      samp_din <= std_logic_vector(to_unsigned(counter, 8));
      counter := counter + 1;
    end if;
  end process;

	-- State machine that determines when to send data through the wrapper modules.
	-- The basic idea is that the process will wait until the programmable full output
	-- of the sampling FIFO goes high.  That means that there is enough data in the FIFO
	-- to send an entire frame of samples.
	-- THIS IS THE NUMBER OF SAMPLES SENT!!  The total bytes sent over the Ethernet connection
	-- will be more due to protocols!
  process(data_clk, rst_valid)
  begin
    if(rst_valid = '1') then
      samp_state <= SAMP_WAIT_FOR_FULL;
      samp_rd_en <= '0';
      samp_counter <= (others => '0');
    elsif(rising_edge(data_clk)) then
      if(eth_link_established = '1' and eth_reset_complete = '1') then
        case samp_state is
          when SAMP_WAIT_FOR_FULL =>
            samp_rd_en <= '0';
            if(samp_prog_full = '1') then
              samp_rd_en <= '1';
              samp_state <= SAMP_UNLOAD;
              samp_counter <= (others => '0');
            end if;

          when SAMP_UNLOAD =>
            samp_counter <= samp_counter + 1;
						
						-- Stop after reading samp_frame_size bytes (remember, zero counts!)
            if(samp_counter = samp_frame_size - 1) then
              samp_rd_en <= '0';
              samp_counter <= (others => '0');
              samp_state <= SAMP_WAIT_FOR_FULL;
            elsif(samp_counter = samp_frame_size - 2) then
              samp_rd_en <= '0';
            end if;
        end case;
      end if;
    end if;
  end process;

	-- Latches any frame dropped errors.  If the drops are intermittent then you might not
	-- notice them.  This process will grab any drop errors and set fault high until the 
	-- reset button is pressed.
  process(clk, rst_valid)
  begin
    if(rst_valid = '1') then
      fault <= '0';
    elsif(rising_edge(clk)) then
      if(fault = '0') then
        if(e_dropped = '1' or udp_dropped = '1' or ip_dropped = '1') then
          fault <= '1';
        end if;
      end if;
    end if;
  end process;

	-- This process was used to generate a test pattern (counted 0 to 255)
  --process(data_clk, rst_valid)
  --begin
  --  if(rst_valid = '1') then
  --    zeros_gen_counter <= (others => '0');
  --    zeros_gen_state <= (others => '0');
  --    udp_wr_en <= '0';
  --    udp_data_in <= (others => '0');
  --    zeros_gen_actual_data <= (others => '0');
  --  elsif(rising_edge(data_clk)) then
  --    case to_integer(zeros_gen_state) is
  --      when 0 =>
  --        zeros_gen_counter <= zeros_gen_counter + 1;
  --        zeros_gen_actual_data <= std_logic_vector(unsigned(zeros_gen_actual_data) + 1);
  --        udp_data_in <= zeros_gen_actual_data;
  --        udp_wr_en <= '1';

  --        if(zeros_gen_counter = 700 - 1) then
  --          zeros_gen_counter <= (others => '0');
  --          zeros_gen_state <= to_unsigned(1, zeros_gen_state'length);
  --        end if;
  --      
  --      when 1 =>
  --        udp_wr_en <= '0';
  --        zeros_gen_counter <= zeros_gen_counter + 1;

  --        if(zeros_gen_counter = 1500) then
  --          zeros_gen_state <= (others => '0');
  --          zeros_gen_counter <= (others => '0');
  --        end if;

  --      when others => 
  --        null;
  --    end case;
  --  end if;
  --end process;

	-- Syncronizes the reset signal to the clk clock domain.  This is to ensure
	-- that there are no metastability issues.
  process(clk)
  begin
    if(rising_edge(clk)) then
      rst_sync <= rst_sync(rst_sync'high - 1 downto 0) & rst;
      rst_valid <= rst_sync(rst_sync'high);
    end if;
  end process;

	-- Gives the PHY enough time to reset.  Change the value of reset_count (generic field) to
	-- increase or decrease how long the PHY stays in reset.  There is a minimum value, so be
	-- sure not to go lower than that!
  process(clk, rst_valid)
  begin
    if(rst_valid = '1') then
      eth_reset_counter <= (others => '0');
      eth_reset_complete <= '0';
      eth_rst_n <= '1';
    elsif(rising_edge(clk)) then
      if(eth_reset_counter = reset_count) then
        eth_reset_complete <= '1';
        eth_rst_n <= '1';
      else
        eth_reset_complete <= '0';
        eth_rst_n <= '0';
        eth_reset_counter <= eth_reset_counter + 1;
      end if;
    end if;
  end process;

  -- Simply asks for address "0001" which contains the link status flag
  -- which is needed to know if it's okay to TX packets.  You could probably
  -- get away with not checking the link status and just transmitting data
  -- that the PHY will ignore.
  -- The SMI_IDLE state is just a dumb state.  Any 'reset' logic between reads
  -- can go there.
  process(smi_clk_buffered, rst_valid)
  begin
    if(rst_valid = '1') then
      eth_link_established <= '0';
      smi_state <= SMI_IDLE;
      smi_rd_en <= '0';
    elsif(rising_edge(smi_clk_buffered)) then
      if(eth_reset_complete = '1') then
        case smi_state is
          when SMI_IDLE =>
            smi_state <= SMI_WAIT_FOR_READY;
          when SMI_WAIT_FOR_READY =>
            if(smi_rdy = '1') then
              smi_state <= SMI_START_READ;
            end if;
          when SMI_START_READ =>
            smi_rd_en <= '1';
            smi_state <= SMI_WAIT_BUSY;
          when SMI_WAIT_BUSY =>
            if(smi_working = '1') then
              smi_rd_en <= '0';
              smi_state <= SMI_WAIT_DONE;
            end if;
          when SMI_WAIT_DONE =>
            if(smi_done = '1') then
              eth_link_established <= smi_dout(2);
              smi_state <= SMI_IDLE;
            end if;
        end case;
      end if;
    end if;
  end process;

	-- DCM to generate the needed clocks.  The PHY's tx_clk signal will drive the DCM.  It
	-- is expected to be 25MHz so this only works on 100Mbit connections!  The tx_clk_copy 
	-- is a copy of the tx_clk since tx_clk can no longer be used in any processes.  The 
	-- data_clk signal is for driving the wrapper modules.  Finally, the SMI clock is for
	-- driving the PHY's SMI.  It must be less than ~ 2MHz to work properly.
  dcm_inst : ethernet_dcm PORT MAP (
    tx_clk25MHz => tx_clk,
    tx_clk_copy => tx_clk_copy,
    data_clk => data_clk,
    smi_clk => smi_clk_buffered
  );

	-- The SMI clock is tied to a pin that will cause complaints by ISE about having to use
	-- CLK_DEDICATED_ROUTE = false in order to compile without errors.  To fix that, we use
	-- an ODDR2 buffer to output the clock.  Check out 
	-- http://forums.xilinx.com/t5/Spartan-Family-FPGAs/Clock-issue-about-spartan-6/td-p/67284
  -- to see why this is used.
	ODDR2_smi_clk_inst : ODDR2
   generic map(
      DDR_ALIGNMENT => "NONE",
      INIT => '0',
      SRTYPE => "SYNC")
   port map (
      Q => smi_clk,    -- 1-bit output data
      C0 => smi_clk_buffered,       -- 1-bit clock input
      C1 => (NOT smi_clk_buffered), -- 1-bit clock input
      CE => '1',              -- 1-bit clock enable input
      D0 => '1',
      D1 => '0',
      R => '0',    -- 1-bit reset input
      S => '0'     -- 1-bit set input
   );

  smi_ramlike_inst : smi_ramlike
    PORT MAP(
      clk => smi_clk_buffered,
      rst => rst_valid,
      mdio => smi_mdio,
      rd_en => smi_rd_en,
      wr_en => '0',
      addr => "0001", -- The link established register is on page 1
      data_in => (others => '0'), -- No need to input data (only reading)
      data_out => smi_dout,
      working => smi_working,
      done => smi_done,
      rdy => smi_rdy);

  udp_wrapper_inst : udp_wrapper PORT MAP(
    clk => data_clk,
    rst => rst_valid,
    data_in => udp_data_in,
    wr_en => udp_wr_en,
    busy => udp_busy,
    buffer_full => udp_full,
    buffer_empty => udp_empty,
    buffer_prog_full => udp_prog_full,
    buffer_prog_full_val => std_logic_vector(to_unsigned(1000, 11)),  -- Doesn't really matter
    data_out => udp_data_out,
    data_valid => udp_dv,
    dropped_frame => udp_dropped
  );

  ip_wrapper_inst : ip_wrapper PORT MAP(
    clk => data_clk,
    rst => rst_valid,
    data_in => ip_data_in,
    wr_en => ip_wr_en,
    busy => ip_busy,
    buffer_full => ip_full,
    buffer_empty => ip_empty,
    buffer_prog_full => ip_prog_full,
    buffer_prog_full_val => std_logic_vector(to_unsigned(1000, 11)),  -- Doesn't really matter
    data_out => ip_data_out,
    data_valid => ip_dv,
    dropped_frame => ip_dropped
  );

  ethernet_wrapper_with_preamble_inst : ethernet_wrapper_with_preamble PORT MAP(
    clk => data_clk,
    rst => rst_valid,
    data_in => e_data_in,
    wr_en => e_wr_en,
    busy => e_busy,
    buffer_full => e_full,
    buffer_empty => e_empty,
    buffer_prog_full => e_prog_full,
    buffer_prog_full_val => std_logic_vector(to_unsigned(1000, 11)),  -- Doesn't really matter
    data_out => e_data_out,
    data_valid => e_dv,
    dropped_frame => e_dropped
  );

  ethernet_tx_inst : ethernet_tx PORT MAP(
    tx_clk => tx_clk_copy,
    rst => rst_valid,
    tx_er => tx_er,
    tx_data => tx_data,
    tx_en => tx_en,
    link_established => eth_link_established,
    reset_complete => eth_reset_complete,
    wr_en => e_dv,
    data_in => e_data_out
  );

  sine_gen_inst : sine_gen
  PORT MAP (
    clk => data_clk,
    pinc_in => sine_inc,
    sine => sine_out
  );

  sampling_fifo_inst : sampling_fifo
  PORT MAP (
    rst => rst_valid,
    wr_clk => samp_wr_clk,
    rd_clk => samp_rd_clk,
    din => samp_din,
    wr_en => samp_wr_en,
    rd_en => samp_rd_en,
    prog_full_thresh => std_logic_vector(to_unsigned(samp_frame_size, 11)), -- Sets when prog_full outputs high
    dout => samp_dout,
    full => samp_full,
    empty => samp_empty,
    prog_full => samp_prog_full
  );

end Behavioral;

