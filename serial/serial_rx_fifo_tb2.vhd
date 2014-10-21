LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY serial_rx_fifo_tb2 IS
END serial_rx_fifo_tb2;
 
ARCHITECTURE behavior OF serial_rx_fifo_tb2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT serial_rx_fifo
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         rx : IN  std_logic;
         data : OUT  std_logic_vector(7 downto 0);
         full : OUT  std_logic;
         empty : OUT  std_logic;
         rd_clk : IN  std_logic;
         rd_en : IN  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal rx : std_logic := '1';
   signal rd_en : std_logic := '0';

 	--Outputs
   signal data : std_logic_vector(7 downto 0);
   signal full : std_logic;
   signal empty : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	procedure sendSerial(data : std_logic_vector(7 downto 0); signal rx : out std_logic) is
	begin
		rx <= '0';
		wait for 8.68 us ;
		rx <= data(0);
		wait for 8.68 us ;
		rx <= data(1);
		wait for 8.68 us ;
		rx <= data(2);
		wait for 8.68 us ;
		rx <= data(3);
		wait for 8.68 us ;
		rx <= data(4);
		wait for 8.68 us ;
		rx <=data(5);
		wait for 8.68 us ;
		rx <=data(6);
		wait for 8.68 us ;
		rx <= data(7);
		wait for 8.68 us ;
		rx <= '1';
		wait for 8.68 us ;

	end sendSerial;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: serial_rx_fifo PORT MAP (
          clk => clk,
          rst => rst,
          rx => rx,
          data => data,
          full => full,
          empty => empty,
          rd_clk => clk,
          rd_en => rd_en
        );

   -- Clock process definitions
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
 

	stim_proc: process
	begin
		wait for 100 ns;	
		
		sendSerial(x"55", rx);
		sendSerial(x"f1", rx);

		wait until rising_edge(clk);
		rd_en <= '1';
		wait for clk_period;
		rd_en <= '0';

		wait;
	end process;

END;
