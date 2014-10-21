library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adc is
	 Port ( clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
			  sck : out  STD_LOGIC;
			  d_in : in  STD_LOGIC;
			  ce : out  STD_LOGIC;
			  hs : out STD_LOGIC;
			  vs : out STD_LOGIC;
			  red : out STD_LOGIC_VECTOR(2 downto 0);
			  green : out STD_LOGIC_VECTOR(2 downto 0);
			  blue : out STD_LOGIC_VECTOR(1 downto 0);
			  leds : out STD_LOGIC_VECTOR(7 downto 0));
end adc;

architecture Behavioral of adc is

	COMPONENT vga_solid
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		blue_in : IN std_logic_vector(1 downto 0);
		red_in : IN std_logic_vector(2 downto 0);
		green_in : IN std_logic_vector(2 downto 0);          
		hs : OUT std_logic;
		vs : OUT std_logic;
		red : OUT std_logic_vector(2 downto 0);
		blue : OUT std_logic_vector(1 downto 0);
		green : OUT std_logic_vector(2 downto 0);
		x : OUT integer;
		y : OUT integer
		);
	END COMPONENT;
	
	component clock_manager
	port
	 (-- Clock in ports
	  CLK_IN1           : in     std_logic;
	  -- Clock out ports
	  CLK_OUT1          : out    std_logic;
	  CLK_OUT2          : out    std_logic;
	  -- Status and control signals
	  RESET             : in     std_logic
	 );
	end component;

	signal clk2, vga_clk : std_logic := '0';

	signal clock_counter : unsigned(31 downto 0) := (others => '0');
	signal slow_clk : std_logic := '0';

	type state_t is (CE_LOW, DUMMY_CLOCKS, DATA_CLOCKS, CE_HIGH);
	signal state : state_t := CE_LOW;

	signal state_counter : unsigned(3 downto 0) := (others => '0');
	signal sck_buffer : std_logic := '0';

	signal analog_value : unsigned(9 downto 0) := (others => '0');
	
	signal x, y : integer := 0;
	signal red_in, green_in : std_logic_vector(2 downto 0) := (others => '0');
	signal blue_in : std_logic_vector(1 downto 0) := (others => '0');
begin

	sck <= sck_buffer;
	
	process(slow_clk, rst)
	begin
		if(rst = '1') then
			state <= CE_LOW;
		elsif(rising_edge(slow_clk)) then
			case state is
				when CE_LOW =>
					ce <= '0';
					state <= DUMMY_CLOCKS;
					state_counter <= to_unsigned(3, state_counter'length);
				when DUMMY_CLOCKS =>
					if(sck_buffer = '1') then
						sck_buffer <= '0';
					else
						if(state_counter = (state_counter'range => '0')) then
							state <= DATA_CLOCKS;
							state_counter <= to_unsigned(9, state_counter'length);
							sck_buffer <= '1';
						else
							state_counter <= state_counter - 1;
							sck_buffer <= '1';
						end if;
					end if;
				when DATA_CLOCKS =>
					if(sck_buffer = '1') then
						analog_value(to_integer(state_counter)) <= d_in;
						sck_buffer <= '0';
					else
						if(state_counter = (state_counter'range => '0')) then
							state <= CE_HIGH;
							leds <= std_logic_vector(analog_value(9 downto 2));
							
						else
							state_counter <= state_counter - 1;
							sck_buffer <= '1';
						end if;
					end if;
				when CE_HIGH =>
					state <= CE_LOW;
					ce <= '1';
			end case;
		end if;
	end process;

	process(clk2, rst)
	begin
		if(rst = '1') then
			clock_counter <= (others => '0');
			slow_clk <= '0';
		elsif(rising_edge(clk2)) then
			if(clock_counter = to_unsigned(100-1, clock_counter'length)) then
				clock_counter <= (others => '0');
				slow_clk <= '1';
			else
				clock_counter <= clock_counter + 1;
				slow_clk <= '0';
			end if;
		end if;
	end process;
	
	process(vga_clk, rst)
	begin
		if(rst = '1') then
			blue_in <= (others => '0');
		elsif(rising_edge(vga_clk)) then
			if(x <= to_integer(analog_value(9 downto 1))) then
				blue_in <= (others => '1');
			else
				blue_in <= (others => '0');
			end if;
		end if;
	end process;
	
	Inst_vga_solid: vga_solid PORT MAP(
		clk => vga_clk,
		rst => rst,
		hs => hs,
		vs => vs,
		red => red,
		blue => blue,
		green => green,
		x => x,
		y => y,
		blue_in => blue_in,
		red_in => red_in,
		green_in => green_in
	);
	
	clk_inst : clock_manager
	  port map
		(-- Clock in ports
		 CLK_IN1 => clk,
		 -- Clock out ports
		 CLK_OUT1 => vga_clk,
		 CLK_OUT2 => clk2,
		 -- Status and control signals
		 RESET  => rst);

end Behavioral;