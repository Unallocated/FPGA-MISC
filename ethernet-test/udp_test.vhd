LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY udp_test IS
END udp_test;
 
ARCHITECTURE behavior OF udp_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    signal ip_busy, ip_full, ip_prog_full, ip_empty, ip_dv, ip_dropped, ip_wr_en : std_logic := '0';
    signal ip_data_in, ip_data_out : std_logic_vector(7 downto 0) := (others => '0');
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
    
    signal udp_busy, udp_full, udp_prog_full, udp_empty, udp_dv, udp_dropped, udp_wr_en : std_logic := '0';
    signal udp_data_in, udp_data_out : std_logic_vector(7 downto 0) := (others => '0');
    COMPONENT udp_wrapper
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      data_in : IN std_logic_vector(7 downto 0);
      wr_en : IN std_logic;
      buffer_prog_full_val : IN std_logic_vector(10 downto 0);          
      busy : OUT std_logic;
      buffer_full : OUT std_logic;
      buffer_empty : OUT std_logic;
      buffer_prog_full : OUT std_logic;
      data_out : OUT std_logic_vector(7 downto 0);
      data_valid : OUT std_logic;
      dropped_frame : OUT std_logic
      );
    END COMPONENT;

    signal ethernet_busy, ethernet_full, ethernet_prog_full, ethernet_empty, ethernet_dv, ethernet_dropped, ethernet_wr_en : std_logic := '0';
    signal ethernet_data_in, ethernet_data_out : std_logic_vector(7 downto 0) := (others => '0');
    COMPONENT ethernet_wrapper
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      data_in : IN std_logic_vector(7 downto 0);
      wr_en : IN std_logic;
      buffer_prog_full_val : IN std_logic_vector(10 downto 0);          
      busy : OUT std_logic;
      buffer_full : OUT std_logic;
      buffer_empty : OUT std_logic;
      buffer_prog_full : OUT std_logic;
      data_out : OUT std_logic_vector(7 downto 0);
      data_valid : OUT std_logic;
      dropped_frame : OUT std_logic
      );
    END COMPONENT;


   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
  ip_wr_en <= udp_dv;
  ip_data_in <= udp_data_out;

  ethernet_wr_en <= ip_dv;
  ethernet_data_in <= ip_data_out;

	-- Instantiate the Unit Under Test (UUT)
   uut: ip_wrapper PORT MAP (
          clk => clk,
          rst => rst,
          data_in => ip_data_in,
          wr_en => ip_wr_en,
          busy => ip_busy,
          buffer_full => ip_full,
          buffer_empty => ip_empty,
          buffer_prog_full => ip_prog_full,
          buffer_prog_full_val => std_logic_vector(to_unsigned(600, 11)),
          data_out => ip_data_out,
          data_valid => ip_dv,
          dropped_frame => ip_dropped
        );

    Inst_udp_wrapper: udp_wrapper PORT MAP(
      clk => clk,
      rst => rst,
      data_in => udp_data_in,
      wr_en => udp_wr_en,
      busy => udp_busy,
      buffer_full => udp_full,
      buffer_empty => udp_empty,
      buffer_prog_full => udp_prog_full,
      buffer_prog_full_val => std_logic_vector(to_unsigned(600, 11)),
      data_out => udp_data_out,
      data_valid => udp_dv,
      dropped_frame => udp_dropped
    );

    Inst_ethernet_wrapper: ethernet_wrapper PORT MAP(
      clk => clk,
      rst => rst,
      data_in => ethernet_data_in,
      wr_en => ethernet_wr_en,
      busy => ethernet_busy,
      buffer_full => ethernet_full,
      buffer_empty => ethernet_empty,
      buffer_prog_full => ethernet_prog_full,
      buffer_prog_full_val => std_logic_vector(to_unsigned(600, 11)),
      data_out => ethernet_data_out,
      data_valid => ethernet_dv,
      dropped_frame => ethernet_dropped
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
        udp_wr_en <= '1';
        udp_data_in <= std_logic_vector(to_unsigned(i, 8));
        wait for clk_period;
      end loop;

      udp_data_in <= (others => '0');
      udp_wr_en <= '0';
      -- insert stimulus here 
      
      wait for clk_period * 52;

      for i in 1 to 8 loop
        udp_wr_en <= '1';
        udp_data_in <= std_logic_vector(to_unsigned(i, 8));
        wait for clk_period;
      end loop;

      udp_data_in <= (others => '0');
      udp_wr_en <= '0';


      wait for clk_period * 100;

      for i in 1 to 8 loop
        udp_wr_en <= '1';
        udp_data_in <= std_logic_vector(to_unsigned(i, 8));
        wait for clk_period;
      end loop;

      udp_data_in <= (others => '0');
      udp_wr_en <= '0';


      wait;
   end process;

END;
