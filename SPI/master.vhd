library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity master is
	Generic(data_width : integer   := 8;
		    ce_active_low  : boolean := true;
		    sck_active_high : boolean := true 
	);
	Port(clk      : in  STD_LOGIC;
		 rst      : in  STD_LOGIC;
		 si       : in  STD_LOGIC;
		 start    : in  STD_LOGIC;
		 we       : in  STD_LOGIC;
		 data_in  : in  STD_LOGIC_VECTOR(data_width - 1 downto 0);
		 data_out : out STD_LOGIC_VECTOR(data_width - 1 downto 0);
		 done     : out STD_LOGIC;
		 sck      : out STD_LOGIC;
		 ce       : out STD_LOGIC;
		 so       : out STD_LOGIC);
end master;

architecture Behavioral of master is
	type base_state_t is (BASE_IDLE, BASE_DATA_TRANSFER);
	type sck_state_t is (SCK_IDLE, SCK_SET_HIGH, SCK_SET_LOW);

	signal base_state : base_state_t := BASE_IDLE;
	signal sck_state  : sck_state_t  := SCK_SET_LOW;

	signal data_in_buffer : std_logic_vector(data_in'range) := (others => '0');
	signal we_buffer      : std_logic                       := '0';

begin
	process(clk, rst, start)
		variable last_start_state : std_logic                         := '0';
		variable data_pos         : integer range 0 to data_width - 1 := data_width - 1;
	begin
		
		if (rst = '1') then
			data_out         <= (others => '0');
			base_state       <= BASE_IDLE;
			sck_state        <= SCK_SET_LOW;
		elsif (start = '1' and base_state = BASE_IDLE and last_start_state = '0') then
			we_buffer        <= we;
			data_in_buffer   <= data_in;
			done             <= '0';
			base_state       <= BASE_DATA_TRANSFER;
			
			
			if(ce_active_low = true) then
				ce <= '1';
			else
				ce <= '0';
			end if;
			
		elsif (rising_edge(clk)) then
			case sck_state is
				when SCK_SET_HIGH =>
					if(sck_active_high = true) then
						sck <= '1';
					else
						sck <= '0';
					end if;
					
					sck_state <= SCK_SET_LOW;
				when SCK_SET_LOW =>
					if(sck_active_high = true) then
						sck <= '0';
					else
						sck <= '1';
					end if;
					
					sck_state <= SCK_IDLE;
				when SCK_IDLE =>
					case base_state is
						when BASE_IDLE =>
							so       <= '0';
							if(ce_active_low = true) then
								ce <= '1';
							else
								ce <= '0';
							end if;

							done     <= '1';
							data_pos := data_width - 1;
						when BASE_DATA_TRANSFER =>
							if (we_buffer = '1') then
								so <= data_in_buffer(data_pos);
							else
								data_out(data_pos) <= si;
							end if;

							if (data_pos = 0) then
								base_state <= BASE_IDLE;
							else
								data_pos := data_pos - 1;
							end if;

							sck_state <= SCK_SET_HIGH;

					end case;
			end case;

		end if;
		last_start_state := start;
	end process;

end Behavioral;

