library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--
-- There is an odd thing that happens in this module
--   Since rx going low is the signal to start processing,
--   having rx_buffer default to '0' is a problem.  This
--   causes processing to kick off at the wrong time.  It's
--   only really a problem for the first byte of data.  To 
--   solve this issue, the rx_buffer signal is inverted so that
--   resetting to '0' is not an issue.

-- This design is meant to work with a 100 MHz clock (clk) and
-- 115,200 bauds per second serial transmissions using 8N1
-- (8 data bits, no parity, 1 stop bit)

-- Any changes to the clock rate or baud rate will require a change
-- to the signal counter_max.  Use this equation to assign counter_max:
-- 		(clock_rate_in_hz / baud_rate_in_hz) - 1
-- Ex: for a 100 MHz clock, and 115,200 bauds per second:
-- 		(100,000,000 / 115,200) - 1 = approx 867
entity serial_rx_fifo is
	port(clk  : in  std_logic;  -- input clock
		  rst  : in  std_logic;  -- reset
		  rx   : in  std_logic;  -- serial rx line (tx from the other device)
		  leds : out std_logic_vector(7 downto 0)); -- LEDs to show data with
end serial_rx_fifo;

architecture behave of serial_rx_fifo is
	-- main state machine type.  4 stages
	type state_t is (IDLE, START_BIT, HANDLE_DATA, STOP_BIT);
	-- keeps track of the current state
	signal rx_state : state_t := IDLE;
	
	-- Holds the max value of the counter for the baud rate
	-- that was calculated with "(clock_rate_in_hz / baud_rate) - 1"
	constant counter_max : unsigned(9 downto 0) := to_unsigned(1, 10);
	-- Holds the current counter value that is used to tell when to 
	-- sample the rx pin data
	signal rx_counter : unsigned(counter_max'range) := (others => '0');
	
	-- Current data bit that is being looked at
	signal rx_bit_pos : unsigned(2 downto 0) := (others => '0');
	-- Stores all 8 data bits
	signal rx_data_buffer : std_logic_vector(7 downto 0) := (others => '0');
	
	-- Needed since the rx line is idle high ('1').  See the note at the
	-- top of this file for details
	signal rx_buffer_n : std_logic := '0';
begin
	
	-- The only process.
	process(clk, rst)
	begin
		-- Async reset.  Resets all signals touched by this process
		if (rst = '1') then
			rx_state <= IDLE;
			rx_counter <= (others => '0');
			leds <= (others => '0');
			rx_bit_pos <= (others => '0');
			rx_data_buffer <= (others => '0');
		-- What to do on a rising clock edge
		elsif (rising_edge(clk)) then
			-- Store the inverse value of rx in rx_buffer_n.  This is
			-- done to help aviod metastability problems.  Without bufferin
			-- rx, you would get random errors in the data bits.  See notes
			-- at the top for why rx is inverted.
			rx_buffer_n <= not rx;
			
			-- Always increment the counter.  If the counter needs to be
			-- reset, the reset will happen after this line and since 
			-- rx_counter is a signal, it will take the last value. Only
			-- put here because it aviods having to put it in several 
			-- places.
			rx_counter <= rx_counter + 1;
			
			-- State machine
			case rx_state is
				-- IDLE's job is to sit and wait for the rx line to go low
				-- which is a '1' on rx_buffer_n.  Once rx_buffer_n is '1',
				-- the state changes to START_BIT and all of the required
				-- signals are reset.
				when IDLE =>
					-- Don't waste energy incrementing the counter
					-- This overwrites the above rx_counter < rx_counter + 1
					rx_counter <= rx_counter;
					
					-- Check to see if rx_buffer_n is '1' (data is coming)
					if (rx_buffer_n = '1') then
						-- Change to the START_BIT state
						rx_state <= START_BIT;
						
						-- Reset all of the required signals to a known state
						-- before moving on
						rx_data_buffer <= (others => '0');
						rx_bit_pos <= (others => '0');
						rx_counter <= (others => '0');
					end if;
				-- START_BIT just kills one bit (baud) time and then moves 
				-- on to HANDLE_DATA
				when START_BIT =>
					-- Check to see if rx_counter has reached it's max value
					-- Remember that rx_counter is being incremented automatically
					-- at the top of the process.  The counter_max - 1 is done
					-- because we missed one clock cycle from the START_BIT state
					if(rx_counter = counter_max - 1) then
						rx_counter <= (others => '0');
						rx_state <= HANDLE_DATA;
					end if;
				-- HANDLE_DATA is the state where the data bits are sampled and 
				-- stored.  Bits are sampled at the halfway point instead of the
				-- edge.  This is done to give the best chance of getting the bit
				when HANDLE_DATA =>
					-- Check to see if the counter is at the half way point
					if (rx_counter = counter_max / 2) then
						-- Grab the current bit and assign it to the rx_data_buffer.
						-- Make sure to notice that the bit from rx_buffer_n is
						-- inverted before being assigned to rx_data_buffer!!  This
						-- gets the data bit back to what it was originally on the rx
						-- line.
						rx_data_buffer(to_integer(rx_bit_pos)) <= not rx_buffer_n;
					-- Check to see if the counter has maxed out.  This means that it's
					-- time to either increment rx_bit_pos, or change states
					elsif (rx_counter = counter_max) then
						-- Reset rx_counter (overrides the assignment at the top)
						rx_counter <= (others => '0');
						
						-- Check to see if the last bit read was number 7.
						-- If so, it's time to change state (all bits have been read)
						if(rx_bit_pos = 7) then
							-- Change to the STOP_BIT state
							rx_state <= STOP_BIT;
							-- Use the LEDs to show the byte that was just read
							leds <= rx_data_buffer;
							
						-- rx_bit_pos was not 7, so there are more bits to read
						else
							-- Increment rx_bit_pos and wait for the next bit
							rx_bit_pos <= rx_bit_pos + 1;
						end if;
					end if;
				-- STOP_BIT just kills one bit (baud) time.  The actual bit sent
				-- at this point is not important
				when STOP_BIT =>
					-- Check to see if the counter has maxed out.  This means that
					-- one bit (baud) time has elapsed
					if(rx_counter = counter_max) then
						-- Change state to IDLE
						rx_state <= IDLE;
						-- Reset the counter
						rx_counter <= (others => '0');
					end if;
			end case;
		end if;
	end process;

end behave;