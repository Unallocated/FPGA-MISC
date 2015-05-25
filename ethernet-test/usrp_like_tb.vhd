--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:02:01 04/25/2015
-- Design Name:   
-- Module Name:   /home/main/git/FPGA-MISC/ethernet-test/usrp_like_tb.vhd
-- Project Name:  ethernet-test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: usrp_like
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
 
ENTITY usrp_like_tb IS
END usrp_like_tb;
 
ARCHITECTURE behavior OF usrp_like_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT usrp_like
	 generic ( eth_width : positive := 4;
            eth_source : std_logic_vector((6 * 8) - 1 downto 0) := x"010203040506";
            eth_dest : std_logic_vector((6 * 8) - 1 downto 0) := x"00252235FA3B";
            ip_source : std_logic_vector((4 * 8) - 1 downto 0) := x"0A010101";
            ip_dest : std_logic_vector((4 * 8) - 1 downto 0) := x"0A010102";
            udp_source : std_logic_vector((2 * 8) - 1 downto 0) := x"1F98";
            udp_dest : std_logic_vector((2 * 8) - 1 downto 0) := x"1F98";
            payload_size : positive range 1 to 1400 := 5;
            reset_pause_cycles : positive := 100);
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         eth_rst_n : OUT  std_logic;
         eth_tx_data : OUT  std_logic_vector(3 downto 0);
         eth_tx_er : OUT  std_logic;
         eth_tx_clk : IN  std_logic;
			eth_tx_en : OUT std_logic;
         eth_smi_mdio : INOUT  std_logic;
         eth_smi_clk : OUT  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         wr_en : IN  std_logic;
         wr_clk : IN  std_logic;
         buffer_full : OUT  std_logic;
         buffer_empty : OUT  std_logic;
			eth_link_established : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal eth_tx_clk : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal wr_en : std_logic := '0';
   signal wr_clk : std_logic := '0';

	--BiDirs
   signal eth_smi_mdio : std_logic;

 	--Outputs
   signal eth_rst_n : std_logic;
   signal eth_tx_data : std_logic_vector(3 downto 0);
   signal eth_tx_er : std_logic;
   signal eth_smi_clk : std_logic;
   signal buffer_full : std_logic;
   signal buffer_empty : std_logic;
	signal eth_link_established : std_logic;
	signal eth_tx_en : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant eth_tx_clk_period : time := 10 ns;
   constant eth_smi_clk_period : time := 10 ns;
   constant wr_clk_period : time := 10 ns;
 
	signal samps : std_logic_vector(32 + 2 + 2 + 5 + 5 + 1 - 1 downto 0) := (others => '0');
	signal data : std_logic_vector(15 downto 0) := "0000000000001000";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: usrp_like PORT MAP (
          clk => clk,
          rst => rst,
          eth_rst_n => eth_rst_n,
          eth_tx_data => eth_tx_data,
          eth_tx_er => eth_tx_er,
          eth_tx_clk => eth_tx_clk,
          eth_smi_mdio => eth_smi_mdio,
          eth_smi_clk => eth_smi_clk,
          data_in => data_in,
          wr_en => wr_en,
          wr_clk => wr_clk,
          buffer_full => buffer_full,
          buffer_empty => buffer_empty
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   eth_tx_clk_process :process
   begin
		eth_tx_clk <= '0';
		wait for eth_tx_clk_period/2;
		eth_tx_clk <= '1';
		wait for eth_tx_clk_period/2;
   end process;
 
 
   wr_clk_process :process
   begin
		wr_clk <= '0';
		wait for wr_clk_period/2;
		wr_clk <= '1';
		wait for wr_clk_period/2;
   end process;
 
	smi_proc : process
		
	begin
			wait until rising_edge(eth_smi_clk);
			eth_smi_mdio <= 'Z';
			if(eth_smi_mdio = 'Z') then
				for i in data'range loop
					wait until rising_edge(eth_smi_clk);
					eth_smi_mdio <= data(i);
				end loop;
				eth_smi_mdio <= 'Z';
			end if;
	end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';

      wait for clk_period*10000;
		
		
		--wait until eth_link_established = '1';
		--rst <= '1';
		for i in 0 to 5 loop
			wr_en <= '1';
      data_in <= x"7e";
			--data_in <= std_logic_vector(to_unsigned(i, 8));
			wait for clk_period;
		end loop;
		wr_en <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
