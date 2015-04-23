library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity usrp_like is
  generic ( eth_width : positive := 4;
            eth_source : std_logic_vector((6 * 8) - 1 downto 0) := x"010203040506";
            eth_dest : std_logic_vector((6 * 8) - 1 downto 0) := x"FFFFFFFFFFFF";
            ip_source : std_logic_vector((4 * 8) - 1 downto 0) := x"0A010101";
            ip_dest : std_logic_vector((4 * 8) - 1 downto 0) := x"FFFFFFFF";
            udp_source : std_logic_vector((2 * 8) - 1 downto 0) := x"1F98";
            udp_dest : std_logic_vector((2 * 8) - 1 downto 0) := x"1F98";
            payload_size : positive range 40 to 1400 := 600);
  port ( clk : in std_logic;
         rst : in std_logic;
         eth_tx_data : out std_logic_vector(eth_width-1 downto 0);
         eth_tx_er : out std_logic;
         eth_tx_clk : in std_logic;
         eth_smi_mdio : inout std_logic;
         eth_smi_clk : out std_logic;
         leds : out std_logic_vector(7 downto 0);
         sine_out : out std_logic_vector(7 downto 0);
         adc_clk : out std_logic;
         adc_data : in std_logic_vector(7 downto 0));
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

  constant eth_header_preamble : std_logic_vector((8 * 8) - 1 downto 0) := x"555555555555555D";
  constant eth_link_type : std_logic_vector(15 downto 0) := x"0800";
  constant eth_header : std_logic_vector((eth_header_preamble'length + eth_dest'length + eth_source'length + eth_link_type'length) - 1 downto 0) := eth_header_preamble & eth_dest & eth_source & eth_link_type; 
  constant ip_header : std_logic_vector((20 * 8) - 1 downto 0) := buildIPHeader(x"45_00" & std_logic_vector(to_unsigned(payload_size + 20 + 8, 16)) & x"0000_0000_FF_11_0000" & ip_source & ip_dest);
  constant udp_header : std_logic_vector((8 * 8) - 1 downto 0) := udp_source & udp_dest & std_logic_vector(to_unsigned(payload_size + 8, 16)) & x"0000";
  constant packet_header : std_logic_vector((eth_header'length + ip_header'length + udp_header'length) - 1 downto 0) := nibbleReverse(eth_header & ip_header & udp_header);

begin

  leds <= (others => '0');
  
end behave;
