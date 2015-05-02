LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY eth_master_tb IS
END eth_master_tb;
 
ARCHITECTURE behavior OF eth_master_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT eth_master
	 GENERIC ( reset_count : positive := 10 );
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         tx_clk : IN  std_logic;
         tx_er : OUT  std_logic;
         tx_en : OUT  std_logic;
         tx_data : OUT  std_logic_vector(3 downto 0);
         smi_clk : OUT  std_logic;
         smi_mdio : INOUT  std_logic;
         leds : OUT  std_logic_vector(7 downto 0);
         eth_rst_n : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal tx_clk : std_logic := '0';

	--BiDirs
   signal smi_mdio : std_logic;

 	--Outputs
   signal tx_er : std_logic;
   signal tx_en : std_logic;
   signal tx_data : std_logic_vector(3 downto 0);
   signal smi_clk : std_logic;
   signal leds : std_logic_vector(7 downto 0);
   signal eth_rst_n : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant tx_clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: eth_master PORT MAP (
          clk => clk,
          rst => rst,
          tx_clk => tx_clk,
          tx_er => tx_er,
          tx_en => tx_en,
          tx_data => tx_data,
          smi_clk => smi_clk,
          smi_mdio => smi_mdio,
          leds => leds,
          eth_rst_n => eth_rst_n
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   tx_clk_process :process
   begin
		tx_clk <= '0';
		wait for tx_clk_period/2;
		tx_clk <= '1';
		wait for tx_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
