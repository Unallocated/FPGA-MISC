LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY unscaled_tb IS
END unscaled_tb;
 
ARCHITECTURE behavior OF unscaled_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT unscaled
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         red : OUT  std_logic_vector(2 downto 0);
         green : OUT  std_logic_vector(2 downto 0);
         blue : OUT  std_logic_vector(1 downto 0);
         hs : OUT  std_logic;
         vs : OUT  std_logic;
         sine_out : OUT  std_logic_vector(7 downto 0);
         adc_in : IN  std_logic_vector(7 downto 0);
         adc_clk : OUT  std_logic;
         rx : IN std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal adc_in : std_logic_vector(7 downto 0) := (others => '0');
   signal rx : std_logic := '1';

 	--Outputs
   signal red : std_logic_vector(2 downto 0);
   signal green : std_logic_vector(2 downto 0);
   signal blue : std_logic_vector(1 downto 0);
   signal hs : std_logic;
   signal vs : std_logic;
   signal sine_out : std_logic_vector(7 downto 0);
   signal adc_clk : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant adc_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: unscaled PORT MAP (
          clk => clk,
          rst => rst,
          red => red,
          green => green,
          blue => blue,
          hs => hs,
          vs => vs,
          sine_out => sine_out,
          adc_in => sine_out,
          adc_clk => adc_clk,
          rx => rx
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
      rst <= '1';
      wait for 100 ns;	
      rst <= '0';

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
