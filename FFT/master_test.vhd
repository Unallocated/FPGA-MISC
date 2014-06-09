LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY master_test IS
END master_test;
 
ARCHITECTURE behavior OF master_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT master
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         adc_clk : OUT  std_logic;
         adc_data : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal adc_data : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal adc_clk : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant adc_clk_period : time := 10 ns;

   type mem_t is array(0 to 255) of integer range 0 to 255;
   constant mem : mem_t := (127,130,133,136,139,142,145,148,151,154,157,160,163,166,169,172,175,178,181,184,186,189,192,194,197,200,202,205,207,209,212,214,216,218,221,223,225,227,229,230,232,234,235,237,239,240,241,243,244,245,246,247,248,249,250,250,251,252,252,253,253,253,253,253,254,253,253,253,253,253,252,252,251,250,250,249,248,247,246,245,244,243,241,240,239,237,235,234,232,230,229,227,225,223,221,218,216,214,212,209,207,205,202,200,197,194,192,189,186,184,181,178,175,172,169,166,163,160,157,154,151,148,145,142,139,136,133,130,127,123,120,117,114,111,108,105,102,99,96,93,90,87,84,81,78,75,72,69,67,64,61,59,56,53,51,48,46,44,41,39,37,35,32,30,28,26,24,23,21,19,18,16,14,13,12,10,9,8,7,6,5,4,3,3,2,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,2,3,3,4,5,6,7,8,9,10,12,13,14,16,18,19,21,23,24,26,28,30,32,35,37,39,41,44,46,48,51,53,56,59,61,64,67,69,72,75,78,81,84,87,90,93,96,99,102,105,108,111,114,117,120,123);
   signal mem_pos : integer range 0 to 255 := 0;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: master PORT MAP (
          clk => clk,
          rst => rst,
          adc_clk => adc_clk,
          adc_data => adc_data
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
 
   process(adc_clk)
   begin
   	if(rising_edge(adc_clk)) then
		adc_data <= std_logic_vector(to_unsigned(mem(mem_pos), adc_data'length));
		if(mem_pos = 255) then
			mem_pos <= 0;
		else
			mem_pos <= mem_pos + 1;
		end if;
	end if;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
