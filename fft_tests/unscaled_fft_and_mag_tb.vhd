LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY unscaled_fft_and_mag_tb IS
END unscaled_fft_and_mag_tb;
 
ARCHITECTURE behavior OF unscaled_fft_and_mag_tb IS 
 
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
 

   
   COMPONENT unscaled_mag
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      re : IN std_logic_vector(17 downto 0);
      im : IN std_logic_vector(17 downto 0);
      idx : IN std_logic_vector(8 downto 0);
      dv : IN std_logic;          
      mag_val : OUT std_logic_vector(18 downto 0);
      mag_idx : OUT std_logic_vector(8 downto 0);
      mag_dv : OUT std_logic
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

  signal mag_val : std_logic_vector(18 downto 0);
  signal mag_idx : std_logic_vector(index_out'range);
  signal mag_dv : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
  COMPONENT sine_gen
    PORT (
      clk : IN STD_LOGIC;
      pinc_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

BEGIN
 
  sine_inst : sine_gen
  PORT MAP (
    clk => clk,
    pinc_in => x"00FF",
    sine => re_in
  );

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

    Inst_unscaled_mag: unscaled_mag PORT MAP(
      clk => clk,
      rst => rst,
      re => re_out,
      im => im_out,
      idx => index_out,
      dv => dv,
      mag_val => mag_val,
      mag_idx => mag_idx,
      mag_dv => mag_dv
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
      start <= '1';
      wait for clk_period;
      start <= '0';
      wait until done = '1';
      unload <= '1';
      wait for clk_period;
      unload <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
