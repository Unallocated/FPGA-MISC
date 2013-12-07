LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

USE ieee.numeric_std.ALL;

ENTITY test_one_tb IS
END test_one_tb;

ARCHITECTURE behavior OF test_one_tb IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT test_one
		PORT(
			clk      : IN  std_logic;
			rst      : IN  std_logic;
			start    : IN  std_logic;
			so       : OUT std_logic;
			si       : IN  std_logic;
			sck      : OUT std_logic;
			we       : IN  std_logic;
			address  : IN  std_logic_vector(15 downto 0);
			data_in  : IN  std_logic_vector(7 downto 0);
			data_out : OUT std_logic_vector(7 downto 0);
			done     : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	signal clk     : std_logic                     := '0';
	signal rst     : std_logic                     := '0';
	signal start   : std_logic                     := '0';
	signal si      : std_logic                     := '0';
	signal we      : std_logic                     := '0';
	signal address : std_logic_vector(15 downto 0) := (others => '0');
	signal data_in : std_logic_vector(7 downto 0)  := (others => '0');

	--Outputs
	signal so       : std_logic;
	signal sck      : std_logic;
	signal data_out : std_logic_vector(7 downto 0);
	signal done     : std_logic;

	-- Clock period definitions
	constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut : test_one PORT MAP(
			clk      => clk,
			rst      => rst,
			start    => start,
			so       => so,
			si       => si,
			sck      => sck,
			we       => we,
			address  => address,
			data_in  => data_in,
			data_out => data_out,
			done     => done
		);

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
		-- hold reset state for 100 ns.
		wait for 100 ns;

		wait for clk_period * 10;
		
		data_in <= x"7e";
		address <= x"9ff9";
		we <= '0';
		wait for clk_period;
		start <= '1';
		wait for clk_period;
		start <= '0';
		wait until done = '1';
		wait for clk_period * 10;
		data_in <= x"55";
		address <= x"f00f";
		we <= '1';
		wait for clk_period;
		start <= '1';
		wait for clk_period;
		start <= '0';
		-- insert stimulus here 

		wait;
	end process;

END;
