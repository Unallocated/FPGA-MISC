
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity virtex_55 is
    Port ( clk : in  STD_LOGIC;
				a_p : out STD_LOGIC;
				a_n : out STD_LOGIC;
           test : out  STD_LOGIC);
end virtex_55;

architecture Behavioral of virtex_55 is

	signal test_buf : std_logic := '1';

	COMPONENT t_pll
	PORT(
		CLKIN_IN : IN std_logic;          
		CLKFX_OUT : OUT std_logic;
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic
		);
	END COMPONENT;

	signal clk2 : std_logic;
	signal a : std_logic;
	

begin
	OBUFDS_inst : OBUFDS
		generic map (
		IOSTANDARD => "DEFAULT")
		port map (
		O => a_p, -- Diff_p output (connect directly to top-level port)
		OB => a_n, -- Diff_n output (connect directly to top-level port)
		I => a -- Buffer input
		);

	test <= test_buf;

	Inst_t_pll: t_pll PORT MAP(
		CLKIN_IN => clk,
		CLKFX_OUT => clk2,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => open
	);

	process(clk2)
	begin
		if(rising_edge(clk2)) then
			test_buf <= not test_buf;
		end if;
	end process;

end Behavioral;

