library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use unisim.vcomponents.all;

entity eth_master is
    Generic ( reset_count : positive := 100_000_000 );
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           tx_clk : in  STD_LOGIC;
           tx_er : out  STD_LOGIC;
           tx_en : out  STD_LOGIC;
           tx_data : out  STD_LOGIC_VECTOR (3 downto 0);
           smi_clk : out STD_LOGIC;
           smi_mdio : inout STD_LOGIC;
           leds : out  STD_LOGIC_VECTOR (7 downto 0);
           eth_rst_n : out  STD_LOGIC);
end eth_master;

architecture Behavioral of eth_master is

  signal tx_clk_copy, data_clk, smi_clk_buffered : std_logic;
  COMPONENT ethernet_dcm
    PORT ( 
      tx_clk25Mhz : in std_logic;
      tx_clk_copy : out std_logic;
      data_clk : out std_logic;
      smi_clk : out std_logic
    );
  END COMPONENT;

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
  
  signal udp_data_in, udp_data_out : std_logic_vector(7 downto 0);
  signal udp_wr_en, udp_prog_full, udp_full, udp_empty, udp_dv, udp_dropped, udp_busy : std_logic;
  COMPONENT udp_wrapper
  GENERIC( src_port : std_logic_vector(15 downto 0) := x"8000";
           dest_port : std_logic_vector(15 downto 0) := x"8000" );
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

  signal ip_data_in, ip_data_out : std_logic_vector(7 downto 0);
  signal ip_wr_en, ip_prog_full, ip_full, ip_empty, ip_dv, ip_dropped, ip_busy : std_logic;
  COMPONENT ip_wrapper
  GENERIC( src_ip : std_logic_vector(31 downto 0) := x"0a0a0a0a";
           dest_ip : std_logic_vector(31 downto 0) := x"0a0a0a0b" );
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

  signal e_data_in, e_data_out : std_logic_vector(7 downto 0);
  signal e_wr_en, e_prog_full, e_full, e_empty, e_dv, e_dropped, e_busy : std_logic;
  COMPONENT ethernet_wrapper_with_preamble
  GENERIC ( dest_mac : std_logic_vector(47 downto 0) := x"00252235fa3b";
            protocol : std_logic_vector(15 downto 0) := x"0800" );
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

  signal rst_sync : std_logic_vector(3 downto 0);
  signal rst_valid : std_logic;

  signal eth_link_established : std_logic;
  signal eth_reset_counter : unsigned(26 downto 0);
  signal eth_reset_complete : std_logic;

  signal zeros_gen_counter : unsigned(26 downto 0);
  signal zeros_gen_state : unsigned(0 downto 0);
  signal zeros_gen_actual_data : std_logic_vector(7 downto 0);
  
  signal fault : std_logic;
begin

  leds <= "01" & eth_link_established & eth_reset_complete & e_full & e_empty & e_dropped & fault;

  e_data_in <= ip_data_out;
  e_wr_en <= ip_dv;

  ip_data_in <= udp_data_out;
  ip_wr_en <= udp_dv;

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

  process(data_clk, rst_valid)
  begin
    if(rst_valid = '1') then
      zeros_gen_counter <= (others => '0');
      zeros_gen_state <= (others => '0');
      udp_wr_en <= '0';
      udp_data_in <= (others => '0');
      zeros_gen_actual_data <= (others => '0');
    elsif(rising_edge(data_clk)) then
      case to_integer(zeros_gen_state) is
        when 0 =>
          zeros_gen_counter <= zeros_gen_counter + 1;
          zeros_gen_actual_data <= std_logic_vector(unsigned(zeros_gen_actual_data) + 1);
          udp_data_in <= zeros_gen_actual_data;
          udp_wr_en <= '1';

          if(zeros_gen_counter = 24) then
            zeros_gen_counter <= (others => '0');
            zeros_gen_state <= to_unsigned(1, zeros_gen_state'length);
          end if;
        
        when 1 =>
          udp_wr_en <= '0';
          zeros_gen_counter <= zeros_gen_counter + 1;

          if(zeros_gen_counter = 500) then
            zeros_gen_state <= (others => '0');
            zeros_gen_counter <= (others => '0');
          end if;

        when others => 
          null;
      end case;
    end if;
  end process;

  process(clk)
  begin
    if(rising_edge(clk)) then
      rst_sync <= rst_sync(rst_sync'high - 1 downto 0) & rst;
      rst_valid <= rst_sync(rst_sync'high);
    end if;
  end process;

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

  dcm_inst : ethernet_dcm PORT MAP (
    tx_clk25MHz => tx_clk,
    tx_clk_copy => tx_clk_copy,
    data_clk => data_clk,
    smi_clk => smi_clk_buffered
  );

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
      addr => "0001",
      data_in => (others => '0'),
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
    buffer_prog_full_val => std_logic_vector(to_unsigned(1000, 11)),
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
    buffer_prog_full_val => std_logic_vector(to_unsigned(1000, 11)),
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
    buffer_prog_full_val => std_logic_vector(to_unsigned(1000, 11)),
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

end Behavioral;

