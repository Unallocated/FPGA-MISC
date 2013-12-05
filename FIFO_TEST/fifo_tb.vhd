--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:24 12/20/2013
-- Design Name:   
-- Module Name:   /root/FPGA-MISC/FIFO_TEST/fifo_tb.vhd
-- Project Name:  FIFO_TEST
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fifo
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
 
ENTITY fifo_tb IS
END fifo_tb;
 
ARCHITECTURE behavior OF fifo_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fifo
    PORT(
         rst : IN  std_logic;
         wr_clk : IN  std_logic;
         rd_clk : IN  std_logic;
         din : IN  std_logic_vector(7 downto 0);
         wr_en : IN  std_logic;
         rd_en : IN  std_logic;
         dout : OUT  std_logic_vector(7 downto 0);
         full : OUT  std_logic;
         almost_full : OUT  std_logic;
         wr_ack : OUT  std_logic;
         overflow : OUT  std_logic;
         empty : OUT  std_logic;
         almost_empty : OUT  std_logic;
         valid : OUT  std_logic;
         underflow : OUT  std_logic;
         rd_data_count : OUT  std_logic_vector(4 downto 0);
         wr_data_count : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal wr_clk : std_logic := '0';
   signal rd_clk : std_logic := '0';
   signal din : std_logic_vector(7 downto 0) := (others => '0');
   signal wr_en : std_logic := '0';
   signal rd_en : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);
   signal full : std_logic;
   signal almost_full : std_logic;
   signal wr_ack : std_logic;
   signal overflow : std_logic;
   signal empty : std_logic;
   signal almost_empty : std_logic;
   signal valid : std_logic;
   signal underflow : std_logic;
   signal rd_data_count : std_logic_vector(4 downto 0);
   signal wr_data_count : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant wr_clk_period : time := 1 ns;
   constant rd_clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fifo PORT MAP (
          rst => rst,
          wr_clk => wr_clk,
          rd_clk => rd_clk,
          din => din,
          wr_en => wr_en,
          rd_en => rd_en,
          dout => dout,
          full => full,
          almost_full => almost_full,
          wr_ack => wr_ack,
          overflow => overflow,
          empty => empty,
          almost_empty => almost_empty,
          valid => valid,
          underflow => underflow,
          rd_data_count => rd_data_count,
          wr_data_count => wr_data_count
        );

   -- Clock process definitions
   wr_clk_process :process
   begin
		wr_clk <= '0';
		wait for wr_clk_period/2;
		wr_clk <= '1';
		wait for wr_clk_period/2;
   end process;
 
   rd_clk_process :process
   begin
		rd_clk <= '0';
		wait for rd_clk_period/2;
		rd_clk <= '1';
		wait for rd_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 1 ns;
      wait until full = '0';
		
		wr_en <= '1';
		wait until full = '1';
		wr_en <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
