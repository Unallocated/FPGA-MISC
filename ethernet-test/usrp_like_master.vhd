library ieee;
library UNISIM;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use UNISIM.VComponents.all;

entity usrp_like_master is
  generic ( reset_clocks : natural := 100_000_000 );
  port ( clk : in std_logic;
         rst : in std_logic;
         eth_rst_n : out std_logic;
         eth_tx_data : out std_logic_vector(3 downto 0);
         eth_tx_en : out std_logic;
         eth_tx_er : out std_logic;
         eth_tx_clk : in std_logic;
         eth_smi_mdio : inout std_logic;
         eth_smi_clk : out std_logic;
         adc_data : in std_logic_vector(7 downto 0);
         adc_clk : out std_logic;
         sine_inc : in std_logic_vector(7 downto 0);
         sine_out : out std_logic_vector(7 downto 0);
         leds : out std_logic_vector(7 downto 0);
         add_offset : in std_logic;
         use_internal_ref : in std_logic);
end usrp_like_master;

architecture behave of usrp_like_master is
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

  signal eth_din : std_logic_vector(7 downto 0);
  signal eth_wr_en, eth_buffer_empty, eth_buffer_full, eth_link_established, eth_reset_complete : std_logic;

  COMPONENT usrp_like
  generic ( eth_width : positive := 4;
            eth_source : std_logic_vector((6 * 8) - 1 downto 0) := x"010203040506";
            eth_dest : std_logic_vector((6 * 8) - 1 downto 0) := x"00252235FA3B";
            ip_source : std_logic_vector((4 * 8) - 1 downto 0) := x"0A010101";
            ip_dest : std_logic_vector((4 * 8) - 1 downto 0) := x"0A010102";
            udp_source : std_logic_vector((2 * 8) - 1 downto 0) := x"1F98";
            udp_dest : std_logic_vector((2 * 8) - 1 downto 0) := x"1F98";
            payload_size : positive range 1 to 1400 := 600;
            reset_pause_cycles : positive := reset_clocks);
  PORT(
    clk : IN std_logic;
    rst : IN std_logic;
    eth_tx_clk : IN std_logic;
    data_in : IN std_logic_vector(7 downto 0);
    wr_en : IN std_logic;
    wr_clk : IN std_logic;    
    eth_rst_n : OUT std_logic;
    eth_tx_data : OUT std_logic_vector(3 downto 0);
    eth_tx_en : OUT std_logic;
    eth_tx_er : OUT std_logic;
    buffer_full : OUT std_logic;
    buffer_empty : OUT std_logic;
    eth_link_established : in std_logic;
    eth_rst_complete : out std_logic
    );
  END COMPONENT;

  signal add_offset_sync : std_logic_vector(2 downto 0);
  signal use_internal_ref_sync : std_logic_vector(2 downto 0);

  signal adc_clk_b, dds_clk, clk_copy, smi_clk : std_logic;
  component usrp_like_master_dcm
    port(
      clk           : in     std_logic;
      clk_copy          : out    std_logic;
      smi_clk          : out    std_logic;
      adc_clk          : out    std_logic;
      clk_out4          : out    std_logic
     );
  end component;

  signal sine_buffer : std_logic_vector(sine_out'range);
  COMPONENT sine_gen
    PORT (
      clk : IN STD_LOGIC;
      pinc_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

  function reverse_any_vector (a: in std_logic_vector)
  return std_logic_vector is
    variable result: std_logic_vector(a'RANGE);
    alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
  begin
    for i in aa'RANGE loop
      result(i) := aa(i);
    end loop;
    return result;
  end; -- function reverse_any_vector
  
  signal debounced_rst_sync : std_logic_vector(3 downto 0);
  signal debounced_rst : std_logic;
begin
--  adc_clk <= adc_clk_b;
--  eth_smi_clk <= smi_clk;
  leds <= "01" & eth_link_established & eth_buffer_full & eth_buffer_empty & eth_wr_en & eth_reset_complete & '1';
  sine_out <= sine_buffer;
  
  process(clk_copy)
  begin
	if(rising_edge(clk_copy)) then
		debounced_rst_sync <= debounced_rst_sync(debounced_rst_sync'high - 1 downto 0) & rst;
		debounced_rst <= debounced_rst_sync(debounced_rst_sync'high);
	end if;
  end process;
  
  ODDR2_adc_clk_inst : ODDR2
   generic map(
      DDR_ALIGNMENT => "NONE",
      INIT => '0',
      SRTYPE => "SYNC")
   port map (
      Q => adc_clk,    -- 1-bit output data
      C0 => adc_clk_b,       -- 1-bit clock input
      C1 => (NOT adc_clk_b), -- 1-bit clock input
      CE => '1',              -- 1-bit clock enable input
      D0 => '1',
      D1 => '0',
      R => '0',    -- 1-bit reset input
      S => '0'     -- 1-bit set input
   );
	
	ODDR2_smi_clk_inst : ODDR2
   generic map(
      DDR_ALIGNMENT => "NONE",
      INIT => '0',
      SRTYPE => "SYNC")
   port map (
      Q => eth_smi_clk,    -- 1-bit output data
      C0 => smi_clk,       -- 1-bit clock input
      C1 => (NOT smi_clk), -- 1-bit clock input
      CE => '1',              -- 1-bit clock enable input
      D0 => '1',
      D1 => '0',
      R => '0',    -- 1-bit reset input
      S => '0'     -- 1-bit set input
   );

  -- Simply asks for address "0001" which contains the link status flag
  -- which is needed to know if it's okay to TX packets.  You could probably
  -- get away with not checking the link status and just transmitting data
  -- that the PHY will ignore.
  -- The SMI_IDLE state is just a dumb state.  Any 'reset' logic between reads
  -- can go there.
  process(smi_clk, debounced_rst)
  begin
    if(debounced_rst = '1') then
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
              eth_link_established <= smi_dout(2);
              smi_state <= SMI_IDLE;
            end if;
        end case;
      end if;
    end if;
  end process;

  process(adc_clk_b, debounced_rst)
    variable temp : std_logic_vector(7 downto 0);
  begin
    if(debounced_rst = '1') then
      eth_wr_en <= '0';
      use_internal_ref_sync <= (others => '0');
      add_offset_sync <= (others => '0');
    elsif(rising_edge(adc_clk_b)) then
      eth_wr_en <= '0';
      if(eth_link_established = '1') then
        eth_wr_en <= '1';
        add_offset_sync <= add_offset_sync(add_offset_sync'high - 1 downto 0) & add_offset;
		  use_internal_ref_sync <= use_internal_ref_sync(use_internal_ref_sync'high - 1 downto 0) & use_internal_ref;
        if(use_internal_ref_sync(use_internal_ref_sync'high) = '0') then
          if(add_offset_sync(add_offset_sync'high) = '0') then
            temp := (std_logic_vector(unsigned(adc_data) + 128));
          else
            temp := (adc_data);
          end if;
        else
          if(add_offset_sync(add_offset_sync'high) = '0') then
            temp := (std_logic_vector(unsigned(sine_buffer) + 128));
          else
            temp := (sine_buffer);
          end if;
        end if;

        eth_din <= temp(3 downto 0) & temp(7 downto 4);
      end if;
    end if;
  end process;

  smi_ramlike_inst : smi_ramlike
    PORT MAP(
      clk => smi_clk,
      rst => debounced_rst,
      mdio => eth_smi_mdio,
      rd_en => smi_rd_en,
      wr_en => '0',
      addr => "0001",
      data_in => (others => '0'),
      data_out => smi_dout,
      working => smi_working,
      done => smi_done,
      rdy => smi_rdy);

  dcm_inst : usrp_like_master_dcm
  port map (
    clk => clk,
    clk_copy => clk_copy,
    smi_clk => smi_clk,
    adc_clk => adc_clk_b,
    clk_out4 => dds_clk);

  usrp_like_inst : usrp_like PORT MAP(
    clk => clk_copy,
    rst => debounced_rst,
    eth_rst_n => eth_rst_n,
    eth_tx_data => eth_tx_data,
    eth_tx_en => eth_tx_en,
    eth_tx_er => eth_tx_er,
    eth_tx_clk => eth_tx_clk,
    data_in => eth_din,
    wr_en => eth_wr_en,
    wr_clk => adc_clk_b,
    buffer_full => eth_buffer_full,
    buffer_empty => eth_buffer_empty,
    eth_link_established => eth_link_established,
    eth_rst_complete => eth_reset_complete
  );

  sine_gen_inst : sine_gen
  PORT MAP (
    clk => dds_clk,
    pinc_in => sine_inc,
    sine => sine_buffer
  );

end behave;
