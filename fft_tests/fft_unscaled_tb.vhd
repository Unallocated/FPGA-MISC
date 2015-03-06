LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
library std;
use std.textio.all;

use work.txt_util.all;

ENTITY fft_unscaled_tb IS
END fft_unscaled_tb;
 
ARCHITECTURE behavior OF fft_unscaled_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fft_unscaled
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         re_in : IN  std_logic_vector(7 downto 0);
         re_out : OUT  std_logic_vector(17 downto 0);
         im_out : OUT  std_logic_vector(17 downto 0);
         index_out : OUT  std_logic_vector(8 downto 0);
         start : IN  std_logic;
         rfd : OUT  std_logic;
         busy : OUT  std_logic;
         done : OUT  std_logic;
         unload : IN  std_logic;
         dv : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal re_in : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal unload : std_logic := '0';

 	--Outputs
   signal re_out : std_logic_vector(17 downto 0);
   signal im_out : std_logic_vector(17 downto 0);
   signal index_out : std_logic_vector(8 downto 0);
   signal rfd : std_logic;
   signal busy : std_logic;
   signal done : std_logic;
   signal dv : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
   COMPONENT sine_gen
      PORT (
        clk : IN STD_LOGIC;
        pinc_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    END COMPONENT;
    file out_file : text open write_mode is "/tmp/test.txt";
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fft_unscaled PORT MAP (
          clk => clk,
          rst => rst,
          re_in => re_in,
          re_out => re_out,
          im_out => im_out,
          index_out => index_out,
          start => start,
          rfd => rfd,
          busy => busy,
          done => done,
          unload => unload,
          dv => dv
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
  your_instance_name : sine_gen
  PORT MAP (
    clk => clk,
    pinc_in => x"00FF",
    sine => re_in
  );
   -- Stimulus process
   stim_proc: process
    variable text_buff : line;
   begin		
      rst <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      rst <= '0';

      wait for clk_period*10;
      start <= '1';
      wait for clk_period;
      start <= '0';
      
      wait until done = '1';
      unload <= '1';
      wait until dv = '1';
      for i in 0 to 511 loop
        wait for clk_period;
        --print(out_file, str((re_out)) & " " & str(im_out));
        print(out_file, str(to_integer(signed(re_out))) & " " & str(to_integer(signed(im_out))) & " " & str(to_integer(unsigned(index_out))));
      end loop;
      wait until dv = '0';
      unload <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
