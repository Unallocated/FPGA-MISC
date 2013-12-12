--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:15:38 12/12/2013
-- Design Name:   
-- Module Name:   /root/FPGA-MISC/FFT with VGA/sqrt_core_test.vhd
-- Project Name:  FFT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sqrt_core
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY sqrt_core_test IS
END sqrt_core_test;
 
ARCHITECTURE behavior OF sqrt_core_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sqrt_core
    PORT(
         x_in : IN  std_logic_vector(15 downto 0);
         x_out : OUT  std_logic_vector(8 downto 0);
         rdy : OUT  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x_in : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal x_out : std_logic_vector(8 downto 0);
   signal rdy : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   
   constant one : std_logic_vector(7 downto 0) := "11111101";
   constant two : std_logic_vector(7 downto 0) := "00000010";
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sqrt_core PORT MAP (
          x_in => x_in,
          x_out => x_out,
          rdy => rdy,
          clk => clk
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
      x_in <= std_logic_vector(((unsigned(one) + 128) * (unsigned(one) + 128)) + ((unsigned(two) + 128) * (unsigned(two) + 128)));

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
