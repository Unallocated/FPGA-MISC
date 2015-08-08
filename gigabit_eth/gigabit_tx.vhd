library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use unisim.vcomponents.all;

entity gigabit_tx is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           eth_mdio : inout  STD_LOGIC;
           eth_mdc : out  STD_LOGIC;
           eth_rst_n : out  STD_LOGIC;
           eth_col : in  STD_LOGIC;
           eth_crs : in  STD_LOGIC;
           eth_rx_dv : in  STD_LOGIC;
           eth_rx_clk : in  STD_LOGIC;
           eth_rx_err : in  STD_LOGIC;
           eth_rx_data : in  STD_LOGIC_VECTOR (7 downto 0);
           eth_tx_clk : out  STD_LOGIC;
           eth_tx_en : out  STD_LOGIC;
           eth_tx_err : out  STD_LOGIC;
           eth_tx_data : out  STD_LOGIC_VECTOR (7 downto 0);
           leds : out STD_LOGIC_VECTOR(7 downto 0);
           sw : in STD_LOGIC_VECTOR(4 downto 0);
           clk_out : out STD_LOGIC;
           toggle : in STD_LOGIC;
           test_out : out STD_LOGIC_VECTOR(7 downto 0));
end gigabit_tx;

architecture Behavioral of gigabit_tx is

  signal clk_copy, gtx_clk, gtx_clk_fb : std_logic;

  -- A lot of code that simply gets the value of the link established register of the PHY's SMI
  signal smi_working, smi_done, smi_rdy, smi_rd_en : std_logic;
  signal smi_dout : std_logic_vector(15 downto 0);
  type smi_state_t is (SMI_IDLE, SMI_WAIT_FOR_READY, SMI_START_READ, SMI_WAIT_BUSY, SMI_WAIT_DONE);
  signal smi_state : smi_state_t;
  COMPONENT smi_ramlike
    GENERIC ( hw_addr : std_logic_vector(4 downto 0) );
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      rd_en : IN std_logic;
      wr_en : IN std_logic;
      addr : IN std_logic_vector(4 downto 0);
      data_in : IN std_logic_vector(15 downto 0);
      mdio : INOUT std_logic;
      data_out : OUT std_logic_vector(15 downto 0);
      working : OUT std_logic;
      done : OUT std_logic;
      rdy : OUT std_logic
      );
  END COMPONENT;

  signal rst_valid : std_logic;
  signal rst_shift_reg : std_logic_vector(2 downto 0);

  subtype byte is std_logic_vector(7 downto 0);
  type header_t is array(0 to 21) of byte;
  
  constant header : header_t := (
    x"55", x"55", x"55", x"55", x"55", x"55", x"55", x"d5", 
    x"ff", x"ff", x"ff", x"ff", x"ff", x"ff",
    x"00", x"00", x"00", x"00", x"00", x"00", 
    x"00", x"01");

  type payload_t is array(0 to (48*2) + 1) of byte;
  constant payload : payload_t := (
    x"00", x"01", x"02", x"03", x"04", x"05", x"06", 
    x"07", x"08", x"09", x"0a", x"0b", x"0c", x"0d", 
    x"0e", x"0f", x"10", x"11", x"12", x"13", x"14", 
    x"15", x"16", x"17", x"18", x"19", x"1a", x"1b", 
    x"1c", x"1d", x"1e", x"1f", x"20", x"21", x"22", 
    x"23", x"24", x"25", x"26", x"27", x"28", x"29", 
    x"2a", x"2b", x"2c", x"2d", x"2e", x"2f", x"30",
    x"00", x"01", x"02", x"03", x"04", x"05", x"06", 
    x"07", x"08", x"09", x"0a", x"0b", x"0c", x"0d", 
    x"0e", x"0f", x"10", x"11", x"12", x"13", x"14", 
    x"15", x"16", x"17", x"18", x"19", x"1a", x"1b", 
    x"1c", x"1d", x"1e", x"1f", x"20", x"21", x"22", 
    x"23", x"24", x"25", x"26", x"27", x"28", x"29", 
    x"2a", x"2b", x"2c", x"2d", x"2e", x"2f", x"30");

  type crc_t is array(0 to 3) of byte;
  constant crc : crc_t := (x"1D", x"17", x"0A", x"63");

  signal pos_counter : integer;

  signal eth_reset_counter : integer range 0 to 100_000_000 - 1;
  signal eth_reset_complete : std_logic;


  signal smi_data : std_logic;
  signal smi_clk : std_logic;
  constant smi_clk_counter_max : integer := (100_000_000 / 1_000) - 1;
  signal smi_clk_counter : integer range 0 to smi_clk_counter_max;

  signal eth_link_established : std_logic;
  
  type state_t is (SEND_HEADER, SEND_PAYLOAD, SEND_CRC, STALL);
  signal state : state_t;
begin

  eth_tx_err <= '0';

  eth_rst_n <= eth_reset_complete;
  eth_mdc <= smi_clk;
  eth_mdio <= smi_data;
  clk_copy <= clk;
  clk_out <= clk;

  test_out(7) <= smi_clk;
  test_out(6) <= smi_data;
  test_out(5) <= smi_dout(2);
  test_out(4 downto 0) <= (others => '0');

  rst_valid <= rst_shift_reg(rst_shift_reg'high);

  leds <= (others => eth_link_established);
  
  process(gtx_clk, rst_valid)
  begin
    if(rst_valid = '1') then
      pos_counter <= 0;
      state <= SEND_HEADER;
      eth_tx_en <= '0';
      eth_tx_data <= (others => '0');
    elsif(rising_edge(gtx_clk)) then
      if(eth_link_established = '0') then
        pos_counter <= 0;
        state <= SEND_HEADER;
      else
        pos_counter <= pos_counter + 1;
        case state is
          when SEND_HEADER =>
            eth_tx_en <= '1';
            eth_tx_data <= header(pos_counter);

            if(pos_counter = 21) then
              state <= SEND_PAYLOAD;
              pos_counter <= 0;
            end if;

          when SEND_PAYLOAD =>
            eth_tx_data <= payload(pos_counter);

            if(pos_counter = 48) then
              state <= SEND_CRC;
              pos_counter <= 0;
            end if;

          when SEND_CRC =>
            eth_tx_data <= crc(pos_counter);
            --eth_tx_data <= x"7e";

            if(pos_counter = 3) then
              state <= STALL;
              pos_counter <= 0;
            end if;

          when STALL =>
            eth_tx_en <= '0';
            eth_tx_data <= (others => '0');

            if(pos_counter = 11) then
              state <= SEND_HEADER;
              pos_counter <= 0;
            end if;

        end case;
      end if;
    end if;
  end process;

  process(clk_copy)
  begin
    if(rising_edge(clk_copy)) then
      rst_shift_reg <= rst_shift_reg(rst_shift_reg'high - 1 downto 0) & rst;
    end if;
  end process;

  process(clk_copy, rst_valid)
  begin
    if(rst_valid = '1') then
      smi_clk <= '0';
      smi_clk_counter <= 0;
    elsif(rising_edge(clk_copy)) then
      if(eth_reset_complete = '1') then
        smi_clk_counter <= smi_clk_counter + 1;
        if(smi_clk_counter = smi_clk_counter_max) then
          smi_clk <= not smi_clk;
          smi_clk_counter <= 0;
        end if;
      end if;
    end if;
  end process;

  process(clk_copy, rst_valid)
  begin
    if(rst_valid = '1') then
      eth_reset_counter <= 0;
      eth_reset_complete <= '0';
    elsif(rising_edge(clk_copy)) then
      --if(eth_reset_counter = 100) then
      if(eth_reset_counter = 100_000_000 - 1) then
        eth_reset_complete <= '1';
      else
        eth_reset_counter <= eth_reset_counter + 1;
      end if;
    end if;
  end process;

  
  ODDR_eth_tx_clk_inst : ODDR
   generic map(
      DDR_CLK_EDGE => "OPPOSITE_EDGE",
      INIT => '0', 
      SRTYPE => "SYNC")
   port map (
      Q => eth_tx_clk, -- 1-bit DDR output
      C => gtx_clk, -- 1-bit clock input
      CE => '1', -- 1-bit clock enable input
      D1 => '1', -- 1-bit data input (positive edge)
      D2 => '0', -- 1-bit data input (negative edge)
      R => '0', -- 1-bit reset input
      S => '0' -- 1-bit set input
  );

  process(smi_clk, rst_valid)
  begin
    if(rst_valid = '1') then
      eth_link_established <= '0';
      smi_state <= SMI_IDLE;
      smi_rd_en <= '0';
    elsif(rising_edge(smi_clk)) then
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
              eth_link_established <= smi_dout(10);
              smi_state <= SMI_IDLE;
            end if;
        end case;
      end if;
    end if;
  end process;


  smi_ramlike_inst : smi_ramlike
    GENERIC MAP ( hw_addr => "00000" )
    PORT MAP(
      clk => smi_clk,
      rst => rst_valid,
      mdio => smi_data,
      rd_en => smi_rd_en,
      wr_en => '0',
      addr => sw(4 downto 0),
      data_in => (others => '0'),
      data_out => smi_dout,
      working => smi_working,
      done => smi_done,
      rdy => smi_rdy);

  DCM_BASE_inst : DCM_BASE
  generic map (
    CLKDV_DIVIDE => 2.0,
    CLKFX_DIVIDE => 4, 
    CLKFX_MULTIPLY => 5, 
    CLKIN_DIVIDE_BY_2 => FALSE, 
    CLKIN_PERIOD => 10.0, 
    CLKOUT_PHASE_SHIFT => "NONE", 
    CLK_FEEDBACK => "NONE", 
    DCM_PERFORMANCE_MODE => "MAX_SPEED", 
    DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", 
    DFS_FREQUENCY_MODE => "LOW", 
    DLL_FREQUENCY_MODE => "LOW", 
    DUTY_CYCLE_CORRECTION => TRUE, 
    FACTORY_JF => X"F0F0", 
    PHASE_SHIFT => 0, 
    STARTUP_WAIT => FALSE
  )
  port map (
    CLK0 => open, 
    CLK180 => open, 
    CLK270 => open, 
    CLK2X => open, 
    CLK2X180 => open, 
    CLK90 => open, 
    CLKDV => open, 
    CLKFX => gtx_clk, 
    CLKFX180 => open, 
    LOCKED => open, 
    CLKFB => gtx_clk_fb, 
    CLKIN => clk_copy, 
    RST => rst_valid
  );

--  clk_mgr_inst : clock_mgr 
--  PORT MAP (
--    clk_100 => clk,
--    clk_100_copy => clk_copy,
--    clk_125 => gtx_clk
--  );

end Behavioral;

