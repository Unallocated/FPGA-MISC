LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY master_test IS
END master_test;
 
ARCHITECTURE behavior OF master_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT master
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         sck : OUT  std_logic;
         so : OUT  std_logic;
         si : IN  std_logic;
         ce : OUT  std_logic;
         we : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         done : OUT  std_logic;
         start : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal si : std_logic := '0';
   signal we : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal sck : std_logic;
   signal so : std_logic;
   signal ce : std_logic;
   signal data_out : std_logic_vector(7 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: master PORT MAP (
          clk => clk,
          rst => rst,
          sck => sck,
          so => so,
          si => si,
          ce => ce,
          we => we,
          data_in => data_in,
          data_out => data_out,
          done => done,
          start => start
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
      
      data_in <= x"7e";
      we <= '1';
      wait for clk_period;
      start <= '1';
      wait until done = '1';
      start <= '0';
      we <= '0';
      wait for clk_period;
      start <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
