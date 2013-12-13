library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fft_flow_4_no_fifos is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
		     leds : out STD_LOGIC_VECTOR(7 downto 0);
           adc_in : in  STD_LOGIC_VECTOR (11 downto 0);
           adc_clk : out  STD_LOGIC;
           switches : in  STD_LOGIC_VECTOR (7 downto 0);
           sine_out : out std_logic_vector(7 downto 0);
           hs : out  STD_LOGIC;
           vs : out  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0));
end fft_flow_4_no_fifos;

architecture Behavioral of fft_flow_4_no_fifos is

	signal mult_clk, mult_ce, mult_sclr : std_logic_vector(1 downto 0) := (others => '0');
	type mult_input_array_t is array(0 to 1) of std_logic_vector(7 downto 0);
	signal mult_a, mult_b : mult_input_array_t := (others => (others => '0'));
	type mult_output_array_t is array(0 to 1) of std_logic_vector(15 downto 0);
	signal mult_p : mult_output_array_t := (others => (others => '0'));
	
	COMPONENT multiplier
	  PORT (
	    a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    p : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	END COMPONENT;

	signal sqrt_in : std_logic_vector(15 downto 0) := (others => '0');
	signal sqrt_out : std_logic_vector(8 downto 0) := (others => '0');
	signal sqrt_ce, sqrt_clk, sqrt_rdy : std_logic := '0';

	COMPONENT sqrt_core
	  PORT (
	    x_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	    x_out : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	    rdy : OUT STD_LOGIC;
	    clk : IN STD_LOGIC;
	    ce : in std_logic
	  );
	END COMPONENT;

	signal dds_we, dds_rdy, dds_clk : std_logic := '0';
	signal dds_sine : std_logic_vector(7 downto 0) := (others => '0');
	signal dds_data : std_logic_vector(11 downto 0) := (others => '0');

	COMPONENT fft_flow_dds
	  PORT (
	    clk : IN STD_LOGIC;
	    we : IN STD_LOGIC;
	    data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	    rdy : OUT STD_LOGIC;
	    sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;

	signal fft_clk, fft_sclr, fft_start, fft_rfd, fft_busy, fft_edone, fft_done, fft_dv, fft_ce, fft_ovflo, fft_scale_we : std_logic := '0';
	signal fft_xn_re, fft_xn_im, fft_xk_re, fft_xk_im : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_xn_index, fft_xk_index : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_scale : std_logic_vector(15 downto 0) := (others => '0');

	COMPONENT fft_burst_mode
	  PORT (
	    clk : IN STD_LOGIC;
	    ce : IN STD_LOGIC;
	    start : IN STD_LOGIC;
	    xn_re : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xn_im : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    fwd_inv : IN STD_LOGIC;
	    fwd_inv_we : IN STD_LOGIC;
	    scale_sch : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	    scale_sch_we : IN STD_LOGIC;
	    rfd : OUT STD_LOGIC;
	    xn_index : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    busy : OUT STD_LOGIC;
	    edone : OUT STD_LOGIC;
	    done : OUT STD_LOGIC;
	    dv : OUT STD_LOGIC;
	    sclr : in STD_LOGIC;
	    xk_index : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xk_re : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xk_im : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    ovflo : OUT STD_LOGIC
	  );
	END COMPONENT;

	signal blue_in : std_logic_vector(1 downto 0) := (others => '0');
	signal red_in, green_in : std_logic_vector(2 downto 0) := (others => '0');
	signal x_pos, y_pos : integer := 0;
	
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
	
	signal original_clk, vga_clk : std_logic := '0';
	
	component fft_flow_4_no_fifos_dcm
		port (
		  CLK_IN1  : in  std_logic;
		  VGA_CLK  : out std_logic;
		  BASE_CLK : out std_logic;
		  CLK_OUT3 : out std_logic;
		  RESET    : in  std_logic
		 );
	end component;

	type adc_ram_t is array(0 to 255) of std_logic_vector(7 downto 0);
	signal adc_ram : adc_ram_t := (others => (others => '0'));
	signal adc_ram_pos : unsigned(adc_ram(0)'range) := (others => '0');
	type adc_state_t is (ADC_CLK_HIGH, ADC_CLK_LOW);
	signal adc_state : adc_state_t := ADC_CLK_HIGH;
	
	type fft_out_ram_t is array(0 to 127) of std_logic_vector(15 downto 0);
	signal fft_out_ram : fft_out_ram_t := (others => (others => '0'));
	signal fft_ram_pos : unsigned(adc_ram(0)'high-1 downto 0) := (others => '0');
	type fft_state_t is (FFT_WAIT_FOR_RFD, FFT_LOAD, FFT_STALL, FFT_WAIT_FOR_DV, FFT_UNLOAD);
	signal fft_state : fft_state_t := FFT_WAIT_FOR_RFD;
	
	type vga_ram_t is array(0 to 127) of std_logic_vector(7 downto 0);
	signal vga_ram : vga_ram_t := (others => (others => '0'));
	signal vga_ram_pos : unsigned(adc_ram(0)'high-1 downto 0) := (others => '0');
	
	type mag_state_t is (MAG_1, MAG_2, MAG_3, MAG_4);
	signal mag_state : mag_state_t := MAG_1;
	
	type master_state_t is (STARTUP, SAMPLE, FFT, MAG);
	signal master_state : master_state_t := STARTUP;
	
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
begin

	sine_out <= std_logic_vector(unsigned(dds_sine) + 127);

	process(dds_clk, rst)
		variable a : unsigned(15 downto 0);  --original input.
		variable q : unsigned(15 downto 0):=(others => '0');  --result.
		variable left,right,r : unsigned(17 downto 0):=(others => '0');  --input to adder/sub.r-remainder.
		variable i : integer:=0;
		variable iteration : integer range 0 to 15 := 0;
		variable im, re : std_logic_vector(7 downto 0);
	begin
		if(rst = '1') then
			vga_ram <= (others => (others => '0'));
			fft_out_ram <= (others => (others => '0'));
			adc_ram <= (others => (others => '0'));
			
			vga_ram_pos <= (others => '0');
			fft_ram_pos <= (others => '0');
			adc_ram_pos <= (others => '0');
			
			fft_start <= '0';
			master_state <= STARTUP;
		elsif(rising_edge(original_clk)) then
			case master_state is
			when STARTUP =>
				master_state <= SAMPLE;
				adc_state <= ADC_CLK_HIGH;
				adc_ram_pos <= (others => '0');
			when SAMPLE =>
				case adc_state is
				when ADC_CLK_HIGH =>
					adc_clk <= '1';
					adc_state <= ADC_CLK_LOW;
				when ADC_CLK_LOW =>
					adc_clk <= '0';
					adc_ram(to_integer(adc_ram_pos)) <= std_logic_vector(unsigned(dds_sine) + 127);
					--adc_ram(to_integer(adc_ram_pos)) <= adc_in;
					if(adc_ram_pos = (adc_ram_pos'range => '1')) then
						master_state <= FFT;
						fft_state <= FFT_WAIT_FOR_RFD;
						adc_ram_pos <= (others => '0');
					else
						adc_ram_pos <= adc_ram_pos + 1;
						adc_state <= ADC_CLK_HIGH;
					end if;
				end case;
			when FFT =>
				case fft_state is
				when FFT_WAIT_FOR_RFD =>
					fft_start <= '1';
					if(fft_rfd = '1') then
						fft_state <= FFT_LOAD;
						--fft_start <= '0';
					end if;
				when FFT_LOAD =>
					if(fft_rfd = '1') then
						fft_xn_re <= adc_ram(to_integer(unsigned(fft_xn_index)));
					else
						fft_state <= FFT_STALL;
					end if;
				when FFT_STALL =>
					if(fft_edone = '1') then
						fft_state <= FFT_WAIT_FOR_DV;
					end if;
				when FFT_WAIT_FOR_DV =>
					if(fft_dv = '1') then
						fft_state <= FFT_UNLOAD;
					end if;
				when FFT_UNLOAD =>
					if(fft_dv = '1') then
						fft_start <= '0';
						if(fft_xk_index(fft_xk_index'high) = '0') then
							leds <= fft_xk_re;
							if(fft_xk_re(fft_xk_re'high) = '1') then
								re := not fft_xk_re;
							else
								re := fft_xk_re;
							end if;
							
							if(fft_xk_im(fft_xk_im'high) = '1') then
								im := not fft_xk_im;
							else
								im := fft_xk_im;
							end if;
							
							fft_out_ram(to_integer(unsigned(fft_xk_index(6 downto 0)))) <= re & im;
						end if;
					else
						fft_start <= '0';
						master_state <= MAG;
						mult_ce <= (others => '1');
						mag_state <= MAG_1;
						fft_state <= FFT_WAIT_FOR_RFD;
						iteration := 0;
					end if;
				end case;
			when MAG =>
				case mag_state is
				when MAG_1 =>
--					mult_a(0) <= fft_out_ram(to_integer(unsigned(fft_ram_pos)))(15 downto 8);
--					mult_a(1) <= fft_out_ram(to_integer(unsigned(fft_ram_pos)))(7 downto 0);
--				
--					mult_b(0) <= fft_out_ram(to_integer(unsigned(fft_ram_pos)))(15 downto 8);
--					mult_b(1) <= fft_out_ram(to_integer(unsigned(fft_ram_pos)))(7 downto 0);
					
				
					a := (unsigned(fft_out_ram(to_integer(unsigned(fft_ram_pos)))(15 downto 8)) * unsigned(fft_out_ram(to_integer(unsigned(fft_ram_pos)))(15 downto 8))) + 
						 (unsigned(fft_out_ram(to_integer(unsigned(fft_ram_pos)))(7 downto 0)) * unsigned(fft_out_ram(to_integer(unsigned(fft_ram_pos)))(7 downto 0)));
					sqrt_ce <= '1';
					sqrt_in <= std_logic_vector(a);
					mag_state <= MAG_4;
				when MAG_2 =>
					mag_state <= MAG_3;
				when MAG_3 =>
					sqrt_in <= std_logic_vector(unsigned(mult_p(0)) + unsigned(mult_p(1)));
					sqrt_ce <= '1';
					mag_state <= MAG_3;
				when MAG_4 =>
						if(sqrt_rdy = '1') then
							vga_ram(to_integer(fft_ram_pos)) <= sqrt_out(7 downto 0);
							if(fft_ram_pos = (fft_ram_pos'range => '1')) then
								master_state <= SAMPLE;
								sqrt_ce <= '0';
								mult_ce <= (others => '0');
								fft_ram_pos <= (fft_ram_pos'range => '0');
							else
								fft_ram_pos <= fft_ram_pos + 1;
							end if;
							
							mag_state <= MAG_1;
						end if;
				end case;
			end case;
		end if;
	end process;

	fft_instance : fft_burst_mode
	  PORT MAP (
	    clk => dds_clk,
	    ce => '1',
	    start => fft_start,
	    xn_re => fft_xn_re,
	    xn_im => fft_xn_im,
	    fwd_inv => '1',
	    fwd_inv_we => '1',
	    scale_sch => fft_scale,
	    scale_sch_we => fft_scale_we,
	    rfd => fft_rfd,
	    xn_index => fft_xn_index,
	    busy => fft_busy,
	    edone => fft_edone,
	    done => fft_done,
	    dv => fft_dv,
	    sclr => fft_sclr,
	    xk_index => fft_xk_index,
	    xk_re => fft_xk_re,
	    xk_im => fft_xk_im,
	    ovflo => fft_ovflo
	  );

	vga_controller : process(vga_clk, rst)
	begin
		if(rst = '1') then
			blue_in <= (others => '0');
			red_in <= (others => '0');
			green_in <= (others => '0');
		elsif(rising_edge(vga_clk)) then
			blue_in <= (others => '0');
			red_in <= (others => '0');
			green_in <= (others => '0');
			if(x_pos > -1 and y_pos > -1 and x_pos < vga_ram'length) then
				if(vga_ram(x_pos) <= std_logic_vector(to_unsigned(y_pos, vga_ram(0)'length))) then
					blue_in <= (others => '1');
				end if;
			end if;
		end if;
	end process;
	    
	vga_instance : vga_configurable PORT MAP(
		clk => vga_clk,
		rst => rst,
		hs => hs,
		vs => vs,
		green => green,
		red => red,
		blue => blue,
		x_pos => x_pos,
		y_pos => y_pos,
		blue_in => blue_in,
		red_in => red_in,
		green_in => green_in
	);
	
	scale_changer_process : process(original_clk, rst)
		variable last_switches : std_logic_vector(switches'range) := (others => '0');
		variable toggle : std_logic := '0';
	begin
		if(rst = '1') then
			fft_scale <= (others => '0');
			fft_scale_we <= '0';
			toggle := '0';
		elsif(rising_edge(original_clk)) then
			if(last_switches /= switches) then
				last_switches := switches;
				fft_scale <= switches & switches;
				toggle := '0';
			end if;
			
			if(toggle = '0') then
				fft_scale_we <= '1';
				toggle := '1';
			else
				fft_scale_we <= '0';
			end if;
		end if;
	end process;
--	
	dds_changer_process : process(original_clk, rst)
		variable last_input : std_logic_vector(dds_data'range) := (others => '0');
		variable toggle : std_logic := '0';
	begin
		if(rst = '1') then
			dds_data <= (others => '0');
			dds_we <= '0';
			toggle := '0';
		elsif(rising_edge(original_clk)) then
			if(last_input /= adc_in) then
				last_input := adc_in;
				dds_data <= adc_in;
				toggle := '0';
			end if;
			
			if(toggle = '0') then
				dds_we <= '1';
				toggle := '1';
			else
				dds_we <= '0';
			end if;
		end if;
	end process;
	
	sqrt_inst : sqrt_core
	  PORT MAP (
	    x_in => sqrt_in,
	    x_out => sqrt_out,
	    rdy => sqrt_rdy,
	    clk => dds_clk,
	    ce => sqrt_ce
	  );
	
	dcm_instance : fft_flow_4_no_fifos_dcm
	  port map(
	    CLK_IN1  => clk,
	    VGA_CLK  => vga_clk,
	    BASE_CLK => original_clk,
	    CLK_OUT3 => dds_clk,
	    RESET    => rst);
	    
	dds_inst : fft_flow_dds
	  PORT MAP (
	    clk => dds_clk,
	    we => dds_we,
	    data => dds_data,
	    rdy => dds_rdy,
	    sine => dds_sine
	  );
	  
	mult_1_inst : multiplier
  PORT MAP (
    a => mult_a(0),
    b => mult_b(0),
    p => mult_p(0)
  );

	mult_2_inst : multiplier
  PORT MAP (
    a => mult_a(1),
    b => mult_b(1),
    p => mult_p(1)
  );

end Behavioral;

