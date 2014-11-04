library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This module will transmit an 8 bit counter over serial at
-- 115,200 baud.  It expects a 100 MHz clock to be provided.
-- If a clock of a different rate is provided, be sure to 
-- change the counter_max constant to be oine less than the
-- clock rate divided by the desired baud rate.
-- Ex: 50_000_000 / 115_200
--     This will be 434, but counter_max needs to be 433
entity serial_tx is
	port ( clk : in std_logic;
         rst : in std_logic;
				 tx  : out std_logic );
end serial_tx;

architecture Behavioral of serial_tx is

	-- State machine type
	type state_t is (IDLE, START_BIT, HANDLE_DATA, STOP_BIT);
	-- Instance of the state machine
	signal state : state_t := IDLE;

	-- Max value for the the counter that will make sure to divide
	-- the clk signal into the correct baud rate
	constant counter_max : unsigned(9 downto 0) := to_unsigned(867, 10);
	-- Counter that will be used to divide down the input clock
	-- to match the desired baud rate
	signal counter : unsigned(counter_max'range) := (others => '0');

	-- Holds the current byte to be sent
	-- Will just be a counter for this module
	signal data_buffer : unsigned(7 downto 0) := (others => '0');

	-- Keeps track of which bit is going to be sent next
	signal bit_pos : unsigned(2 downto 0) := (others => '0');

	-- Used to delay the transition out of the IDLE state so that 
	-- there is time between bytes being sent
	signal idle_counter : unsigned(31 downto 0) := (others => '0');
	
	-- Xilinx ISE does not like defaulting signals to non-zero values.
	-- To get around this, we will be inverting all of the tx values
	signal tx_buffer_n : std_logic := '0';
begin
	-- The tx_buffer_n signal contains the inverse of what needs to
	-- be sent.  Invert it again to get the correct value to send
	tx <= not tx_buffer_n;

	-- Main process of the module
	process(clk, rst)
	begin
		-- Async reset code
		if(rst = '1') then
			counter <= (others => '0');
			data_buffer <= (others => '0');
			bit_pos <= (others => '0');
			idle_counter <= (others => '0');
			state <= IDLE;
			tx_buffer_n <= '0';
		elsif(rising_edge(clk)) then
			-- Always increment the counter.  If the counter needs to be 
			-- reset, it will be overidden later on.
			counter <= counter + 1;

			-- Switch for all of the possible states of the state machine
			case state is 
				-- Idle condition.  Sit here until idle_counter reaches a certain 
				-- value, and then move on to the START_BIT state
				when IDLE =>
					-- Make sure to reset the tx line.  Remember, this is inverted!!
					tx_buffer_n <= '0';

					-- Check to see if it's time to leave the IDLE state or not
					if(idle_counter = 250) then
						-- Change state to START_BIT
						state <= START_BIT;
						-- Reset the counter
						counter <= (others => '0');
						-- Reset the idle counter for the next go-around
						idle_counter <= (others => '0');
					else
						-- It is not time to leave the IDLE state yet
						-- Increment the counter
						idle_counter <= idle_counter + 1;
					end if;
				-- In this state the tx line is held low for 1 baud time
				when START_BIT =>
					-- Set the buffer to '1' so that the line is driven low
					tx_buffer_n <= '1';

					-- Sit and wait until the counter reaches the max value
					if(counter = counter_max) then
						-- Reset the counter
						counter <= (others => '0');
						-- Change to the HANDLE_DATA state
						state <= HANDLE_DATA;
					end if;

				-- In this state each data bit is sent
				when HANDLE_DATA =>
					-- Set the tx buffer to be the inverse of what needs to be sent
					tx_buffer_n <= not data_buffer(to_integer(bit_pos));

					-- Check to see if the counter has reached the max value
					if(counter = counter_max) then
						-- Reset the counter
						counter <= (others => '0');
						-- Check to see if this was the last bit to send
						if(bit_pos = 7) then
							-- Change to the STOP_BIT state
							state <= STOP_BIT;
							-- Increment the counter
							data_buffer <= data_buffer + 1;
							-- Reset bit_pos
							bit_pos <= (others => '0');
						else
							-- This is not the last bit to be sent
							-- Increment bit_pos for the next go around
							bit_pos <= bit_pos + 1;
						end if;
					end if;

				-- This state will hold the tx line high for 1 baud time
				when STOP_BIT =>
					-- Set the tx line to be high (opposite of the tx buffer value)
					tx_buffer_n <= '0';

					-- Sit and wait until the counter reaches the max value
					if(counter = counter_max) then
						-- Reset the counter
						counter <= (others => '0');
						-- Change to the idle state
						state <= IDLE;	
					end if;
			end case;
		end if;
	end process;

end Behavioral;


