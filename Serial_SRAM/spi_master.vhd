library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity spi_master is
	Generic (
		data_width : integer := 8
	);
    Port ( clk      : in   STD_LOGIC;
           data_in  : in   STD_LOGIC_VECTOR (data_width - 1 downto 0);
           sck      : out  STD_LOGIC;
           si       : in   STD_LOGIC;
           so       : out  STD_LOGIC;
           rst      : in   STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (data_width - 1 downto 0);
           rdy      : out  STD_LOGIC;
           start    : in   STD_LOGIC;
           cs       : out  STD_LOGIC);
end spi_master;

architecture Behavioral of spi_master is
	
	signal data_in_buffer : std_logic_vector(data_width - 1 downto 0);
	signal last_start_value : std_logic := '0';

	type state_t is (IDLE, SENDING);
	signal state : state_t := IDLE;
	
	signal toggle : integer range 0 to 3 := 0;
	signal pos : integer range 0 to (2 ** data_width) - 1 := 0;
	
begin

	process(clk, rst)
	begin
		if(rst = '1') then
			state <= IDLE;
		elsif(rising_edge(clk)) then
			if(toggle = 1) then
				sck <= '1';
				toggle <= 2;
			elsif(toggle = 2) then
				toggle <= 3;
				data_out(pos) <= si;
			elsif(toggle = 3) then
				sck <= '0';
				toggle <= 0;
			else
				case state is 
					when IDLE =>
						toggle <= 0;
						sck <= '0';
						so <= '0';
						rdy <= '1';
						cs <= '1';
						pos <= 0;
						
						if(start = '1' and last_start_value = '0') then
							state <= SENDING;
							data_in_buffer <= data_in;
							rdy <= '0';
							cs <= '0';
						end if;
						
						last_start_value <= start;
					when SENDING =>
						so <= data_in_buffer(pos);
						
						if(pos = data_width-1) then
							pos <= 0;
							state <= IDLE;
						else
							pos <= pos + 1;
						end if;
						
						toggle <= 1;
	
				end case;
			end if;
		end if;
	end process;
end Behavioral;

