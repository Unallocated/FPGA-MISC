LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY sampling_buff_tb IS
END sampling_buff_tb;
 
ARCHITECTURE behavior OF sampling_buff_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sampling_buff
	 GENERIC ( frame_size : positive := 32 );
    PORT(
         wr_clk : IN  std_logic;
         rst : IN  std_logic;
         wr_en : IN  std_logic;
         rd_clk : IN  std_logic;
         dv : OUT  std_logic;
         ovflo : OUT  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
			rdy : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal wr_clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal wr_en : std_logic := '0';
   signal rd_clk : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dv : std_logic;
   signal ovflo : std_logic;
   signal data_out : std_logic_vector(7 downto 0);
	signal rdy : std_logic;

   -- Clock period definitions
   constant wr_clk_period : time := 60 ns;
   constant rd_clk_period : time := 30 ns;
	
	signal counter : std_logic_vector(7 downto 0) := (others => '0');
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sampling_buff PORT MAP (
          wr_clk => wr_clk,
          rst => rst,
          wr_en => wr_en,
          rd_clk => rd_clk,
          dv => dv,
          ovflo => ovflo,
          data_in => data_in,
          data_out => data_out,
			 rdy => rdy
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
 
	counter_gen: process
	begin
		wait for wr_clk_period * 15;
		wait until rising_edge(wr_clk);
		while 1 < 10 loop
			wr_en <= '1';
			data_in <= counter;
			counter <= std_logic_vector(unsigned(counter) + 1);
			wait for wr_clk_period;
		end loop moo;
	end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';

      wait for wr_clk_period*10;

		
      -- insert stimulus here 

      wait;
   end process;

END;
