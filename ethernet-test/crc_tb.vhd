--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:43:54 04/11/2015
-- Design Name:   
-- Module Name:   /home/main/git/FPGA-MISC/ethernet-test/crc_tb.vhd
-- Project Name:  ethernet-test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: crc
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
--USE ieee.numeric_std.ALL;
 
ENTITY crc_tb IS
END crc_tb;
 
ARCHITECTURE behavior OF crc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT crc
    PORT(
         data_in : IN  std_logic_vector(143 downto 0);
         crc_en : IN  std_logic;
         rst : IN  std_logic;
         clk : IN  std_logic;
         crc_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : std_logic_vector(143 downto 0) := (others => '0');
   signal crc_en : std_logic := '0';
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal crc_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: crc PORT MAP (
          data_in => data_in,
          crc_en => crc_en,
          rst => rst,
          clk => clk,
          crc_out => crc_out
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
		
		data_in <= x"ffffffffffff010203040506FFFFAABBCCDD";
		crc_en <= '1';
		wait for clk_period;
		crc_en <= '0';
		-- insert stimulus here 

      wait;
   end process;

END;
