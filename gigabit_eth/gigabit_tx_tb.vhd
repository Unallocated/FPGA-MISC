--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:17:33 07/19/2015
-- Design Name:   
-- Module Name:   /home/main/git/FPGA-MISC/gigabit_eth/gigabit_tx_tb.vhd
-- Project Name:  gigabit_eth
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: gigabit_tx
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
 
ENTITY gigabit_tx_tb IS
END gigabit_tx_tb;
 
ARCHITECTURE behavior OF gigabit_tx_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT gigabit_tx
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         eth_mdio : INOUT  std_logic;
         eth_mdc : OUT  std_logic;
         eth_rst_n : OUT  std_logic;
         eth_col : IN  std_logic;
         eth_crs : IN  std_logic;
         eth_rx_dv : IN  std_logic;
         eth_rx_clk : IN  std_logic;
         eth_rx_err : IN  std_logic;
         eth_rx_data : IN  std_logic_vector(7 downto 0);
         eth_tx_clk : OUT  std_logic;
         eth_tx_en : OUT  std_logic;
         eth_tx_err : OUT  std_logic;
         eth_tx_data : OUT  std_logic_vector(7 downto 0);
         leds : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal eth_col : std_logic := '0';
   signal eth_crs : std_logic := '0';
   signal eth_rx_dv : std_logic := '0';
   signal eth_rx_clk : std_logic := '0';
   signal eth_rx_err : std_logic := '0';
   signal eth_rx_data : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal eth_mdio : std_logic;

 	--Outputs
   signal eth_mdc : std_logic;
   signal eth_rst_n : std_logic;
   signal eth_tx_clk : std_logic;
   signal eth_tx_en : std_logic;
   signal eth_tx_err : std_logic;
   signal eth_tx_data : std_logic_vector(7 downto 0);
   signal leds : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant eth_rx_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: gigabit_tx PORT MAP (
          clk => clk,
          rst => rst,
          eth_mdio => eth_mdio,
          eth_mdc => eth_mdc,
          eth_rst_n => eth_rst_n,
          eth_col => eth_col,
          eth_crs => eth_crs,
          eth_rx_dv => eth_rx_dv,
          eth_rx_clk => eth_rx_clk,
          eth_rx_err => eth_rx_err,
          eth_rx_data => eth_rx_data,
          eth_tx_clk => eth_tx_clk,
          eth_tx_en => eth_tx_en,
          eth_tx_err => eth_tx_err,
          eth_tx_data => eth_tx_data,
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
 
   eth_rx_clk_process :process
   begin
		eth_rx_clk <= '0';
		wait for eth_rx_clk_period/2;
		eth_rx_clk <= '1';
		wait for eth_rx_clk_period/2;
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
