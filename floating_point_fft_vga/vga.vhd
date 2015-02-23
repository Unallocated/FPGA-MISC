library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga is
  GENERIC (
    config : vga_timing := vga_25mhz_640x480;
    red_width : positive := 3;
    green_width : positive := 3;
    blue_width : positive := 2
  );

  PORT (
    clk : in std_logic;
    rst : in std_logic;
    hs : out std_logic;
    vs : out std_logic;
    red : out std_logic_vector(red_width - 1 downto 0);
    green : out std_logic_vector(green_width - 1 downto 0);
    blue : out std_logic_vector(blue_width - 1 downto 0);
    h_blanking : out std_logic;
    v_blanking : out std_logic;
    x_pos : out integer;
    y_pos : out integer;
    red_in : out std_logic_vector(red_width - 1 downto 0);
    green_in : out std_logic_vector(green_width - 1 downto 0);
    blue_in : out std_logic_vector(blue_width - 1 downto 0)
  );
end vga;

architecture behave of vga is

begin

end behave;
