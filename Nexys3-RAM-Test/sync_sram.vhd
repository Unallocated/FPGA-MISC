library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- TODO: A separate process to latch the data, addr, and we pins
--       might get away from making the parent wait for done to go low...

-- TODO: There is no delay happening in the stall state.  This is okay
--       for now since the parent module clocks this module slow enough
--       that one clock cycle is longer than the required amount of time
--       for the data to be valid on ram_data.

entity sync_sram is
	Port(
		 -- input clock.  Used for the state machine
	    clk      : in    STD_LOGIC;
		 -- reset
		 rst      : in    STD_LOGIC;
		 -- Direct path to the RAM address pins
		 ram_addr : out   STD_LOGIC_VECTOR(21 downto 0);
		 -- Direct path to the RAM data pins
		 ram_data : inout STD_LOGIC_VECTOR(15 downto 0);
		 -- Direct path to the RAM clock (not used in this mode, always '0')
		 ram_clk  : out   STD_LOGIC;
		 -- Direct path to the RAM LB signal (used with ub when reading/writing)
		 ram_lb   : out   STD_LOGIC;
		 -- Direct path to the RAM UB signal (used with lb when reading/writing)
		 ram_ub   : out   STD_LOGIC;
		 -- Direct path to the RAM chip enable (active low)
		 ram_ce   : out   STD_LOGIC;
		 -- Direct path to the RAM adv pin (always low for this mode)
		 ram_adv  : out   STD_LOGIC;
		 -- Direct path to the RAM cre pin (always low for this mode)
		 ram_cre  : out   STD_LOGIC;
		 -- Direct path to the RAM write enable (used for writing data)
		 ram_we   : out   STD_LOGIC;
		 -- Direct path to the RAM output enable (used for reading data)
		 ram_oe   : out   STD_LOGIC;
		 -- Data input.  Used to buffer data to be written to the RAM.
		 -- This is the data signal used by the parent module.  You would
		 -- set this signal to write some data.  DO NOT USE ram_data!!!
		 data_in  : in    STD_LOGIC_VECTOR(15 downto 0);
		 -- Address input.  Used to buffer the address data should be stored
		 -- at or read from.  DO NOT USE ram_addr!!!!
		 addr     : in    STD_LOGIC_VECTOR(21 downto 0);
		 -- Data output.  This is where the result of reading from memory will be
		 data_out : out   STD_LOGIC_VECTOR(15 downto 0);
		 -- Done signal.  When '1', the module is done and ready for another operation
		 done     : out   STD_LOGIC;
		 -- Start signal.  When '1', the address, we, and data inputs are buffered
		 -- and the state machine starts.
		 start    : in    STD_LOGIC;
		 -- Write enable.  Tells the state machine if this operation is a read ('0')
		 -- or a write ('1')
		 we       : in    STD_LOGIC);
end sync_sram;

architecture Behavioral of sync_sram is
	-- The we input needs to be buffered in case the input is
	-- changed mid-way through the state machine
	signal we_buffer : std_logic := '0';
	
	-- All possible states for the state machine
	type state_type is (IDLE, SET_MODE, TRIGGER, STALL);
	-- Create a signal to hold the current state
	signal state : state_type := IDLE;
	-- Keeps track of the last value of the start signal.
	-- This is important to make sure that if the start signal
	-- is not set back to '0' before the state machine completes
	-- that there is not a back to back unwanted operation.  Basically,
	-- this makes sure that in order to start the state machine,
	-- start has to go from '0' to '1'.
	signal last_start_value : std_logic := '0';
begin
	-- All three of these signals should always be zero.
	-- This is only because of the mode this module operates the RAM in.
	-- To take full advantage of the RAM, these would actually get used.
	ram_adv <= '0';
	ram_clk <= '0';
	ram_cre <= '0';

	-- Process that drives the state machine
	-- Sensitive to changes in clk, rst, and start
	process(clk, rst, start)
		-- There are no variables to declare
	begin	
		-- Asynchronous reset.  If reset changed, and is a '1',
		-- then reset the state machine.
		-- TODO: Should last_start_value be changed here?
		if(rst = '1') then
			-- Reset the state machine
			state <= IDLE;
		-- When reset is low, wait for a rising edge on clk
		elsif(rising_edge(clk)) then
			-- This is the meat of the state machine
			case state is
				-- Idle state.  Just set defaults and wait for 
				-- start to go from zero to one.
				when IDLE =>
					-- Set defaults
					done <= '1';
					ram_ce <= '1';
					ram_lb <= '1';
					ram_ub <= '1';
					ram_we <= '1';
					
					-- We cannot put two rising_edge() checks in the same process.
					-- This is a hack to see if start is on it's 'rising edge'
					if(start = '1' and last_start_value = '0') then
						-- The last state of start was '0', and it's now '1'.
						-- Start up the state machine
						
						-- Show that the module is currently working
						done <= '0';
						-- Progress the state machine
						state <= SET_MODE;
						-- Buffer the current value of we.  It will be needed later.
						we_buffer <= we;
						-- Go ahead and set the RAM address.  Doing it now saves from
						-- having to buffer the addr pins.
						ram_addr <= addr;
						-- Enable the memory
						ram_ce <= '0';
						
						-- Check to see if ram_data needs to be driven, or listened to
						if(we = '1') then	
							ram_data <= data_in;
						else
							ram_data <= (others => 'Z');
						end if;
						
					end if;
					
					-- Set last_start_value to the current value of start.
					-- This lets us see what start was on the last clock
					last_start_value <= start;
					
				-- Sets the ub, lb, oe, and we pins
				when SET_MODE =>
					-- No matter if this is a read or write, lb and ub 
					-- need to be set to zero
					ram_ub <= '0';
					ram_lb <= '0';
					
					-- Set oe and we based on if this is a write or read
					if(we_buffer = '1') then
						-- It's VERY important here to notice that we is NOT
						-- being set yet.  If we needs to be zero, then it MUST
						-- happen after ub and lb go low!!!!
						ram_oe <= '1';
					else
						ram_oe <= '0';
						ram_we <= '1';
					end if;
					
					-- Progress the state machine
					state <= TRIGGER;
					
				-- Sets ram_we low if this is a write
				when TRIGGER =>
					if(we_buffer = '1') then
						ram_we <= '0';
					end if;
					
					state <= STALL;
				
				-- This is supposed to be where the process waits for X
				-- clock cycles.  For now it's okay to just run the memory 
				-- slow enough that this one clock cycle is enough for the
				-- memory to be ready.
				when STALL =>
					-- we being '0' means that this was a read, so the data
					-- from ram_data needs to be output on data_out.  Otherwise
					-- this was a write and there is no need to do anything else
					if(we_buffer = '0') then
						data_out <= ram_data;
					end if;
					
					-- Go back to the idle state
					state <= IDLE;
			end case;
		end if;
	end process;
					
end Behavioral;

