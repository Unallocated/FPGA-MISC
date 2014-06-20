--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:52:18 06/19/2014
-- Design Name:   
-- Module Name:   /home/main/git/FPGA-MISC/FFT with VGA/fft_controller_tb.vhd
-- Project Name:  FFT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fft_controller
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
USE ieee.numeric_std.ALL;
 
ENTITY fft_controller_tb IS
END fft_controller_tb;
 
ARCHITECTURE behavior OF fft_controller_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fft_controller
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         data_in_clk : OUT  std_logic;
         data_out : OUT  std_logic_vector(15 downto 0);
         data_out_clk : OUT  std_logic;
         scale_in : IN  std_logic_vector(7 downto 0);
         scale_we : IN  std_logic;
         start : IN  std_logic;
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal data_in_clk : std_logic := '0';
   signal scale_in : std_logic_vector(7 downto 0) := (others => '0');
   signal scale_we : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(15 downto 0);
   signal data_out_clk : std_logic;
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant data_in_clk_period : time := 10 ns;
   constant data_out_clk_period : time := 10 ns;
 
 
	type sine_lut_t is array(0 to 255) of integer range 0 to 255;
   signal sine_lut : sine_lut_t := (127,130,133,136,139,142,145,148,151,154,157,160,163,166,169,172,175,178,181,184,186,189,192,194,197,200,202,205,207,209,212,214,216,218,221,223,225,227,229,230,232,234,235,237,239,240,241,243,244,245,246,247,248,249,250,250,251,252,252,253,253,253,253,253,254,253,253,253,253,253,252,252,251,250,250,249,248,247,246,245,244,243,241,240,239,237,235,234,232,230,229,227,225,223,221,218,216,214,212,209,207,205,202,200,197,194,192,189,186,184,181,178,175,172,169,166,163,160,157,154,151,148,145,142,139,136,133,130,127,123,120,117,114,111,108,105,102,99,96,93,90,87,84,81,78,75,72,69,67,64,61,59,56,53,51,48,46,44,41,39,37,35,32,30,28,26,24,23,21,19,18,16,14,13,12,10,9,8,7,6,5,4,3,3,2,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,2,3,3,4,5,6,7,8,9,10,12,13,14,16,18,19,21,23,24,26,28,30,32,35,37,39,41,44,46,48,51,53,56,59,61,64,67,69,72,75,78,81,84,87,90,93,96,99,102,105,108,111,114,117,120,123);
   signal lut_pos : integer range 0 to 255 := 0;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fft_controller PORT MAP (
          clk => clk,
          rst => rst,
          data_in => data_in,
          data_in_clk => data_in_clk,
          data_out => data_out,
          data_out_clk => data_out_clk,
          scale_in => scale_in,
          scale_we => scale_we,
          start => start,
          done => done
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	process(clk)
	begin
		if(rising_edge(clk)) then
			data_in <= std_logic_vector(to_unsigned(sine_lut(lut_pos), 8));
			
			if(lut_pos = 255) then
				lut_pos <= 0;
			else
				lut_pos <= lut_pos + 1;
			end if;
		end if;
	end process;
	
	
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 1000 ns;	
		start <= '1';
      wait until done = '0';
		start <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
