library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sram is
    Port ( clk      : in     STD_LOGIC;
    	   rst      : in     STD_LOGIC;
           sck      : out    STD_LOGIC;
           so       : out    STD_LOGIC;
           cs       : out    STD_LOGIC;
           si       : in     STD_LOGIC;
           data_out : out    STD_LOGIC_VECTOR (7 downto 0);
           data_in  : in     STD_LOGIC_VECTOR (7 downto 0);
           addr     : in     STD_LOGIC_VECTOR (15 downto 0);
           we       : in     STD_LOGIC;
           done     : out    STD_LOGIC;
           start    : in     STD_LOGIC);
end sram;

architecture Behavioral of sram is

	constant WRITE_INSTR : std_logic_vector(0 to 7) := "00000010";
	constant READ_INSTR : std_logic_vector(0 to 7) := "00000011";

	type state_t is (IDLE, INSTR, ADDRESS, READ, WRITE, STALL);
	signal state : state_t := STALL;
	
	signal we_buffer : std_logic;
	signal data_buffer : std_logic_vector(7 downto 0);
	signal addr_buffer : std_logic_vector(15 downto 0);

	signal pos : integer range 0 to 16 := 0;
	signal toggle : integer range 0 to 2 := 0;
	
	signal last_start : std_logic := '0';
begin

	process(clk, rst)
	begin
		if(rst = '1') then
			state <= STALL;
			toggle <= 0;
		elsif(rising_edge(clk)) then
			if(toggle = 1) then
				sck <= '1';
				toggle <= 2;
			elsif(toggle = 2) then
				sck <= '0';
				toggle <= 0;
			else
				case state is
					when IDLE =>
						so <= '0';
						sck <= '0';
						done <= '1';
						--data <= (others => 'Z');
						pos <= 0;
						toggle <= 0;
						
						
						if(start = '1' and last_start = '0') then
							state <= INSTR;
							we_buffer <= we;
							data_buffer <= data_in;
							addr_buffer <= addr;
							done <= '0';
							cs <= '0';
						end if;
						
						last_start <= start;
					when INSTR =>
						if(we_buffer = '1') then
							so <= WRITE_INSTR(pos);
						else
							so <= READ_INSTR(pos);
						end if;
						
						if(pos = 7) then
							pos <= 0;
							state <= ADDRESS;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
					when ADDRESS =>
						so <= addr_buffer(pos);
						
						if(pos = 15) then
							pos <= 0;
							if(we_buffer = '1') then
								state <= WRITE;
							else
								state <= READ;
							end if;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
					when READ =>
						if(pos = 7) then
							state <= STALL;
						else
							pos <= pos + 1;
						end if;
						
						data_out(pos) <= si;
						
						toggle <= 1;
					when WRITE =>
						so <= data_buffer(pos);
					
						if(pos = 7) then
							state <= STALL;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
					when STALL =>
						cs <= '1';
						state <= IDLE;
				end case;
			end if;
		end if;
	end process;

end Behavioral;

