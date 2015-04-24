library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity usrp_like is
  generic ( eth_width : positive := 4;
            eth_source : std_logic_vector((6 * 8) - 1 downto 0) := x"010203040506";
            eth_dest : std_logic_vector((6 * 8) - 1 downto 0) := x"FFFFFFFFFFFF";
            ip_source : std_logic_vector((4 * 8) - 1 downto 0) := x"0A010101";
            ip_dest : std_logic_vector((4 * 8) - 1 downto 0) := x"FFFFFFFF";
            udp_source : std_logic_vector((2 * 8) - 1 downto 0) := x"1F98";
            udp_dest : std_logic_vector((2 * 8) - 1 downto 0) := x"1F98";
            payload_size : positive range 40 to 1400 := 600;
            reset_pause_cycles : positive := 100_000_000);
  port ( clk : in std_logic;
         rst : in std_logic;
         eth_rst_n : out std_logic;
         eth_tx_data : out std_logic_vector(eth_width-1 downto 0);
         eth_tx_er : out std_logic;
         eth_tx_clk : in std_logic;
         eth_smi_mdio : inout std_logic;
         eth_smi_clk : out std_logic;
         debugging : out std_logic_vector(7 downto 0);
         data_in : in std_logic_vector(7 downto 0);
         wr_en : in std_logic;
         wr_clk : in std_logic;
         buffer_full : out std_logic;
         buffer_empty : out std_logic );
end usrp_like;

architecture behave of usrp_like is

  function nibbleReverse(data : in std_logic_vector((50 * 8) - 1 downto 0)) return std_logic_vector is
    variable temp : std_logic_vector(data'range) := (others => '0');
    variable pos : integer range 0 to data'length := data'high;
  begin
    for i in (data'length/8) - 1 downto 0 loop
      temp(pos downto pos-3) := data(pos-4 downto pos-7);
      temp(pos-4 downto pos-7) := data(pos downto pos-3);
      if(pos > 8) then
        pos := pos - 8;
      end if;
    end loop;

    return temp;
  end nibbleReverse;

  function calculateIPChecksum(data : in std_logic_vector(159 downto 0)) return std_logic_vector is
    variable temp : unsigned(31 downto 0) := (others => '0');
    variable cs : std_logic_vector(31 downto 0) := (others => '0');
  begin
    temp := unsigned(x"0000" & data(159 downto 144)) + 
            unsigned(x"0000" & data(143 downto 128)) + 
            unsigned(x"0000" & data(127 downto 112)) + 
            unsigned(x"0000" & data(111 downto 96)) + 
            unsigned(x"0000" & data(95 downto 80)) + 
            unsigned(x"0000" & data(79 downto 64)) + 
            unsigned(x"0000" & data(63 downto 48)) + 
            unsigned(x"0000" & data(47 downto 32)) + 
            unsigned(x"0000" & data(31 downto 16)) + 
            unsigned(x"0000" & data(15 downto 0));

    cs := not std_logic_vector((x"0000" & temp(15 downto 0)) + temp(30 downto 16));
    return cs(15 downto 0);
  end calculateIPChecksum;

  function buildIPHeader(data : in std_logic_vector(159 downto 0)) return std_logic_vector is
    variable temp : std_logic_vector(data'range);
  begin
    temp := data;
    temp(79 downto 64) := calculateIPChecksum(data);

    return temp;
  end buildIPHeader;

  function neededBits (max : integer) return integer is
    variable vec : integer := integer(ceil(log2(real(max) + 1.0)));
  begin
    return vec;
  end neededBits;

  constant eth_header_preamble : std_logic_vector((8 * 8) - 1 downto 0) := x"555555555555555D";
  constant eth_link_type       : std_logic_vector(15 downto 0) := x"0800";
  constant eth_header          : std_logic_vector((eth_header_preamble'length + eth_dest'length + eth_source'length + eth_link_type'length) - 1 downto 0) := eth_header_preamble & eth_dest & eth_source & eth_link_type; 
  constant ip_header           : std_logic_vector((20 * 8) - 1 downto 0) := buildIPHeader(x"45_00" & std_logic_vector(to_unsigned(payload_size + 20 + 8, 16)) & x"0000_0000_FF_11_0000" & ip_source & ip_dest);
  constant udp_header          : std_logic_vector((8 * 8) - 1 downto 0) := udp_source & udp_dest & std_logic_vector(to_unsigned(payload_size + 8, 16)) & x"0000";
  constant packet_header       : std_logic_vector((eth_header'length + ip_header'length + udp_header'length) - 1 downto 0) := nibbleReverse(eth_header & ip_header & udp_header);

  signal orig_clk, smi_clk, smi_clk_ce : std_logic;
  COMPONENT usrp_like_dcm
    PORT (
      clk_100mhz : IN STD_LOGIC;
      orig_clk : OUT STD_LOGIC;
      smi_clk_CE : IN STD_LOGIC;
      smi_clk : OUT STD_LOGIC;
      rst : IN STD_LOGIC
     );
  END COMPONENT;

  signal smi_working, smi_done, smi_rdy, smi_rd_en : std_logic;
  signal smi_dout : std_logic_vector(15 downto 0);
  signal eth_link_established : std_logic;
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

  signal buffer_rd_en, buffer_prog_full : std_logic;
  signal buffer_dout : std_logic_vector(3 downto 0);
  COMPONENT usrp_like_buffer
    PORT (
      rst : IN STD_LOGIC;
      wr_clk : IN STD_LOGIC;
      rd_clk : IN STD_LOGIC;
      din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en : IN STD_LOGIC;
      rd_en : IN STD_LOGIC;
      prog_full_thresh : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
      dout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      full : OUT STD_LOGIC;
      empty : OUT STD_LOGIC;
      prog_full : OUT STD_LOGIC
    );
  END COMPONENT;

  type reset_state_t is (RESET_COUNT, RESET_COMPLETE);
  signal reset_state : reset_state_t;
  
  signal reset_counter : unsigned(neededBits(reset_pause_cycles-1) - 1 downto 0);
  signal eth_reset_complete : std_logic;

  type eth_transmit_state_t is (WAIT_FOR_DATA, SEND_ETH_PREAMBLE, SEND_ETH_HEADER, SEND_IP_HEADER, SEND_UDP_HEADER, SEND_PAYLOAD, SEND_ETH_CRC, PACKET_GAP);
  signal eth_transmit_state : eth_transmit_state_t;

begin

  process(eth_tx_clk, rst)
  begin
    if(rst = '1') then
      eth_transmit_state <= WAIT_FOR_DATA;
    elsif(rising_edge(eth_tx_clk)) then
      if(eth_reset_complete = '1' and eth_link_established = '1') then
        --case eth_transmit_state is
          --when WAIT_FOR_DATA =>
            
      end if;
    end if;
  end process;

  -- Simply asks for address "0001" which contains the link status flag
  -- which is needed to know if it's okay to TX packets.  You could probably
  -- get away with not checking the link status and just transmitting data
  -- that the PHY will ignore.
  -- The SMI_IDLE state is just a dumb state.  Any 'reset' logic between reads
  -- can go there.
  process(smi_clk, rst)
  begin
    if(rst = '1') then
      eth_link_established <= '0';
      smi_state <= SMI_IDLE;
    elsif(rising_edge(smi_clk)) then
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
  end process;

  -- The ethernet reset line needs to be held low for a minimum
  -- period of time.  This time is specify at instantiation time
  -- by a generic parameter 'reset_pause_cycles'.  The wait is 
  -- actually one cycle past that value since 0 counts.  No biggie.
  -- While there is a minimum period of time to wait, there is no max.
  process(orig_clk, rst)
  begin
    if(rst = '1') then

      reset_counter <= (others => '0');
      eth_rst_n <= '1';
      eth_reset_complete <= '0';
      reset_state <= RESET_COUNT;

    elsif(rising_edge(orig_clk)) then

      case reset_state is

        when RESET_COUNT =>
          reset_counter <= reset_counter + 1;
          eth_rst_n <= '0';
          eth_reset_complete <= '1';
          if(reset_counter = reset_pause_cycles) then
            reset_state <= RESET_COMPLETE;
            reset_counter <= (others => '0');
          end if;

        when RESET_COMPLETE =>
          eth_rst_n <= '1';
          eth_reset_complete <= '1';

      end case;

    end if;
  end process;


  -- FIFO that will hold data until it's time to transmit.  
  data_buffer_inst : usrp_like_buffer
    PORT MAP (
      rst => rst,
      wr_clk => wr_clk,
      rd_clk => eth_tx_clk,
      din => data_in(3 downto 0) & data_in(7 downto 4),
      wr_en => wr_en,
      rd_en => buffer_rd_en,
      prog_full_thresh => std_logic_vector(to_unsigned(payload_size,14)),
      dout => buffer_dout,
      full => buffer_full,
      empty => buffer_empty,
      prog_full => buffer_prog_full
    );

  smi_ramlike_inst : smi_ramlike 
    PORT MAP(
      clk => smi_clk,
      rst => rst,
      mdio => eth_smi_mdio,
      rd_en => smi_rd_en,
      wr_en => '0',
      addr => "0001",
      data_in => (others => '0'),
      data_out => smi_dout,
      working => smi_working,
      done => smi_done,
      rdy => smi_rdy);  

  dcm_inst : usrp_like_dcm
    PORT MAP (
      clk_100mhz => clk,
      orig_clk => orig_clk,
      smi_clk_CE => eth_reset_complete,
      smi_clk => smi_clk,
      rst  => rst);


  
end behave;
