library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.conv_std_logic_vector;
entity test is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           leds : out  STD_LOGIC_VECTOR (0 downto 0);
			  diff_pins : out STD_LOGIC_VECTOR(1 downto 0));
end test;

architecture Behavioral of test is
	
	signal led_buffer : std_logic_vector(leds'range) := (others => '0');
	signal diff_pins_buffer : std_logic_vector(diff_pins'range) := "01";
begin
	diff_pins <= diff_pins_buffer;
	leds <= led_buffer;
	process(clk, rst)
		variable counter : integer := 0;
	begin
		
		if(rst = '1') then
			counter := 0;
		elsif(rising_edge(clk)) then
			if(counter = 500000000) then
				counter := 0;
				led_buffer <= not led_buffer;
				diff_pins_buffer <= not diff_pins_buffer;
			else
				counter := counter + 1;
			end if;
		end if;
	end process;

end Behavioral;

