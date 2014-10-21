library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity serial_rx_fifo is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           data : out  STD_LOGIC_VECTOR (7 downto 0);
	   full : out STD_LOGIC;
	   empty : out STD_LOGIC;
	   rd_clk : in STD_LOGIC;
	   rd_en : in STD_LOGIC);
end serial_rx_fifo;

architecture Behavioral of serial_rx_fifo is

	signal wr_en, full_buffer : std_logic := '0';
	signal din : std_logic_vector(7 downto 0) := (others => '0');
	
	COMPONENT fifo
	  PORT (
		 rst : IN STD_LOGIC;
		 wr_clk : IN STD_LOGIC;
		 rd_clk : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 wr_en : IN STD_LOGIC;
		 rd_en : IN STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 full : OUT STD_LOGIC;
		 empty : OUT STD_LOGIC
	  );
	END COMPONENT;
	
	
	type state_t is (IDLE, START_BIT, HANDLE_DATA, STOP_BIT);
	signal rx_state : state_t := IDLE;
	
	constant counter_max : unsigned(9 downto 0) := to_unsigned(867, 10);
	signal rx_counter : unsigned(counter_max'range) := (others => '0');
	
	signal rx_bit_pos : unsigned(2 downto 0) := (others => '0');
	signal rx_data_buffer : std_logic_vector(7 downto 0) := (others => '0');
	
	signal rx_buffer_n : std_logic := '0';

begin

	full <= full_buffer;

	process(clk, rst)
	begin
		if (rst = '1') then
			wr_en <= '0';
			din <= (others => '0');
			rx_state <= IDLE;
			rx_counter <= (others => '0');
			rx_bit_pos <= (others => '0');
			rx_data_buffer <= (others => '0');
		elsif (rising_edge(clk)) then
			rx_buffer_n <= not rx;
			
			rx_counter <= rx_counter + 1;
			
			case rx_state is
				when IDLE =>
					rx_counter <= rx_counter;
					
					if (rx_buffer_n = '1') then
						rx_state <= START_BIT;
						
						rx_data_buffer <= (others => '0');
						rx_bit_pos <= (others => '0');
						rx_counter <= (others => '0');
					end if;
				when START_BIT =>
					if(rx_counter = counter_max - 1) then
						rx_counter <= (others => '0');
						rx_state <= HANDLE_DATA;
					end if;
				when HANDLE_DATA =>
					if (rx_counter = counter_max / 2) then
						rx_data_buffer(to_integer(rx_bit_pos)) <= not rx_buffer_n;
					elsif (rx_counter = counter_max) then
						rx_counter <= (others => '0');
						
						if(rx_bit_pos = 7) then
							rx_state <= STOP_BIT;
							din <= rx_data_buffer;
							
						else
							rx_bit_pos <= rx_bit_pos + 1;
						end if;
					end if;
				when STOP_BIT =>
					wr_en <= '0';
				
					if(rx_counter < 1 and full_buffer = '0') then
						wr_en <= '1';
					end if;
					
					if(rx_counter = counter_max) then
						rx_state <= IDLE;
						rx_counter <= (others => '0');
					end if;
			end case;
		end if;
	end process;

	fifo_inst : fifo
	  PORT MAP (
		 rst => rst,
		 wr_clk => clk,
		 rd_clk => rd_clk,
		 din => din,
		 wr_en => wr_en,
		 rd_en => rd_en,
		 dout => data,
		 full => full_buffer,
		 empty => empty
	  );
	

end Behavioral;

