library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test is
  generic ( data_width : positive := 4);
  port ( clk : in std_logic;
         rst : in std_logic;
         --mdio : inout std_logic;
         --mdc : out std_logic;
         eth_rst : out std_logic;
         --collision : in std_logic;
         --crs : in std_logic;
         --rx_dv : in std_logic;
         --rx_clk : in std_logic;
         --rx_err : in std_logic;
         --rx_data : in std_logic_vector(data_width-1 downto 0);

         --gtx_clk : out std_logic;
         tx_clk : in std_logic;
         --tx_er : out std_logic;
         tx_en : out std_logic;
         tx_data : out std_logic_vector(data_width-1 downto 0);

         leds : out std_logic_vector(7 downto 0)
  );
end test;

architecture behave of test is

  signal reset_counter : integer range 0 to 100_000_000 - 1;

begin

  --mdio <= 'Z';
  --mdc <= '0';
  --tx_er <= '1';
  tx_en <= '0';
  tx_data <= (others => '0');

  leds(0) <= tx_clk;

  process(clk, rst)
  begin
    if(rst = '1') then
      eth_rst <= '1';
      reset_counter <= 0;
      leds(7 downto 1) <= "1010101";
    elsif(rising_edge(clk)) then
      if(reset_counter /= 100_000_000 - 1) then
        eth_rst <= '0';
        reset_counter <= reset_counter + 1;
        leds(7 downto 1) <= "1111000";
      else
        leds(7 downto 1) <= "0000111";
        eth_rst <= '1';
      end if;
    end if;
  end process;

end behave;
