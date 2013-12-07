library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity test is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           so : out  STD_LOGIC;
           si : in  STD_LOGIC;
           sck : out  STD_LOGIC;
           ce : out std_logic;
           leds : out std_logic_vector(7 downto 0));
end test;

architecture Behavioral of test is

	COMPONENT test_one
		PORT(
			clk : IN std_logic;
			rst : IN std_logic;
			start : IN std_logic;
			si : IN std_logic;
			we : IN std_logic;
			address : IN std_logic_vector(15 downto 0);
			data_in : IN std_logic_vector(7 downto 0);          
			so : OUT std_logic;
			sck : OUT std_logic;
			data_out : OUT std_logic_vector(7 downto 0);
			done : OUT std_logic
			);
	END COMPONENT;
	
--	component clkgen
--port
-- (-- Clock in ports
--  clk_100           : in     std_logic;
--  -- Clock out ports
--  clk_20          : out    std_logic
-- );
--end component;

	type state_t is (IDLE, SEND, WAITING, START1, ENABLE, START2, SEND2, WAITING2, REQUEST);
	signal state : state_t := IDLE;

	signal start : std_logic := '0';
	signal we : std_logic := '0';
	signal address : std_logic_vector(15 downto 0);
	signal data_in, data_out : std_logic_vector(7 downto 0);
	signal done : std_logic := '0';
	signal clk_20_in, clk_20 : std_logic := '0';
begin

--	IBUF_inst : IBUF 
--	generic map(
--		IBUF_LOW_PWR => FALSE,
--		IOSTANDARD => "LVCMOS33"
--	)
--	port map (
--		O => clk_20,
--		I => clk_20_in
--	);

	leds <= data_out;
	
	process(clk, rst)
		constant max : integer := (10000000/2) - 1;
--		constant max : integer := (8/2) - 1;
		variable counter : integer range 0 to max := 0;
	begin
		if(rst = '1') then
			counter := 0;
			clk_20 <= '0';
		elsif(rising_edge(clk)) then
			if(counter = max) then
				counter := 0;
				clk_20 <= not clk_20;
			else
				counter := counter + 1;
			end if;
		end if;
	end process;
				

--	your_instance_name : clkgen
--	  port map
--	   (-- Clock in ports
--	    clk_100 => clk,
--	    -- Clock out ports
--	    clk_20 => clk_20);

	Inst_test_one: test_one PORT MAP(
		clk => clk_20,
		rst => rst,
		start => start,
		so => so,
		si => si,
		sck => sck,
		we => we,
		address => address,
		data_in => data_in,
		data_out => data_out,
		done => done
	);
	
	
			
	process(clk, rst)
	begin
		if(rst = '1') then
			address <= (others => '0');
			data_in <= (others => '0');
			state <= IDLE;
			ce <= '1';
		elsif(rising_edge(clk)) then
			case state is
				when IDLE =>
					ce <= '1';
					state <= ENABLE;
				when ENABLE =>
					ce <= '0';
					state <= SEND;
				when SEND =>
					data_in <= x"7e";
					address <= x"0001";
					we <= '1';
					state <= START1;
				when START1 =>
					start <= '1';
					if(done = '0') then
						state <= WAITING;
					end if;
				when WAITING =>
					start <= '0';
					if(done = '1') then
						state <= REQUEST;
					end if;
				when REQUEST =>
					we <= '0';
					state <= START2;
				when START2 =>
					start <= '1';
					if(done = '0') then
						state <= WAITING2;
					end if;
				
				when WAITING2 =>
					start  <= '0';
					if(done = '1') then
						state <= IDLE;
					end if;
				when others =>
					null;
			end case;
		end if;
	end process;
end Behavioral;

