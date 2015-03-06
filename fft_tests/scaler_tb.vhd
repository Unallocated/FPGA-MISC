LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY scaler_tb IS
END scaler_tb;
 
ARCHITECTURE behavior OF scaler_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT scaler
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         input_val : IN  std_logic_vector(18 downto 0);
         output_val : OUT  std_logic_vector(7 downto 0);
         output_dv : OUT  std_logic;
         output_index : OUT std_logic_vector(8 downto 0);
         input_dv : IN  std_logic;
         input_index : IN std_logic_vector(8 downto 0);
         scale_factor : IN  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal input_val : std_logic_vector(18 downto 0) := (others => '0');
   signal input_dv : std_logic := '0';
   signal scale_factor : std_logic_vector(9 downto 0) := (others => '0');
   signal input_index : std_logic_vector(8 downto 0);

 	--Outputs
   signal output_val : std_logic_vector(7 downto 0);
   signal output_dv : std_logic;
   signal output_index : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: scaler PORT MAP (
          clk => clk,
          rst => rst,
          input_val => input_val,
          input_index => input_index,
          output_val => output_val,
          output_dv => output_dv,
          output_index => output_index,
          input_dv => input_dv,
          scale_factor => scale_factor
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
      input_val <= std_logic_vector(to_unsigned(510, input_val'length));
      scale_factor <= "0010000000";
      input_dv <= '1';
      wait for clk_period;
      input_val <= std_logic_vector(to_unsigned(22, input_val'length));
      scale_factor <= "0100000000";
      input_dv <= '1';
      wait for clk_period;
      input_dv <= '0';
      scale_factor <= (others => '0');
      input_val <= (others => '0');
      -- insert stimulus here 

      wait;
   end process;

END;
