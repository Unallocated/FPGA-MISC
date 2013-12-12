LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY clk_test_tb IS
END clk_test_tb;

ARCHITECTURE behavior OF clk_test_tb IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT clk_test
		PORT(
			clk      : IN  std_logic;
			rst      : IN  std_logic;
			data_in  : IN  std_logic_vector(7 downto 0);
			data_clk : OUT std_logic;
			en       : in std_logic;
			data_out : out std_logic_vector(7 downto 0);
			data_out_clk : out std_logic
		);
	END COMPONENT;

	--Inputs
	signal clk,data_out_clk, en     : std_logic                    := '0';
	signal rst     : std_logic                    := '0';
	signal data_in, data_out : std_logic_vector(7 downto 0) := (others => '0');

	--Outputs
	signal data_clk : std_logic;

	-- Clock period definitions
	constant clk_period : time := 1 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut : clk_test PORT MAP(
			clk      => clk,
			rst      => rst,
			data_in  => data_in,
			data_clk => data_clk,
			en       => en,
			data_out => data_out,
			data_out_clk => data_out_clk
		);

	process(data_clk)
		variable c : unsigned(7 downto 0) := (others => '0');
	begin
		if(rising_edge(data_clk) and en = '1') then
			data_in <= std_logic_vector(c);
			c := c + 1;
		end if;
	end process;

	-- Clock process definitions
	clk_process : process
	begin
		clk <= '0';
		wait for clk_period / 2;
		clk <= '1';
		wait for clk_period / 2;
	end process;

	-- Stimulus process
	stim_proc : process
	begin
		en <= '0';
		-- hold reset state for 100 ns.
		wait for 100 ns;
		
		en <= '1';
		
		wait for 100ns;

		-- insert stimulus here 

		wait;
	end process;

END;
