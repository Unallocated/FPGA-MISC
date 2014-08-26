library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.vga.all;

entity vga_solid is
	generic(vga_conf : vga_config := vga_640x480_60Hz_25MHz;
			  red_width : integer := 3;
			  blue_width : integer := 2;
			  green_width : integer := 3);
	Port(clk     : in  STD_LOGIC;
		 rst      : in  STD_LOGIC;
		 hs       : out STD_LOGIC;
		 vs       : out STD_LOGIC;
		 red      : out STD_LOGIC_VECTOR(red_width - 1 downto 0);
		 blue     : out STD_LOGIC_VECTOR(blue_width - 1 downto 0);
		 green    : out STD_LOGIC_VECTOR(green_width - 1 downto 0);
		 x        : out integer range 0 to vga_conf.h_color_valid - 1;
		 y        : out integer range 0 to vga_conf.v_color_valid - 1;
		 blue_in  : in STD_LOGIC_VECTOR(blue_width - 1 downto 0);
		 red_in   : in STD_LOGIC_VECTOR(red_width - 1 downto 0);
		 green_in : in STD_LOGIC_VECTOR(green_width - 1 downto 0));
end vga_solid;

architecture Behavioral of vga_solid is

	constant h_counter_max : integer := vga_conf.h_sync + vga_conf.h_color_valid + vga_conf.h_back_porch + vga_conf.h_front_porch;
	constant v_counter_max : integer := vga_conf.v_sync + vga_conf.v_color_valid + vga_conf.v_back_porch + vga_conf.v_front_porch;
	
	signal h_counter : unsigned(bit_length(h_counter_max) - 1 downto 0) := (others => '0');
	signal v_counter : unsigned(bit_length(v_counter_max) - 1 downto 0) := (others => '0');
	
	signal x_pos : integer range 0 to vga_conf.h_color_valid - 1;
	signal y_pos : integer range 0 to vga_conf.v_color_valid - 1;

begin
	
	x <= x_pos;
	y <= y_pos;
	
	process(clk, rst)
	begin
		if (rst = '1') then
			h_counter <= (others => '0');
			v_counter <= (others => '0');
		elsif (rising_edge(clk)) then
			if (h_counter = h_counter_max - 1) then
				h_counter <= (others => '0');
				if (v_counter = v_counter_max - 1) then
					v_counter <= (others => '0');
				else
					v_counter <= v_counter + 1;
				end if;
			else
				h_counter <= h_counter + 1;
			end if;

			if (h_counter < vga_conf.h_sync) then
				hs <= '0';
			else
				hs <= '1';
			end if;

			if (v_counter < vga_conf.v_sync) then
				vs <= '0';
			else
				vs <= '1';
			end if;

			if (h_counter > vga_conf.h_sync + vga_conf.h_back_porch 
					and h_counter < vga_conf.h_sync + vga_conf.h_back_porch + vga_conf.h_color_valid 
					and v_counter > vga_conf.v_sync + vga_conf.v_back_porch 
					and v_counter < vga_conf.v_sync + vga_conf.v_back_porch  + vga_conf.v_color_valid) then
					
				x_pos <= to_integer(h_counter) - vga_conf.h_sync - vga_conf.h_back_porch;
				y_pos <= to_integer(v_counter) - vga_conf.v_sync - vga_conf.v_back_porch;
				
				red <= red_in;
				blue <= blue_in;
				green <= green_in;
				
			else
				x_pos <= 0;
				y_pos <= 0;
				red   <= (others => '0');
				green <= (others => '0');
				blue  <= (others => '0');
			end if;
		end if;
	end process;
	

end Behavioral;




