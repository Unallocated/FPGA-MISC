--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:09:36 04/26/2015
-- Design Name:   
-- Module Name:   /home/main/git/FPGA-MISC/ethernet-test/usrp_like_master_tb.vhd
-- Project Name:  ethernet-test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: usrp_like_master
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
 
ENTITY usrp_like_master_tb IS
END usrp_like_master_tb;
 
ARCHITECTURE behavior OF usrp_like_master_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT usrp_like_master
	 GENERIC ( reset_clocks : natural := 100);
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         eth_rst_n : OUT  std_logic;
         eth_tx_data : OUT  std_logic_vector(3 downto 0);
         eth_tx_en : OUT  std_logic;
         eth_tx_er : OUT  std_logic;
         eth_tx_clk : IN  std_logic;
         eth_smi_mdio : INOUT  std_logic;
         eth_smi_clk : OUT  std_logic;
         adc_data : IN  std_logic_vector(7 downto 0);
         adc_clk : OUT  std_logic;
         sine_inc : IN  std_logic_vector(7 downto 0);
         sine_out : OUT  std_logic_vector(7 downto 0);
         leds : OUT  std_logic_vector(7 downto 0);
         add_offset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal eth_tx_clk : std_logic := '0';
   signal adc_data : std_logic_vector(7 downto 0) := (others => '0');
   signal sine_inc : std_logic_vector(7 downto 0) := (others => '0');
   signal add_offset : std_logic := '0';

	--BiDirs
   signal eth_smi_mdio : std_logic;

 	--Outputs
   signal eth_rst_n : std_logic;
   signal eth_tx_data : std_logic_vector(3 downto 0);
   signal eth_tx_en : std_logic;
   signal eth_tx_er : std_logic;
   signal eth_smi_clk : std_logic;
   signal adc_clk : std_logic;
   signal sine_out : std_logic_vector(7 downto 0);
   signal leds : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant eth_tx_clk_period : time := 10 ns;
   constant eth_smi_clk_period : time := 10 ns;
   constant adc_clk_period : time := 10 ns;
   
	signal samps : std_logic_vector(32 + 2 + 2 + 5 + 5 + 1 - 1 downto 0) := (others => '0');
	signal data : std_logic_vector(15 downto 0) := "0000000000001000";
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: usrp_like_master PORT MAP (
          clk => clk,
          rst => rst,
          eth_rst_n => eth_rst_n,
          eth_tx_data => eth_tx_data,
          eth_tx_en => eth_tx_en,
          eth_tx_er => eth_tx_er,
          eth_tx_clk => eth_tx_clk,
          eth_smi_mdio => eth_smi_mdio,
          eth_smi_clk => eth_smi_clk,
          adc_data => adc_data,
          adc_clk => adc_clk,
          sine_inc => sine_inc,
          sine_out => sine_out,
          leds => leds,
          add_offset => add_offset
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
 
	smi_proc : process
		
	begin
			wait until rising_edge(eth_smi_clk);
			eth_smi_mdio <= 'Z';
			if(eth_smi_mdio = 'Z') then
				for i in data'range loop
					wait until rising_edge(eth_smi_clk);
					eth_smi_mdio <= data(i);
				end loop;
				eth_smi_mdio <= 'Z';
			end if;
	end process;

   -- Stimulus process
	process
	begin
	
		wait for 1000 ns;
		
		wait until rising_edge(adc_clk);
		for i in 0 to 59900 loop
			adc_data <= x"20";
			wait for adc_clk_period;
		end loop;
		
		adc_data <= x"00";
	end process;
	
	
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';

		


      -- insert stimulus here 

      wait;
   end process;

END;
