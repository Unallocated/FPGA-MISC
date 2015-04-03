library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ethernet is
	port ( clk : in std_logic;
		   rst : in std_logic;
		   mdio : inout std_logic;
		   mdc : out std_logic;
		   int : out std_logic;
		   eth_rst : out std_logic;
		   collision : in std_logic;
		   crs : in std_logic;
		   rx_dv : in std_logic;
		   rx_clk : in std_logic;
		   rx_err : in std_logic;
		   rx_data : in std_logic_vector(7 downto 0);
		   
		   gtx_clk : out std_logic;
		   tx_clk : in std_logic;
		   tx_er : out std_logic;
		   tx_en : out std_logic;
		   tx_data : out std_logic_vector(7 downto 0)
	);
end ethernet;

architecture behave of ethernet is
	
begin
	
end behave;