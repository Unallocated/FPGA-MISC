--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:44:52 04/11/2015
-- Design Name:   
-- Module Name:   /home/main/git/FPGA-MISC/ethernet-test/smi_ramlike_tb.vhd
-- Project Name:  ethernet-test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: smi_ramlike
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
 
ENTITY smi_ramlike_tb IS
END smi_ramlike_tb;
 
ARCHITECTURE behavior OF smi_ramlike_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT smi_ramlike
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         mdio : INOUT  std_logic;
         mdc : OUT  std_logic;
         rd_en : IN  std_logic;
         wr_en : IN  std_logic;
         addr : IN  std_logic_vector(3 downto 0);
         data_in : IN  std_logic_vector(15 downto 0);
         data_out : OUT  std_logic_vector(15 downto 0);
         working : OUT  std_logic;
         done : OUT  std_logic;
         rdy : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal rd_en : std_logic := '0';
   signal wr_en : std_logic := '0';
   signal addr : std_logic_vector(3 downto 0) := (others => '0');
   signal data_in : std_logic_vector(15 downto 0) := (others => '0');

	--BiDirs
   signal mdio : std_logic;

 	--Outputs
   signal mdc : std_logic;
   signal data_out : std_logic_vector(15 downto 0);
   signal working : std_logic;
   signal done : std_logic;
   signal rdy : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: smi_ramlike PORT MAP (
          clk => clk,
          rst => rst,
          mdio => mdio,
          mdc => mdc,
          rd_en => rd_en,
          wr_en => wr_en,
          addr => addr,
          data_in => data_in,
          data_out => data_out,
          working => working,
          done => done,
          rdy => rdy
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
      rst <= '1';
      wait for 100 ns;	
		rst <= '0';
      wait until rising_edge(clk);
		wait for clk_period*10;
		
		wait until rdy = '1';
		wait for clk_period;
		
		data_in <= x"0001";
		addr <= "1010";
		wr_en <= '1';
		wait for clk_period;
		wr_en <= '0';
		
		wait until done = '1';
		wait for clk_period;
		
		addr <= "1100";
		rd_en <= '1';
		wait for clk_period;
		rd_en <= '0';
		
      -- insert stimulus here 

      wait;
   end process;

END;
