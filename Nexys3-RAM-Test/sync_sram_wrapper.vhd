library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sync_sram_wrapper is
	Port(clk      : in    STD_LOGIC;
		 rst      : in    STD_LOGIC;
		 ram_addr : out   STD_LOGIC_VECTOR(21 downto 0);
		 ram_data : inout STD_LOGIC_VECTOR(15 downto 0);
		 ram_clk  : out   STD_LOGIC;
		 ram_lb   : out   STD_LOGIC;
		 ram_ub   : out   STD_LOGIC;
		 ram_ce   : out   STD_LOGIC;
		 ram_adv  : out   STD_LOGIC;
		 ram_cre  : out   STD_LOGIC;
		 ram_we   : out   STD_LOGIC;
		 ram_oe   : out   STD_LOGIC;
		 leds     : out   STD_LOGIC_VECTOR(7 downto 0));
end sync_sram_wrapper;

architecture Behavioral of sync_sram_wrapper is
	
	COMPONENT sync_sram
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		data_in : IN std_logic_vector(15 downto 0);
		addr : IN std_logic_vector(21 downto 0);
		start : IN std_logic;
		we : IN std_logic;    
		ram_data : INOUT std_logic_vector(15 downto 0);      
		ram_addr : OUT std_logic_vector(21 downto 0);
		ram_clk : OUT std_logic;
		ram_lb : OUT std_logic;
		ram_ub : OUT std_logic;
		ram_ce : OUT std_logic;
		ram_adv : OUT std_logic;
		ram_cre : OUT std_logic;
		ram_we : OUT std_logic;
		ram_oe : OUT std_logic;
		data_out : OUT std_logic_vector(15 downto 0);
		done : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT clock_divider
		GENERIC(divide_by : integer);
		PORT(
			clk      : IN  std_logic;
			rst      : IN  std_logic;
			slow_clk : OUT std_logic
		);
	END COMPONENT;
	
	signal data_in, data_out : std_logic_vector(15 downto 0);
	signal addr : std_logic_vector(21 downto 0);
	signal start, done, we, slow_clk : std_logic := '0';

begin

	process(slow_clk, rst)
		variable state : integer := 0;
	begin
		if(rst = '1') then
			state := 0;
		elsif(rising_edge(slow_clk)) then
			case state is
				when 0 =>
					leds <= x"11";
					addr <= "00" & x"0000f";
					data_in <= x"7e7e";
					we <= '1';
					state := 1;
				when 1 =>
					leds <= x"22";
					start <= '1';
					state := 2;
				when 2 =>
					if(done = '0') then
						state := 3;
					end if;
				when 3 =>
					leds <= x"33";
					if(done = '1') then
						state := 4;
						start <= '0';
						we <= '0';
					end if;
				when 4 =>
					leds <= x"44";
					start <= '1';
					state := 5;
				when 5 =>
					leds <= x"55";
					if(done = '1') then
						leds <= x"66";
--						leds <= data_out(7 downto 0);
					end if;
				when others =>
					null;
			end case;
		end if;
	end process;
			

	Inst_sync_sram: sync_sram PORT MAP(
		clk => slow_clk,
		rst => rst,
		ram_addr => ram_addr,
		ram_data => ram_data,
		ram_clk => ram_clk,
		ram_lb => ram_lb,
		ram_ub => ram_ub,
		ram_ce => ram_ce,
		ram_adv => ram_adv,
		ram_cre => ram_cre,
		ram_we => ram_we,
		ram_oe => ram_oe,
		data_in => data_in,
		addr => addr,
		data_out => data_out,
		done => done,
		start => start,
		we => we
	);
	
	clock_div : clock_divider
		Generic Map(divide_by => 1000000)
		PORT MAP(
			clk      => clk,
			rst      => rst,
			slow_clk => slow_clk
		);

end Behavioral;

