library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.conv_std_logic_vector;
entity test2 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           sck : out  STD_LOGIC;
           so : out  STD_LOGIC;
           si : in  STD_LOGIC;
           leds : out STD_LOGIC_VECTOR(7 downto 0);
           cs : out  STD_LOGIC);
end test2;

architecture Behavioral of test2 is

	signal slow_clk : std_logic := '0';
	constant data : std_logic_vector(0 to 7) := x"ff";
	constant addr : std_logic_vector(0 to 15) := x"0001";
	constant read : std_logic_vector(0 to 7) := x"03";
	constant write : std_logic_vector(0 to 7) := x"02";
	type state_t is (START1, INSTR1, ADDR1, DATA1, STOP1, START2, INSTR2, ADDR2, DATA2, STOP2);
	signal state : state_t := STOP2;
	signal toggle : integer range 0 to 2 := 0;
	signal pos : integer range 0 to 15 := 0;
begin
	
	process(slow_clk, rst)
	begin
		if(rst = '1') then
			toggle <= 0;
			state <= STOP2;
			pos <= 0;
			sck <= '0';
			cs <= '1';
		elsif(rising_edge(slow_clk)) then
			if(toggle = 1) then
				sck <= '1';
				toggle <= 2;
			elsif(toggle = 2) then
				if(state = DATA2) then
					
				end if;
				sck <= '0';
				toggle <= 0;
			else
				case state is
					when START1 =>
						cs <= '0';
						state <= INSTR1;
					when INSTR1 =>
						so <= write(pos);
						
						if(pos = write'high) then
							pos <= 0;
							state <= ADDR1;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
					when ADDR1 =>
						so <= addr(pos);
						
						if(pos = addr'high) then
							pos <= 0;
							state <= DATA1;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
					when DATA1 =>
						so <= data(pos);
						
						if(pos = data'high) then
							pos <= 0;
							state <= STOP1;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
					when STOP1 =>
						cs <= '1';
						
						if(pos = 7) then
							pos <= 0;
							state <= START2;
						else
							pos <= pos + 1;
						end if;
						
						
					when START2 =>
						cs <= '0';
						state <= INSTR2;
					when INSTR2 =>
						so <= read(pos);
						
						if(pos = read'high) then
							pos <= 0;
							state <= ADDR2;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
					when ADDR2 =>
						so <= addr(pos);
						
						if(pos = addr'high) then
							pos <= 0;
							state <= DATA2;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
					when DATA2 =>
						if(pos = data'high) then
							pos <= 0;
							state <= STOP2;
						else
							pos <= pos + 1;
						end if;
						leds(pos) <= si;
						toggle <= 1;
					when STOP2 =>
						so <= '0';
						sck <= '0';
						
						cs <= '1';
						if(pos = 7) then
							pos <= 0;
							state <= START1;
						else
							pos <= pos + 1;
						end if;
				end case;
			end if;
		end if;
	end process;

	process(clk, rst)
		variable counter : integer := 0;
	begin
		if(rst = '1') then
			counter := 0;
		elsif(rising_edge(clk)) then
			if(counter = (2500000/2)-1) then
--			if(counter = (2500000/2)-1) then
				counter := 0;
				slow_clk <= not slow_clk;
			else
				counter := counter + 1;
			end if;
		end if;
	end process;

end Behavioral;

