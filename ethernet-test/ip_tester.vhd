LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY ip_tester IS
END ip_tester;
 
ARCHITECTURE behavior OF ip_tester IS 
 
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
	constant samp_period : time := 110 ns;
	
	constant frame_size : positive := 256;
	
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
	
	signal last_val : std_logic_vector(7 downto 0) := (others => '0');
	signal is_first_pass : std_logic := '1';
	signal last_data_valid : std_logic := '0';
BEGIN

	samp_clk_proc : process
	begin
		samp_clk <= not samp_clk;
		wait for samp_period;
	end process;
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			assert (dropped_frame = '0') report "DROPPED FRAME" severity failure;
		end if;
	end process;
	
	process
	begin
		wait until rising_edge(clk);
		last_data_valid <= data_valid;
	end process;
	
	process
	begin
		wait until rising_edge(clk) and last_data_valid = '0' and data_valid = '1';
		wait for clk_period * 20;
		
		if(is_first_pass = '1') then
			wait for clk_period * (frame_size);
			last_val <= data_out;
			is_first_pass <= '0';
		else
			for i in 0 to frame_size loop
				assert (unsigned(data_out) = unsigned(last_val) + 1) report "ACK" severity warning;
				
				last_val <= data_out;
				wait for clk_period;
			end loop;
		end if;
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
	
	data_in <= samp_dout;
	wr_en <= samp_dv;
 
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
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
