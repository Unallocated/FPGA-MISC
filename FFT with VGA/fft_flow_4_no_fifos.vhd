library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fft_flow_4_no_fifos is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
		     leds : out STD_LOGIC_VECTOR(7 downto 0);
           adc_in : in  STD_LOGIC_VECTOR (7 downto 0);
           adc_clk : out  STD_LOGIC;
           switches : in  STD_LOGIC_VECTOR (7 downto 0);
           hs : out  STD_LOGIC;
           vs : out  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0));
end fft_flow_4_no_fifos;

architecture Behavioral of fft_flow_4_no_fifos is

	signal fft_clk, fft_sclr, fft_start, fft_rfd, fft_busy, fft_edone, fft_done, fft_dv, fft_ce, fft_ovflo, fft_scale_we : std_logic := '0';
	signal fft_xn_re, fft_xn_im, fft_xk_re, fft_xk_im : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_xn_index, fft_xk_index, fft_scale : std_logic_vector(7 downto 0) := (others => '0');

	COMPONENT fft_burst_mode
	  PORT (
	    clk : IN STD_LOGIC;
	    ce : IN STD_LOGIC;
	    start : IN STD_LOGIC;
	    xn_re : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xn_im : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    fwd_inv : IN STD_LOGIC;
	    fwd_inv_we : IN STD_LOGIC;
	    scale_sch : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
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
	
	component flow_3_dcm
		port (
		  CLK_IN1  : in  std_logic;
		  VGA_CLK  : out std_logic;
		  BASE_CLK : out std_logic;
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
	signal fft_ram_pos : unsigned(adc_ram(0)'range) := (others => '0');
	type fft_state_t is (FFT_WAIT_FOR_RFD, FFT_LOAD, FFT_STALL, FFT_UNLOAD);
	signal fft_state : fft_state_t := FFT_WAIT_FOR_RFD;
	
	type vga_ram_t is array(0 to 127) of std_logic_vector(7 downto 0);
	signal vga_ram : vga_ram_t := (others => (others => '0'));
	signal vga_ram_pos : unsigned(adc_ram(0)'range) := (others => '0');
	
	type mag_state_t is (MAG_1, MAG_2);
	signal mag_state : mag_state_t := MAG_1;
	
	type master_state_t is (STARTUP, SAMPLE, FFT, MAG);
	signal master_state : master_state_t := STARTUP;

begin

	process(original_clk, rst)
		variable a : unsigned(31 downto 0);  --original input.
		variable q : unsigned(15 downto 0):=(others => '0');  --result.
		variable left,right,r : unsigned(17 downto 0):=(others => '0');  --input to adder/sub.r-remainder.
		variable i : integer:=0;
		variable iteration : integer range 0 to 15 := 0;
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
					adc_ram(to_integer(adc_ram_pos)) <= adc_in;
					if(adc_ram_pos = (adc_ram_pos'range => '1')) then
						master_state <= FFT;
						fft_state <= FFT_WAIT_FOR_RFD;
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
						fft_start <= '0';
					end if;
				when FFT_LOAD =>
					if(fft_rfd = '1') then
						fft_xn_re <= adc_ram(to_integer(unsigned(fft_xn_index)));
					else
						fft_state <= FFT_STALL;
					end if;
				when FFT_STALL =>
					if(fft_edone = '1') then
						fft_state <= FFT_UNLOAD;
					end if;
				when FFT_UNLOAD =>
					if(fft_dv = '1') then
						if(fft_xk_index(fft_xk_index'high) = '0') then
							fft_out_ram(to_integer(unsigned(fft_xk_index))) <= fft_xk_re & fft_xk_im;
						end if;
					else
						fft_start <= '0';
						master_state <= MAG;
						mag_state <= MAG_1;
						iteration := 0;
					end if;
				end case;
			when MAG =>
				case mag_state is
				when MAG_1 =>
					a := x"0000" & unsigned(fft_out_ram(to_integer(unsigned(fft_ram_pos)))(15 downto 8)) * 
						unsigned(fft_out_ram(to_integer(unsigned(fft_ram_pos)))(7 downto 0));
					mag_state <= MAG_2;
				when MAG_2 =>
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
					
					if(iteration = 15) then
						iteration := 0;
						vga_ram(to_integer(fft_ram_pos)) <= std_logic_vector(q(7 downto 0));
						if(fft_ram_pos = (fft_ram_pos'range => '1')) then
							master_state <= SAMPLE;
							fft_ram_pos <= (others => '0');
							mag_state <= MAG_1;
						else
							mag_state <= MAG_1;
							fft_ram_pos <= fft_ram_pos + 1;
						end if;
					else
						iteration := iteration + 1;
					end if;
				end case;
			end case;
		end if;
	end process;

	fft_instance : fft_burst_mode
	  PORT MAP (
	    clk => original_clk,
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
		elsif(rising_edge(vga_clk)) then
			if(x_pos > -1 and y_pos > -1 and x_pos < vga_ram'length) then
				if(vga_ram(x_pos) = std_logic_vector(to_unsigned(y_pos, vga_ram(0)'length))) then
					blue_in <= (others => '1');
				else
					blue_in <= (others => '0');
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
	
	dcm_instance : flow_3_dcm
	  port map(
	    CLK_IN1  => clk,
	    VGA_CLK  => vga_clk,
	    BASE_CLK => original_clk,
	    RESET    => rst);

end Behavioral;

