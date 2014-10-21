library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This module will transmit whatever is in the FIFO
-- and do so at a rate of 115,200 bauds per second.
-- It assumes an input clock rate of 100 MHz.  Any other
-- clock rate will require a change to the counter_max
-- constant.  The constant value is determined by dividing
-- the input clock by the desired baud rate, and then
-- subtracting one.
-- To send data, the wr_clk clock must be clocked once
-- while the wr_en signal is high and data is set on
-- the din bus.
-- The signal 'full' is asserted when the FIFO is full
-- The signal 'empty' is asserted when the FIFO is empty
-- Data is transmitted as fast as possible

entity serial_tx_fifo is
	port ( 
			 -- Input clock.  This will drive all of the logic
			 clk : in std_logic;
			 -- Async reset signal
			 rst : in std_logic;
			 -- Serial TX output line
			 tx  : out std_logic;
			 -- Input data to be written to the FIFO
			 din : in std_logic_vector(7 downto 0);
	     -- Write clock to the FIFO
			 wr_clk : in std_logic;
	     -- Write enable to the FIFO
			 wr_en : in std_logic;
	     -- FIFO full signal
			 full : out std_logic;
	     -- FIFO empty signal
			 empty : out std_logic);
end serial_tx_fifo;

architecture Behavioral of serial_tx_fifo is

	-- Signals needed to connect the FIFO
	signal rd_en, full_buffer, empty_buffer : std_logic := '0';
	signal dout : std_logic_vector(7 downto 0) := (others => '0');

	-- Component declaration for the FIFO
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

	-- State machine type
	type state_t is (IDLE, START_BIT, HANDLE_DATA, STOP_BIT);
	-- Instance of the state machine
	signal state : state_t := IDLE;

	-- Max value of the counter that is used to divide
	-- down the base clock to the desired baud rate
	constant counter_max : unsigned(9 downto 0) := to_unsigned(867, 10);
	-- Counter used to tell when a baud has elapsed
	signal counter : unsigned(counter_max'range) := (others => '0');

	-- Used to tell which bit needs to be sent
	signal bit_pos : unsigned(2 downto 0) := (others => '0');
	
	-- Xilinx ISE does not like defaulting signals to non-zero values.
	-- To get around this, we will be inverting all of the tx values
	signal tx_buffer_n : std_logic := '0';
begin

	-- The parent needs to know if the FIFO is empty, so 
	-- expose that signal
	empty <= empty_buffer;
	-- Same goes for the full signal
	full <= full_buffer;

	-- The tx_buffer_n signal contains the inverse of what needs to
	-- be sent.  Invert it again to get the correct value to send
	tx <= not tx_buffer_n;

	-- Main process
	process(clk, rst)
	begin
		-- Async reset
		if(rst = '1') then
			counter <= (others => '0');
			bit_pos <= (others => '0');
			state <= IDLE;
			tx_buffer_n <= '0';
			rd_en <= '0';
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
					
					-- Only transmit if the FIFO has data
					if(empty_buffer = '0') then
						-- Since the FIFO definitely has data, prepare to clock one 
						-- byte out.  Setting rd_en is the first step.  The data will
						-- be available on the next clock since rd_clk is tied to clk
						rd_en <= '1';

						-- Change state
						state <= START_BIT;
					end if;

				-- In this state the tx line is held low for 1 baud time
				when START_BIT =>
					-- Set the buffer to '1' so that the line is driven low
					tx_buffer_n <= '1';
					-- The FIFO should have not output the next element.  Set 
					-- rd_en low to ensure that another element isn't clocked out
					rd_en <= '0';
					
					-- Sit and wait until the counter expires
					if(counter = counter_max) then
						-- Reset the counter
						counter <= (others => '0');
						-- Change to the HANDLE_DATA state
						state <= HANDLE_DATA;
					end if;

				-- In this state each data bit is sent
				when HANDLE_DATA =>
					-- Set the tx buffer to be the inverse of what needs to be sent
					tx_buffer_n <= not dout(to_integer(bit_pos));

					-- Check to see if the counter has reached the max value
					-- This will mean that one baud time has elapsed.  There will
					-- be 8 of these in each element
					if(counter = counter_max) then
						-- Reset the counter
						counter <= (others => '0');

						-- Check to see if this was the last bit to send
						if(bit_pos = 7) then
							-- Change to the STOP_BIT state
							state <= STOP_BIT;
							-- Reset the bit_pos for the next go-around
							bit_pos <= (others => '0');
						else
							-- This was not the last bit.  Increment bit_pos so that 
							-- the next bit is sent
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
						-- Change state to IDLE
						state <= IDLE;	
					end if;
			end case;
		end if;
	end process;
	
	-- This is the instance of the FIFO that will buffer data
	-- until it can be sent
	fifo_inst : fifo
	  PORT MAP (
		 -- Tie the module's reset to the FIFO's reset
		 rst => rst,
		 -- Expose the write clock to the outside so that data can be 
		 -- written to the FIFO from outside
		 wr_clk => wr_clk,
		 -- The read clock can be tied to the input clk signal since
		 -- reading is done in a process that is synch'ed to clk
		 rd_clk => clk,
		 -- Expose the data input to the parent
		 din => din,
		 -- Expose the write enable to the parent
		 wr_en => wr_en,
		 -- Connect the FIFO read clock to the read clock signal in
		 -- this module so that data can be read from the FIFO
		 rd_en => rd_en,
		 -- Connect the FIFO data out to the data out signal in this module
		 dout => dout,
		 -- This signal needs to be used in this module as well as by
		 -- the parent.  Assign full to the buffer signal that will be
		 -- used internally as well as externally
		 full => full_buffer,
		 -- This signal does not *really* need to be buffered, but it is :)
		 empty => empty_buffer
	  );

end Behavioral;

