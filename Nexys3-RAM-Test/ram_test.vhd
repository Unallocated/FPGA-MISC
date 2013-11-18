library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram_test is
	Port(clk      : in    STD_LOGIC;
		 rst      : in    STD_LOGIC;
		 leds     : out   STD_LOGIC_VECTOR(7 downto 0);
		 ram_addr : out   STD_LOGIC_VECTOR(21 downto 0);
		 ram_data : inout STD_LOGIC_VECTOR(15 downto 0);
		 ram_clk  : out   STD_LOGIC;
--		 ram_wait : in    STD_LOGIC;
		 ram_lb   : out   STD_LOGIC;
		 ram_ub   : out   STD_LOGIC;
		 ram_ce   : out   STD_LOGIC;
		 ram_adv  : out   STD_LOGIC;
		 ram_cre  : out   STD_LOGIC;
		 ram_we   : out   STD_LOGIC;
		 ram_oe  : out   STD_LOGIC);
end ram_test;

architecture Behavioral of ram_test is
	COMPONENT clock_divider
		GENERIC(divide_by : integer);
		PORT(
			clk      : IN  std_logic;
			rst      : IN  std_logic;
			slow_clk : OUT std_logic
		);
	END COMPONENT;

	signal ram_state : integer   := 0;
	signal slow_clk  : std_logic := '0';

begin

	ram_cre <= '0';

	process(slow_clk, rst)
		variable data : integer range 0 to (2**16) - 1 := 0;
	begin
		if (rst = '1') then
			data := 127;
			ram_state <= 0;
			leds <= (others => '0');
		elsif (rising_edge(slow_clk)) then
			case ram_state is
				when 0 =>
					ram_we <= '1';
--					leds <= x"11";
					ram_adv <= '0';
					ram_clk <= '0';
					ram_oe <= '1';
					ram_addr <= "00" & x"0000f";
					ram_data <= std_logic_vector(to_unsigned(data,16));
				when 1 =>
--					leds <= x"22";
					ram_ce <= '0';
				when 2 =>
--					leds <= x"33";
					ram_lb <= '0';
					ram_ub <= '0';
				when 3 =>
--					leds <= x"44";
					ram_we <= '0';
				when 4 =>
--					leds <= x"55";
					ram_we <= '1';
				when 5 =>
					ram_data <= (others => '1');
--					leds <= x"66";
				when 6 =>
					ram_data <= (others => 'Z');
				when 7 =>
--					leds <= x"77";
					ram_ce <= '0';
					ram_oe <= '0';
				when 8 =>
					leds <= ram_data(7 downto 0);
					data := data + 1;
				when 9 =>
					ram_lb <= '1';
					ram_ub <= '1';
					ram_oe <= '1';
					ram_ce <= '1';
				when others =>
					null;
			end case;
			
			if(ram_state < 9) then
				ram_state <= ram_state + 1;
			else
				--null;
				ram_state <= 0;
			end if;
		end if;
	end process;

	clock_div : clock_divider
		Generic Map(divide_by => 10000000)
		PORT MAP(
			clk      => clk,
			rst      => rst,
			slow_clk => slow_clk
		);

end Behavioral;

