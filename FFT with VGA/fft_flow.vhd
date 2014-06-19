library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fft_flow is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           phase_angle_in : in  STD_LOGIC_VECTOR (7 downto 0);
		     phase_out : out STD_LOGIC_VECTOR(7 downto 0);
		     leds : out STD_LOGIC_VECTOR(7 downto 0);
           --adc_in : in  STD_LOGIC_VECTOR (7 downto 0);
           --adc_clk : out  STD_LOGIC;
           switches : in  STD_LOGIC_VECTOR (7 downto 0);
           hs : out  STD_LOGIC;
           vs : out  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0));
end fft_flow;

architecture Behavioral of fft_flow is

	signal dds_data : std_logic_vector(phase_angle_in'range) := "01111111";
	signal dds_we : std_logic := '0';
	signal phase_angle_last_clk : std_logic := '0';
	signal dds_rdy : std_logic;
	signal dds_writer_clk_en : std_logic := '0';
	signal dds_clk : std_logic := '0';
	
	signal phase_buffer : std_logic_vector(phase_out'range) := (others => '0');
	
	type phase_state_t is (PHASE_IDLE, PHASE_WE);
	signal phase_state : phase_state_t := PHASE_IDLE;

	COMPONENT fft_flow_dds
	  PORT (
		 clk : IN STD_LOGIC;
		 we : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 rdy : OUT STD_LOGIC;
		 sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal fft_start, fft_rfd, fft_busy, fft_edone, fft_done, fft_dv, fft_ce, fft_scale_sch_we : std_logic := '0';
	signal fft_xn_re, fft_xn_im, fft_xk_re, fft_xk_im : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_xn_index, fft_xk_index, fft_scale_sch : std_logic_vector(7 downto 0) := (others => '0');
	
	COMPONENT fft_flow_fft
	  PORT (
		 clk : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 xn_re : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 xn_im : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 fwd_inv : IN STD_LOGIC;
		 fwd_inv_we : IN STD_LOGIC;
		 rfd : OUT STD_LOGIC;
		 xn_index : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 busy : OUT STD_LOGIC;
		 edone : OUT STD_LOGIC;
		 done : OUT STD_LOGIC;
		 dv : OUT STD_LOGIC;
		 ce : IN STD_LOGIC;
		 scale_sch : in STD_LOGIC_VECTOR(7 downto 0);
		 scale_sch_we : in STD_LOGIC;
		 xk_index : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 xk_re : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 xk_im : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
--		 blk_exp : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	  );
	END COMPONENT;
	
	
	type vga_ram_t is array (0 to ((2 ** fft_xn_index'length) / 2) - 1) of std_logic_vector(7 downto 0);
	signal vga_ram : vga_ram_t := (others => (others => '0'));
	
	type adc_ram_t is array (0 to (2 ** fft_xn_index'length) - 1) of std_logic_vector(7 downto 0);
	signal adc_ram : adc_ram_t := (others => (others => '0'));
	signal adc_ram_pos : integer range 0 to adc_ram_t'length := 0;
	
	COMPONENT vga_configurable
		PORT(
			clk : IN std_logic;
			rst : IN std_logic;
			blue_in : IN std_logic_vector(1 downto 0);
			red_in : IN std_logic_vector(2 downto 0);
			green_in : IN std_logic_vector(2 downto 0);          
			hs : OUT std_logic;
			vs : OUT std_logic;
			green : OUT std_logic_vector(2 downto 0);
			red : OUT std_logic_vector(2 downto 0);
			blue : OUT std_logic_vector(1 downto 0);
			x_pos : OUT integer;
			y_pos : OUT integer
			);
	END COMPONENT;
	
	
	function  sqrt  ( d : UNSIGNED ) return UNSIGNED is
		variable a : unsigned(31 downto 0):=d;  --original input.
		variable q : unsigned(15 downto 0):=(others => '0');  --result.
		variable left,right,r : unsigned(17 downto 0):=(others => '0');  --input to adder/sub.r-remainder.
		variable i : integer:=0;

	begin
		for i in 0 to 15 loop
			right(0):='1';
			right(1):=r(17);
			right(17 downto 2):=q;
			left(1 downto 0):=a(31 downto 30);
			left(17 downto 2):=r(15 downto 0);
			a(31 downto 2):=a(29 downto 0);  --shifting by 2 bit.
			if ( r(17) = '1') then
				r := left + right;
			else
				r := left - right;
			end if;
			q(15 downto 1) := q(14 downto 0);
			q(0) := not r(17);
		end loop; 
		return q(7 downto 0);

	end sqrt;
	
--	type fft_state_t is (IDLE, READ_SAMPLES, LOAD_SAMPLES, STALL, UNLOAD_SAMPLES);
type fft_state_t is (IDLE, LOAD_SAMPLES, STALL);
	signal fft_state : fft_state_t := IDLE;
	type adc_state_t is (CLOCKING, READING);
	signal adc_state : adc_state_t := CLOCKING;
	
	signal vga_clk : std_logic := '0';
	signal x,y : integer := 0;
	signal blue_in : std_logic_vector(blue'range) := (others => '0');
	signal red_in : std_logic_vector(red'range) := (others => '0');
	signal green_in : std_logic_vector(green'range) := (others => '0');
	
	component vga_clock_dcm
		port (
		  in_100MHz           : in     std_logic;
		  VGA_25MHz          : out    std_logic;
		  original_clk          : out    std_logic;
		  dds_clk : out std_logic;
		  RESET             : in     std_logic
		 );
	end component;
	
	signal original_clk : std_logic := '0';
	signal adc_in : std_logic_vector(7 downto 0);
	signal adc_clk : std_logic := '0';
begin
	red_in <= (others => '0');
	green_in <= (others => '0');
	phase_out <= std_logic_vector(unsigned(phase_buffer) + to_unsigned(128, 8));
	adc_in <= phase_buffer;
	
	vga_dcm : vga_clock_dcm
	  port map(
	    in_100MHz => clk,
	    VGA_25MHz => vga_clk,
	    original_clk => original_clk,
	    dds_clk => dds_clk,
	    RESET  => rst);

	vga: vga_configurable PORT MAP(
		clk => vga_clk,
		rst => rst,
		hs => hs,
		vs => vs,
		green => green,
		red => red,
		blue => blue,
		x_pos => x,
		y_pos => y,
		blue_in => blue_in,
		red_in => red_in,
		green_in => green_in
	);
	
	vga_controller : process(vga_clk, rst)
	begin
		if(rst = '1') then
			blue_in <= (others => '0');
		elsif(rising_edge(vga_clk)) then
			if(x > -1 and y > -1 and x < vga_ram'length) then
				if(vga_ram(x) = std_logic_vector(to_unsigned(y, vga_ram(0)'length))) then
					blue_in <= (others => '1');
				else
					blue_in <= (others => '0');
				end if;
			end if;
		end if;
	end process;

	fft_controller : process(original_clk, rst)
		--variable temp : unsigned(31 downto 0) := (others => '0');
	begin
		if(rst = '1') then
			fft_state <= IDLE;
			adc_ram <= (others => (others => '0'));
			vga_ram <= (others => (others => '0'));
		elsif(rising_edge(original_clk)) then
			case fft_state is
			when IDLE =>
				fft_start <= '1';
				fft_ce <= '1';
				adc_ram_pos <= 0;
				if(dds_rdy = '1') then
					fft_state <= LOAD_SAMPLES;
				end if;
--			when READ_SAMPLES =>
--				case adc_state is
--				when CLOCKING =>
--					adc_clk <= '1';
--					adc_state <= READING;
--				when READING =>
--					adc_clk <= '0';
--					adc_state <= CLOCKING;
--					adc_ram(adc_ram_pos) <= adc_in;
--					if(adc_ram_pos = adc_ram'high) then
--						fft_state <= LOAD_SAMPLES;
--						adc_ram_pos <= 0;
--					else
--						adc_ram_pos <= adc_ram_pos + 1;
--					end if;
--				end case;
			when LOAD_SAMPLES =>
				fft_start <= '1';
				fft_ce <= '1';
				adc_ram_pos <= 0;
				if(fft_rfd = '1') then
					fft_start <= '0';
					fft_xn_re <= adc_ram(to_integer(unsigned(fft_xn_index)));
					if(fft_xn_index = (fft_xn_index'range => '1')) then
						fft_state <= STALL;
					end if;
				end if;
			when STALL =>
				case adc_state is
				when CLOCKING =>
					adc_clk <= '1';
					adc_state <= READING;
				when READING =>
					adc_clk <= '0';
					adc_state <= CLOCKING;
					adc_ram(adc_ram_pos) <= adc_in;
					if(adc_ram_pos = adc_ram'high) then
						--fft_state <= LOAD_SAMPLES;
					else
						adc_ram_pos <= adc_ram_pos + 1;
					end if;
				end case;
				
				if(fft_dv = '1') then
					if(fft_xk_index(fft_xk_index'high) = '0') then
						vga_ram(to_integer(unsigned(fft_xk_index))) <= std_logic_vector(sqrt(x"0000" & ((unsigned(fft_xk_re) * unsigned(fft_xk_re)) + (unsigned(fft_xk_im) * unsigned(fft_xk_im)))));
					end if;
				end if;
				
				if(fft_xk_index(fft_xk_index'high) = '1' and adc_ram_pos = adc_ram'high) then
					fft_state <= IDLE;
				end if;
				
--			when UNLOAD_SAMPLES =>
--				if(fft_dv = '1') then
--	--				temp := sqrt(((unsigned(fft_xk_re) * unsigned(fft_xk_re)) + (unsigned(fft_xk_im) * unsigned(fft_xk_im))));
--	--				temp := std_logic_vector((to_unsigned(fft_xk_re) * fft_xk_re) + (fft_xk_im * fft_xk_im));
--					--vga_ram(to_integer(unsigned(fft_xk_index))) <= (others => '1');
--					--vga_ram(to_integer(unsigned(fft_xk_index))) <= fft_xk_index(7 downto 0);
--					
--					--vga_ram(to_integer(unsigned(fft_xk_index))) <= std_logic_vector(sqrt(x"0000" & ((unsigned(fft_xk_re) * unsigned(fft_xk_re)) + (unsigned(fft_xk_im) * unsigned(fft_xk_im)))));
--					if(fft_xk_index(fft_xk_index'high) = '0') then
----						vga_ram(to_integer(unsigned(fft_xk_index))) <= std_logic_vector(unsigned(fft_xk_re) + unsigned(fft_xk_im));
--						vga_ram(to_integer(unsigned(fft_xk_index))) <= std_logic_vector(sqrt(x"0000" & ((unsigned(fft_xk_re) * unsigned(fft_xk_re)) + (unsigned(fft_xk_im) * unsigned(fft_xk_im)))));
--					end if;
--				else
--					fft_state <= IDLE;
--				end if;
			end case;
		end if;
	end process;


	leds(3 downto 0) <= phase_angle_in(3 downto 0);
	leds(4) <= '0';
	leds(5) <= dds_writer_clk_en;
	leds(6) <= dds_we;
	leds(7) <= dds_data(0);
	
	dds : fft_flow_dds
	  PORT MAP (
		 clk => dds_clk,
		 we => dds_we,
		 data => dds_data,
		 rdy => dds_rdy,
		 sine => phase_buffer
	  );
	  
	fft : fft_flow_fft
	  PORT MAP (
		 clk => original_clk,
		 start => fft_start,
		 xn_re => fft_xn_re,
		 xn_im => fft_xn_im,
		 fwd_inv => '1',
		 fwd_inv_we => '1',
		 rfd => fft_rfd,
		 xn_index => fft_xn_index,
		 busy => fft_busy,
		 edone => fft_edone,
		 done => fft_done,
		 dv => fft_dv,
		 scale_sch => fft_scale_sch,
		 scale_sch_we => fft_scale_sch_we,
		 ce => fft_ce,
		 xk_index => fft_xk_index,
		 xk_re => fft_xk_re,
		 xk_im => fft_xk_im
--		 blk_exp => open
	  );
	
	process(original_clk, rst)
		variable last_switches : std_logic_vector(switches'range) := (others => '0');
		variable toggle : std_logic := '0';
	begin
		if(rst = '1') then
			--last_switches := (others => '0');
			fft_scale_sch <= (others => '0');
			fft_scale_sch_we <= '0';
			toggle := '0';
		elsif(rising_edge(original_clk)) then
			if(last_switches /= switches) then
				last_switches := switches;
				fft_scale_sch <= switches;
				toggle := '0';
			end if;
			
			if(toggle = '0') then
				fft_scale_sch_we <= '1';
				toggle := '1';
			else
				fft_scale_sch_we <= '0';
			end if;
		end if;
	end process;
				
			
		

--   dds_divider : process(original_clk, rst)
--		constant max : unsigned(1 downto 0) := to_unsigned(2, 2);
--		variable counter : unsigned(max'range) := (others => '0');
--	begin
--		if(rst = '1') then
--			counter := (others => '0');
--		elsif(rising_edge(original_clk)) then
--			if(counter = max) then
--				counter := (others => '0');
--				dds_clk <= '1';
--			else
--				counter := counter + 1;
--				dds_clk <= '0';
--			end if;
--		end if;
--	end process;
	
--   phase_angle_input_divider : process(original_clk, rst)
--		constant max : unsigned(31 downto 0) := to_unsigned(0, 32);
--		variable counter : unsigned(max'range) := (others => '0');
--	begin
--		if(rst = '1') then
--			counter := (others => '0');
--		elsif(rising_edge(original_clk)) then
--			if(counter = max) then
--				counter := (others => '0');
--				dds_writer_clk_en <= '1';
--			else
--				counter := counter + 1;
--				dds_writer_clk_en <= '0';
--			end if;
--		end if;
--	end process;
	
	phase_angle_inc : process(original_clk, rst)
		variable last_phase_in : std_logic_vector(phase_angle_in'range) := (others => '0');
	begin
		if(rst = '1') then
			dds_data <= "01111111";
			phase_state <= PHASE_IDLE;
			dds_we <= '0';
		elsif(rising_edge(original_clk)) then
			case phase_state is
			when PHASE_IDLE =>
				dds_we <= '0';
				if(last_phase_in /= phase_angle_in) then
					dds_data <= phase_angle_in;
					phase_state <= PHASE_WE;
					last_phase_in := phase_angle_in;
				end if;
			when PHASE_WE =>
				dds_we <= '1';
				phase_state <= PHASE_IDLE;
			end case;
		end if;
	end process;

--	phase_angle_inc : process(clk, rst)
--	begin
--		if(rst = '1') then
--			dds_data <= "01111111";
--			phase_state <= PHASE_IDLE;
--			dds_we <= '0';
--		elsif(rising_edge(clk)) then
--			case phase_state is
--			when PHASE_IDLE =>
--				--if(dds_writer_clk_en <= '1') then
--					dds_we <= '0';
--					if(phase_angle_last_clk = '0' and phase_angle_clk = '1') then
--						dds_data <= phase_angle_in;
--						phase_state <= PHASE_WE;
--					end if;
--				--end if;
--				
--				phase_angle_last_clk <= phase_angle_clk;
--			when PHASE_WE =>
--				dds_we <= '1';
--				phase_state <= PHASE_IDLE;
--			end case;
--		end if;
--	end process;

end Behavioral;

