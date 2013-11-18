library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
	 Generic(divide_by : integer);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           slow_clk : out  STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

	signal slow_clk_buffer : std_logic := '0';

begin

	slow_clk <= slow_clk_buffer;

	process(clk, rst)
		variable counter : integer range 0 to (divide_by / 2) - 1 := 0;
	begin
		if(rst = '1') then
			counter := 0;
			slow_clk_buffer <= '0';
		elsif(rising_edge(clk)) then
			if(counter = (divide_by / 2) - 1) then
				slow_clk_buffer <= not slow_clk_buffer;
				counter := 0;
			else
				counter := counter + 1;
			end if;
		end if;
	end process;

end Behavioral;

