library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Simple SPI master.  Only works for one device ATM.  Though it's easy to add extra devices by making the ce input 
-- a vector with X bits and adding an integer input

entity master_minimal is
	Generic( data_width : integer := 8 );
	Port(clk      : in  STD_LOGIC;
		 rst      : in  STD_LOGIC;
		 miso     : in  STD_LOGIC;
		 start    : in  STD_LOGIC;
		 we       : in  STD_LOGIC;
		 data_in  : in  STD_LOGIC_VECTOR(data_width - 1 downto 0);
		 data_out : out STD_LOGIC_VECTOR(data_width - 1 downto 0);
		 done     : out STD_LOGIC;
		 sck      : out STD_LOGIC;
		 ce       : out STD_LOGIC;
		 mosi     : out STD_LOGIC);
end master_minimal;

architecture Behavioral of master_minimal is
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
			ce               <= '1';
			
		elsif (rising_edge(clk)) then
			case sck_state is
				when SCK_SET_HIGH =>
					sck <= '1';
					sck_state <= SCK_SET_LOW;
				when SCK_SET_LOW =>
					sck <= '0';
					sck_state <= SCK_IDLE;
				when SCK_IDLE =>
					case base_state is
						when BASE_IDLE =>
							mosi     <= '0';
							ce       <= '1';
							done     <= '1';
							
							data_pos := data_width - 1;
						when BASE_DATA_TRANSFER =>
							mosi <= data_in_buffer(data_pos);
							data_out(data_pos) <= miso;
							

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

