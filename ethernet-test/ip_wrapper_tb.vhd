LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;
 
ENTITY ip_wrapper_tb IS
END ip_wrapper_tb;
 
ARCHITECTURE behavior OF ip_wrapper_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ip_wrapper
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         wr_en : IN  std_logic;
         busy : OUT  std_logic;
         buffer_full : OUT  std_logic;
         buffer_empty : OUT  std_logic;
         buffer_prog_full : OUT  std_logic;
         buffer_prog_full_val : IN  std_logic_vector(10 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         data_valid : OUT  std_logic;
         dropped_frame : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal wr_en : std_logic := '0';
   signal buffer_prog_full_val : std_logic_vector(10 downto 0) := (others => '0');

 	--Outputs
   signal busy : std_logic;
   signal buffer_full : std_logic;
   signal buffer_empty : std_logic;
   signal buffer_prog_full : std_logic;
   signal data_out : std_logic_vector(7 downto 0);
   signal data_valid : std_logic;
   signal dropped_frame : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ip_wrapper PORT MAP (
          clk => clk,
          rst => rst,
          data_in => data_in,
          wr_en => wr_en,
          busy => busy,
          buffer_full => buffer_full,
          buffer_empty => buffer_empty,
          buffer_prog_full => buffer_prog_full,
          buffer_prog_full_val => buffer_prog_full_val,
          data_out => data_out,
          data_valid => data_valid,
          dropped_frame => dropped_frame
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
		
		wait for clk_period*10;
		
		wait until rising_edge(clk);
		
		for i in 1 to 8 loop
			wr_en <= '1';
			data_in <= std_logic_vector(to_unsigned(i, 8));
			wait for clk_period;
		end loop;
		
		wr_en <= '0';
		
      wait;
   end process;

END;
