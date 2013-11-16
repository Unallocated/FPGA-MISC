--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:38:24 11/18/2013
-- Design Name:   
-- Module Name:   /home/main/FPGA-MISC/Nexys3-RAM-Test/sync_sram_tb.vhd
-- Project Name:  Nexys3-RAM-Test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sync_sram
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
 
ENTITY sync_sram_tb IS
END sync_sram_tb;
 
ARCHITECTURE behavior OF sync_sram_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sync_sram
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ram_addr : OUT  std_logic_vector(21 downto 0);
         ram_data : INOUT  std_logic_vector(15 downto 0);
         ram_clk : OUT  std_logic;
         ram_lb : OUT  std_logic;
         ram_ub : OUT  std_logic;
         ram_ce : OUT  std_logic;
         ram_adv : OUT  std_logic;
         ram_cre : OUT  std_logic;
         ram_we : OUT  std_logic;
         ram_oe : OUT  std_logic;
         data_in : IN  std_logic_vector(15 downto 0);
         addr : IN  std_logic_vector(21 downto 0);
         data_out : OUT  std_logic_vector(15 downto 0);
         done : OUT  std_logic;
         start : IN  std_logic;
         we : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal addr : std_logic_vector(21 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal we : std_logic := '0';

	--BiDirs
   signal ram_data : std_logic_vector(15 downto 0);

 	--Outputs
   signal ram_addr : std_logic_vector(21 downto 0);
   signal ram_clk : std_logic;
   signal ram_lb : std_logic;
   signal ram_ub : std_logic;
   signal ram_ce : std_logic;
   signal ram_adv : std_logic;
   signal ram_cre : std_logic;
   signal ram_we : std_logic;
   signal ram_oe : std_logic;
   signal data_out : std_logic_vector(15 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant ram_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sync_sram PORT MAP (
          clk => clk,
          rst => rst,
          ram_addr => ram_addr,
          ram_data => ram_data,
          ram_clk => ram_clk,
          ram_lb => ram_lb,
          ram_ub => ram_ub,
          ram_ce => ram_ce,
          ram_adv => ram_adv,
          ram_cre => ram_cre,
          ram_we => ram_we,
          ram_oe => ram_oe,
          data_in => data_in,
          addr => addr,
          data_out => data_out,
          done => done,
          start => start,
          we => we
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
      --wait for 100 ns;	

      --wait for clk_period*10;

      -- insert stimulus here 
		
		addr <= (others => '1');
		data_in <= x"7e55";
		we <= '1';
		wait for 10 ns;
		start <= '1';
		wait until done = '0';
		start <= '0';


      wait;
   end process;

END;
