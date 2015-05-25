LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY udp_ip_tester IS
END udp_ip_tester;
 
ARCHITECTURE behavior OF udp_ip_tester IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
		signal udp_last_val, udp_din, udp_dout : std_logic_vector(7 downto 0);
		signal udp_busy, udp_prog_full, udp_full, udp_empty, udp_dv, udp_last_dv, udp_dropped, udp_wr_en : std_logic := '0';
		signal udp_is_first_pass : std_logic := '1';
		signal udp_prog_full_val : std_logic_vector(10 downto 0) := std_logic_vector(to_unsigned(1000, 11));
    COMPONENT udp_wrapper
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
	
		signal ip_last_val, ip_din, ip_dout : std_logic_vector(7 downto 0);
		signal ip_busy, ip_prog_full, ip_full, ip_empty, ip_dv, ip_last_dv, ip_dropped, ip_wr_en : std_logic := '0';
		signal ip_is_first_pass : std_logic := '1';
		signal ip_prog_full_val : std_logic_vector(10 downto 0) := std_logic_vector(to_unsigned(1000, 11));
		COMPONENT ip_wrapper
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
   constant clk_period : time := 90 ns;
	constant samp_period : time := 110 ns;
	
	constant frame_size : positive := 128;
	
	signal samp_clk : std_logic := '0';
	signal samp_wr_en, samp_dv, samp_rdy, samp_ovflo : std_logic := '0';
	signal samp_dout, samp_din : std_logic_vector(7 downto 0) := (others => '0');
	COMPONENT sampling_buff
	Generic ( frame_size : positive := frame_size );
	PORT(
		wr_clk : IN std_logic;
		rst : IN std_logic;
		wr_en : IN std_logic;
		rd_clk : IN std_logic;
		data_in : IN std_logic_vector(7 downto 0);          
		dv : OUT std_logic;
		ovflo : OUT std_logic;
		rdy : OUT std_logic;
		data_out : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
BEGIN
	
	------------------------------------------
	--      BEGIN IP WRAPPER TEST           --
	------------------------------------------
	process(clk)
	begin
		if(rising_edge(clk)) then
			assert (ip_dropped = '0') report "IP DROPPED FRAME" severity failure;
		end if;
	end process;
	
	process
	begin
		wait until rising_edge(clk);
		ip_last_dv <= ip_dv;
	end process;
	
	process
	begin
		wait until rising_edge(clk) and ip_last_dv = '0' and ip_dv = '1';
		wait for clk_period * 28;
		
		if(ip_is_first_pass = '1') then
			wait for clk_period * (frame_size);
			ip_last_val <= ip_dout;
			ip_is_first_pass <= '0';
		else
			for i in 0 to frame_size loop
				assert (unsigned(ip_dout) = unsigned(ip_last_val) + 1) report "IP VALUE NOT WHAT WAS EXPECTED" severity warning;
				
				ip_last_val <= ip_dout;
				wait for clk_period;
			end loop;
		end if;
	end process;

		
	------------------------------------------
	--        BEGIN UDP WRAPPER TEST        --
	------------------------------------------
	process(clk)
	begin
		if(rising_edge(clk)) then
			assert (udp_dropped = '0') report "UDP DROPPED FRAME" severity failure;
		end if;
	end process;
	
	process
	begin
		wait until rising_edge(clk);
		udp_last_dv <= udp_dv;
	end process;
	
	process
	begin
		wait until rising_edge(clk) and udp_last_dv = '0' and udp_dv = '1';
		wait for clk_period * 8;
		
		if(udp_is_first_pass = '1') then
			wait for clk_period * (frame_size);
			udp_last_val <= udp_dout;
			udp_is_first_pass <= '0';
		else
			for i in 0 to frame_size loop
				assert (unsigned(udp_dout) = unsigned(udp_last_val) + 1) report "UDP VALUE NOT WHAT WAS EXPECTED" severity warning;
				
				udp_last_val <= udp_dout;
				wait for clk_period;
			end loop;
		end if;
	end process;
	
	
	
	
	-------------------------------------------
	--             FIFO LOADER               --
	-------------------------------------------
	samp_clk_proc : process
	begin
		samp_clk <= not samp_clk;
		wait for samp_period;
	end process;

	data_gen : process
	begin
		wait until rising_edge(samp_clk);
		samp_wr_en <= '1';
		samp_din <= std_logic_vector(unsigned(samp_din) + 1);
	end process;

	Inst_sampling_buff: sampling_buff PORT MAP(
		wr_clk => samp_clk,
		rst => rst,
		wr_en => samp_wr_en,
		rd_clk => clk,
		dv => samp_dv,
		ovflo => samp_ovflo,
		rdy => samp_rdy,
		data_in => samp_din,
		data_out => samp_dout
	);


	udp_din <= samp_dout;
	udp_wr_en <= samp_dv;

	ip_din <= udp_dout;
	ip_wr_en <= udp_dv;

	-- Instantiate the Unit Under Test (UUT)
   uut: udp_wrapper PORT MAP (
          clk => clk,
          rst => rst,
          data_in => udp_din,
          wr_en => udp_wr_en,
          busy => udp_busy,
          buffer_full => udp_full,
          buffer_empty => udp_empty,
          buffer_prog_full => udp_prog_full,
          buffer_prog_full_val => udp_prog_full_val,
          data_out => udp_dout,
          data_valid => udp_dv,
          dropped_frame => udp_dropped
        );

		uut2: ip_wrapper PORT MAP (
          clk => clk,
          rst => rst,
          data_in => ip_din,
          wr_en => ip_wr_en,
          busy => ip_busy,
          buffer_full => ip_full,
          buffer_empty => ip_empty,
          buffer_prog_full => ip_prog_full,
          buffer_prog_full_val => ip_prog_full_val,
          data_out => ip_dout,
          data_valid => ip_dv,
          dropped_frame => ip_dropped
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

      -- insert stimulus here 

      wait;
   end process;

END;
