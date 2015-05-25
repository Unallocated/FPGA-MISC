library IEEE;
use IEEE.STD_LOGIC_1164.all;

package frame_types is

	subtype byte is std_logic_vector(7 downto 0);
	type frame_t is array(0 to 31) of byte;

end frame_types;

package body frame_types is
 
end frame_types;

