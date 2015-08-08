--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:43:50 12/01/2013
-- Design Name:   
-- Module Name:   /home/xilinx/FPGA-MISC/gigabit_eth/adc_master_tb.vhd
-- Project Name:  gigabit_eth
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adc_master
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
 
ENTITY adc_master_tb IS
END adc_master_tb;
 
ARCHITECTURE behavior OF adc_master_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adc_master
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         eth_tx_clk : OUT  std_logic;
         eth_tx_er : OUT  std_logic;
         eth_tx_en : OUT  std_logic;
         eth_tx_data : OUT  std_logic_vector(7 downto 0);
         eth_mdc : OUT  std_logic;
         eth_mdio : INOUT  std_logic;
         leds : OUT  std_logic_vector(7 downto 0);
         eth_rst_n : OUT  std_logic;
         adc_in : IN  std_logic_vector(7 downto 0);
         adc_clk : OUT  std_logic;
         sine_o : OUT  std_logic_vector(7 downto 0);
         sine_inc : IN  std_logic_vector(7 downto 0);
         divider_max_val : IN  std_logic_vector(3 downto 0);
         test_out : OUT  std_logic_vector(7 downto 0);
         sw : IN  std_logic_vector(4 downto 0);
         source_select : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal adc_in : std_logic_vector(7 downto 0) := (others => '0');
   signal sine_inc : std_logic_vector(7 downto 0) := (others => '0');
   signal divider_max_val : std_logic_vector(3 downto 0) := (others => '0');
   signal sw : std_logic_vector(4 downto 0) := (others => '0');
   signal source_select : std_logic := '0';

	--BiDirs
   signal eth_mdio : std_logic;

 	--Outputs
   signal eth_tx_clk : std_logic;
   signal eth_tx_er : std_logic;
   signal eth_tx_en : std_logic;
   signal eth_tx_data : std_logic_vector(7 downto 0);
   signal eth_mdc : std_logic;
   signal leds : std_logic_vector(7 downto 0);
   signal eth_rst_n : std_logic;
   signal adc_clk : std_logic;
   signal sine_o : std_logic_vector(7 downto 0);
   signal test_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant eth_tx_clk_period : time := 10 ns;
   constant adc_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adc_master PORT MAP (
          clk => clk,
          rst => rst,
          eth_tx_clk => eth_tx_clk,
          eth_tx_er => eth_tx_er,
          eth_tx_en => eth_tx_en,
          eth_tx_data => eth_tx_data,
          eth_mdc => eth_mdc,
          eth_mdio => eth_mdio,
          leds => leds,
          eth_rst_n => eth_rst_n,
          adc_in => adc_in,
          adc_clk => adc_clk,
          sine_o => sine_o,
          sine_inc => sine_inc,
          divider_max_val => divider_max_val,
          test_out => test_out,
          sw => sw,
          source_select => source_select
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
