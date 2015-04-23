--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:29:45 04/22/2015
-- Design Name:   
-- Module Name:   /home/main/git/FPGA-MISC/ethernet-test/usrp_like_tb.vhd
-- Project Name:  ethernet-test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: usrp_like
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
 
ENTITY usrp_like_tb IS
END usrp_like_tb;
 
ARCHITECTURE behavior OF usrp_like_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT usrp_like
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         eth_tx_data : OUT  std_logic_vector(3 downto 0);
         eth_tx_er : OUT  std_logic;
         eth_tx_clk : IN  std_logic;
         eth_smi_mdio : INOUT  std_logic;
         eth_smi_clk : OUT  std_logic;
         leds : OUT  std_logic_vector(7 downto 0);
         sine_out : OUT  std_logic_vector(7 downto 0);
         adc_clk : OUT  std_logic;
         adc_data : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal eth_tx_clk : std_logic := '0';
   signal adc_data : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal eth_smi_mdio : std_logic;

 	--Outputs
   signal eth_tx_data : std_logic_vector(3 downto 0);
   signal eth_tx_er : std_logic;
   signal eth_smi_clk : std_logic;
   signal leds : std_logic_vector(7 downto 0);
   signal sine_out : std_logic_vector(7 downto 0);
   signal adc_clk : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant eth_tx_clk_period : time := 10 ns;
   constant eth_smi_clk_period : time := 10 ns;
   constant adc_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: usrp_like PORT MAP (
          clk => clk,
          rst => rst,
          eth_tx_data => eth_tx_data,
          eth_tx_er => eth_tx_er,
          eth_tx_clk => eth_tx_clk,
          eth_smi_mdio => eth_smi_mdio,
          eth_smi_clk => eth_smi_clk,
          leds => leds,
          sine_out => sine_out,
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
 
   eth_tx_clk_process :process
   begin
		eth_tx_clk <= '0';
		wait for eth_tx_clk_period/2;
		eth_tx_clk <= '1';
		wait for eth_tx_clk_period/2;
   end process;
 
   eth_smi_clk_process :process
   begin
		eth_smi_clk <= '0';
		wait for eth_smi_clk_period/2;
		eth_smi_clk <= '1';
		wait for eth_smi_clk_period/2;
   end process;
 
   adc_clk_process :process
   begin
		adc_clk <= '0';
		wait for adc_clk_period/2;
		adc_clk <= '1';
		wait for adc_clk_period/2;
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
