library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_test is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_clk : out  STD_LOGIC;
           data_out : out std_logic_vector(7 downto 0);
           data_out_clk : out std_logic;
           en : in std_logic);
end clk_test;

architecture Behavioral of clk_test is

begin
process(clk, rst)
		variable counter : unsigned(1 downto 0) := (others => '0');
	begin
		if(rst = '1') then
			data_clk <= '0';
			data_out <= (others => '0');
			data_out_clk <= '0';
			counter := (others => '0'); 
		elsif(rising_edge(clk)) then
			data_clk <= '0';
			data_out_clk <= '0';
			
			if(counter = 0) then
				data_clk <= '1';
			elsif(counter = 1) then
				data_out <= data_in;
			elsif(counter = 2) then
				data_out_clk <= '1';
			end if;
			
			counter := counter + 1;
		end if;
	end process;	


end Behavioral;

