--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:44:23 12/12/2013
-- Design Name:   
-- Module Name:   /root/FFT/fft_flow_tb.vhd
-- Project Name:  FFT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fft_flow
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
 
ENTITY fft_flow_tb IS
END fft_flow_tb;
 
ARCHITECTURE behavior OF fft_flow_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fft_flow
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         phase_angle_in : IN  std_logic_vector(7 downto 0);
         phase_out : OUT  std_logic_vector(7 downto 0);
         leds : OUT  std_logic_vector(7 downto 0);
         --adc_in : IN  std_logic_vector(7 downto 0);
         --adc_clk : OUT  std_logic;
         hs : OUT  std_logic;
         vs : OUT  std_logic;
         red : OUT  std_logic_vector(2 downto 0);
         blue : OUT  std_logic_vector(1 downto 0);
         green : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal phase_angle_in : std_logic_vector(7 downto 0) := (others => '0');
   signal phase_angle_clk : std_logic := '0';
   signal adc_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal phase_out : std_logic_vector(7 downto 0);
   signal leds : std_logic_vector(7 downto 0);
   signal adc_clk : std_logic;
   signal hs : std_logic;
   signal vs : std_logic;
   signal red : std_logic_vector(2 downto 0);
   signal blue : std_logic_vector(1 downto 0);
   signal green : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	adc_in <= phase_out;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fft_flow PORT MAP (
          clk => clk,
          rst => rst,
          phase_angle_in => phase_angle_in,
          phase_out => phase_out,
          leds => leds,
          --adc_in => adc_in,
          --adc_clk => adc_clk,
          hs => hs,
          vs => vs,
          red => red,
          blue => blue,
          green => green
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

      wait for clk_period*10;
		phase_angle_in <= "01111111";
      -- insert stimulus here 

      wait;
   end process;

END;
