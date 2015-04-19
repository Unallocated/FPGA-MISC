--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:21:25 04/15/2015
-- Design Name:   
-- Module Name:   /home/main/git/FPGA-MISC/ethernet-test/packet_capture_tb.vhd
-- Project Name:  ethernet-test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: packet_capture
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
 
ENTITY packet_capture_tb IS
END packet_capture_tb;
 
ARCHITECTURE behavior OF packet_capture_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT packet_capture
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         eth_rst_n : OUT  std_logic;
         tx_en : OUT  std_logic;
         tx_data : OUT  std_logic_vector(3 downto 0);
         tx_clk : IN  std_logic;
         tx_er : OUT  std_logic;
         mdio : INOUT  std_logic;
         mdc : OUT  std_logic;
         adc_clk : OUT  std_logic;
         adc_data : IN  std_logic_vector(7 downto 0);
         leds : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal tx_clk : std_logic := '0';
   signal adc_data : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal mdio : std_logic;

 	--Outputs
   signal eth_rst_n : std_logic;
   signal tx_en : std_logic;
   signal tx_data : std_logic_vector(3 downto 0);
   signal tx_er : std_logic;
   signal mdc : std_logic;
   signal adc_clk : std_logic;
   signal leds : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant tx_clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: packet_capture PORT MAP (
          clk => clk,
          rst => rst,
          eth_rst_n => eth_rst_n,
          tx_en => tx_en,
          tx_data => tx_data,
          tx_clk => tx_clk,
          tx_er => tx_er,
          mdio => mdio,
          mdc => mdc,
          adc_clk => adc_clk,
          adc_data => adc_data,
          leds => leds
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   tx_clk_process :process
   begin
		tx_clk <= '0';
		wait for tx_clk_period/2;
		tx_clk <= '1';
		wait for tx_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';
      wait for clk_period*10;
		
--		wait until smi_rdy = '1';
--		wait for clk_period;
		

      -- insert stimulus here 

      wait;
   end process;

END;
