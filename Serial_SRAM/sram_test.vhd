library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sram_test is
    Port ( clk  : in   STD_LOGIC;
           rst  : in   STD_LOGIC;
           leds : out  STD_LOGIC_VECTOR (7 downto 0);
           so   : out  STD_LOGIC;
           si   : in   STD_LOGIC;
           sck  : out  STD_LOGIC;
           cs   : out  STD_LOGIC);
end sram_test;

architecture Behavioral of sram_test is

	COMPONENT sram
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		si : IN std_logic;
		addr : IN std_logic_vector(15 downto 0);
		we : IN std_logic;
		start : IN std_logic;    
		data_out : out std_logic_vector(7 downto 0);  
		data_in : in std_logic_vector(7 downto 0);    
		sck : OUT std_logic;
		so : OUT std_logic;
		cs : OUT std_logic;
		done : OUT std_logic
		);
	END COMPONENT;
	
	signal slow_clk : std_logic := '0';
	signal data_in, data_out : std_logic_vector(7 downto 0) := x"7e";
	signal addr : std_logic_vector(15 downto 0) := x"1000";
	signal we : std_logic := '0';
	signal done : std_logic := '0';
	signal start : std_logic := '0';
	
	signal state : integer range 0 to 5 := 0;
begin

	process(clk, rst)
	begin
		if(rst = '1') then
			state <= 0;
		elsif(rising_edge(clk)) then
			if(state = 0) then
				if(done = '1') then
					we <= '1';
					start <= '1';
					state <= 1;
					data_in <= x"7e";
				end if;
			elsif(state = 1) then
				if(done = '0') then
					state <= 2;
					start <= '0';
				end if;
			elsif(state = 2) then
				if(done = '1') then
					state <= 3;
				end if;
			elsif(state = 3) then
				we <= '0';
				start <= '1';
				state <= 4;
			elsif(state = 4) then
				if(done = '0') then
					state <= 5;
					start <= '0';
				end if;
			elsif(state = 5) then
				if(done = '1') then
					state <= 0;
					leds <= data_out;
				end if;
			end if;
		end if;
	end process;

	process(clk, rst)
		variable counter : integer := 0;
	begin
		if(rst = '1') then
			counter := 0;
		elsif(rising_edge(clk)) then
			if(counter = 500000/2) then
				counter := 0;
				slow_clk <= not slow_clk;
			else
				counter := counter + 1;
			end if;
		end if;
	end process;
	
	Inst_sram: sram PORT MAP(
		clk => slow_clk,
		rst => rst,
		sck => sck,
		so => so,
		cs => cs,
		si => si,
		data_out => data_out,
		data_in => data_in,
		addr => addr,
		we => we,
		done => done,
		start => start
	);

end Behavioral;

