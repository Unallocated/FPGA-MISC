LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY unscaled_mag_tb IS
END unscaled_mag_tb;
 
ARCHITECTURE behavior OF unscaled_mag_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT unscaled_mag
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         re : IN  std_logic_vector(17 downto 0);
         im : IN  std_logic_vector(17 downto 0);
         idx : IN  std_logic_vector(8 downto 0);
         dv : IN  std_logic;
         mag_val : OUT  std_logic_vector(18 downto 0);
         mag_idx : OUT  std_logic_vector(8 downto 0);
         mag_dv : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal re : std_logic_vector(17 downto 0) := (others => '0');
   signal im : std_logic_vector(17 downto 0) := (others => '0');
   signal idx : std_logic_vector(8 downto 0) := (others => '0');
   signal dv : std_logic := '0';

 	--Outputs
   signal mag_val : std_logic_vector(18 downto 0);
   signal mag_idx : std_logic_vector(8 downto 0);
   signal mag_dv : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: unscaled_mag PORT MAP (
          clk => clk,
          rst => rst,
          re => re,
          im => im,
          idx => idx,
          dv => dv,
          mag_val => mag_val,
          mag_idx => mag_idx,
          mag_dv => mag_dv
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
      dv <= '1';
      re <= std_logic_vector(to_signed(-127, re'length));
      im <= std_logic_vector(to_signed(-127, im'length));
      idx <= "000011111";

      wait for clk_period;
      
      dv <= '1';
      re <= std_logic_vector(to_signed(500, re'length));
      im <= std_logic_vector(to_signed(-250, im'length));
      idx <= "111110000";

      wait for clk_period;
      
      dv <= '0';
      idx <= (others => '0');

      wait until mag_dv = '1';
      wait for clk_period / 2;
      assert mag_val = "0000000000010110011";
      assert mag_idx = "000011111";
      --assert mag_val = std_logic_vector(to_unsigned(179, mag_val'length));
      wait for clk_period;
      assert mag_val = "0000000001000101111";
      assert mag_idx = "111110000";
      assert mag_dv = '1';
      --assert mag_val = std_logic_vector(to_unsigned(559, mag_val'length));

      
      -- insert stimulus here 

      wait;
   end process;

END;
