library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ALL;
use IEEE.NUMERIC_STD.ALL;

package vga is

	type vga_config is record
     h_sync : integer;
     h_color_valid : integer;
     h_front_porch : integer;
     h_back_porch : integer;

     v_sync : integer;
     v_color_valid : integer;
     v_front_porch : integer;
     v_back_porch : integer;
   end record;
	
	constant vga_640x480_60Hz_25MHz : vga_config := (
     h_sync => 96,
     h_front_porch => 16,
     h_back_porch => 48,
     h_color_valid => 640,
     v_sync => 2,
     v_front_porch => 10,
     v_back_porch => 33,
     v_color_valid => 480 );
	  
	constant vga_1920x1080_60Hz_182_5MHz : vga_config := (
     h_sync => 696,
     h_front_porch => 32,
     h_back_porch => 32,
     h_color_valid => 1920,
     v_sync => 11,
     v_front_porch => 22,
     v_back_porch => 22,
     v_color_valid => 1080 );


	function bit_length (max_value : integer) return integer;

end vga;

package body vga is

	function bit_length (max_value : integer) return integer is
   begin
		 return integer(ceil(log2(real(max_value))));
   end bit_length;
	
end vga;