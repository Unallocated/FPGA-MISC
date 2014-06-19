library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fft_flow_2 is
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
end fft_flow_2;

architecture Behavioral of fft_flow_2 is
	constant data_width : integer := 8;
	constant fft_width : integer := 8;

	signal fft_clk, fft_sclr, fft_start, fft_rfd, fft_busy, fft_edone, fft_done, fft_dv, fft_ce, fft_ovflo, fft_scale_we : std_logic := '0';
	signal fft_xn_re, fft_xn_im, fft_xk_re, fft_xk_im : std_logic_vector(data_width-1 downto 0) := (others => '0');
	signal fft_xn_index, fft_xk_index, fft_scale : std_logic_vector(fft_width-1 downto 0) := (others => '0');

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

	signal vga_clk, dds_clk, original_clk : std_logic := '0';

	component vga_clock_dcm
		port (
		  in_100MHz    : in  std_logic;
		  VGA_25MHz    : out std_logic;
		  original_clk : out std_logic;
		  dds_clk      : out std_logic;
		  RESET        : in  std_logic
		 );
	end component;
	
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
	
	signal adc_fifo_clk, adc_fifo_full, adc_fifo_empty, adc_fifo_wr_en, adc_fifo_rd_en : std_logic := '0';
	signal adc_fifo_data_in, adc_fifo_data_out : std_logic_vector(data_width-1 downto 0) := (others => '0');
	
	COMPONENT flow2_adc_fifo
	  PORT (
	    clk : IN STD_LOGIC;
	    rst : IN STD_LOGIC;
	    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    wr_en : IN STD_LOGIC;
	    rd_en : IN STD_LOGIC;
	    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    full : OUT STD_LOGIC;
	    empty : OUT STD_LOGIC
	  );
	END COMPONENT;
	
	signal fft_ram_address : std_logic_vector(fft_width-1 downto 0) := (others => '0');
	signal fft_ram_data_in, fft_ram_data_out : std_logic_vector((fft_width * 2) - 1 downto 0) := (others => '0');
	signal fft_ram_clk, fft_ram_we : std_logic := '0';
	
	COMPONENT flow2_fft_ram
	  PORT (
	    a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	    clk : IN STD_LOGIC;
	    we : IN STD_LOGIC;
	    spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	END COMPONENT;
	  
	type vga_ram_t is array(0 to (2 ** (fft_width/2)) - 1) of unsigned(data_width - 1 downto 0);
	signal vga_ram : vga_ram_t := (others => (others => '0'));
	
	type controller_states_t is ( INIT, ADC, FFT, MAG );
	signal controller_state : controller_states_t := ADC;
	
	type adc_states_t is (ADC_CLOCK_HIGH, ADC_CLOCK_LOW, ADC_FIFO_CLK_HIGH, ADC_FIFO_CLK_LOW);
	signal adc_state : adc_states_t := ADC_CLOCK_HIGH;
	
	type fft_states_t is (FFT_ENABLE, FFT_START_HIGH, FFT_LOAD, FFT_WAIT_FOR_DV, FFT_UNLOAD, FFT_DISABLE);
	signal fft_state : fft_states_t := FFT_ENABLE;
	
	type fft_clock_state_t is (FFT_CLOCK_LOW, FFT_CLOCK_HIGH);
	signal fft_clock_state : fft_clock_state_t := FFT_CLOCK_LOW;
	
	type mag_states_t is (MAG_GET_SAMPLE, MAG_START_CALC, MAG_WAIT_FOR_FINISH, MAG_STORE_RESULT);
	signal mag_state : mag_states_t := MAG_GET_SAMPLE;
	
	signal adc_sample_number : unsigned(adc_fifo_data_in'range) := (others => '0');
	
	signal stall : integer := 0;
begin

	controller_process : process(original_clk, rst)
	begin
		if(rst = '1') then
			vga_ram <= (others => (others => '0'));
			controller_state <= ADC;
			adc_state <= ADC_CLOCK_HIGH;
			fft_state <= FFT_ENABLE;
			mag_state <= MAG_GET_SAMPLE;
			adc_sample_number <= (others => '0');
			adc_clk <= '0';
			adc_fifo_clk <= '0';
			adc_fifo_data_in <= (others => '0');
			adc_fifo_wr_en <= '0';
			adc_fifo_rd_en <= '0';
			fft_start <= '0';
			fft_ce <= '0';
			fft_sclr <= '0';
		elsif(rising_edge(original_clk)) then
			case controller_state is 
				when INIT =>
					if(adc_fifo_empty = '1') then
						controller_state <= ADC;
					else
						adc_fifo_clk <= not adc_fifo_clk;
					end if;
				when ADC =>
					adc_fifo_wr_en <= '1';
					adc_fifo_rd_en <= '0';
					
					case adc_state is 
					when ADC_CLOCK_HIGH =>
						adc_clk <= '1';
						adc_state <= ADC_CLOCK_LOW;
					when ADC_CLOCK_LOW =>
						adc_clk <= '0';
						adc_fifo_data_in <= adc_in;
						adc_state <= ADC_FIFO_CLK_HIGH;
					when ADC_FIFO_CLK_HIGH =>
						adc_fifo_clk <= '1';
						adc_state <= ADC_FIFO_CLK_LOW;
					when ADC_FIFO_CLK_LOW =>
						adc_fifo_clk <= '0';
						adc_state <= ADC_CLOCK_HIGH;
						
						if(adc_sample_number = (adc_sample_number'range => '1')) then
							controller_state <= FFT;
							adc_sample_number <= (others => '0');
						else
							adc_sample_number <= adc_sample_number + 1;
						end if;
					end case;
					
					
				when FFT =>
					case fft_state is 
						when FFT_ENABLE =>
							if(fft_clk = '0') then
								fft_ce <= '1';
								fft_start <= '0';
								fft_sclr <= '0';
								fft_state <= FFT_START_HIGH;
								adc_fifo_rd_en <= '1';
								adc_fifo_wr_en <= '0';
								fft_ram_address <= (others => '0');
								fft_ram_we <= '1';
								fft_ram_clk <= '0';
								
								stall <= 2;
							end if;
						when FFT_START_HIGH =>
							if(stall /= 0) then
								--fft_sclr <= '1';
								stall <= stall - 1;
							else
								--fft_sclr <= '0';
								fft_start <= '1';
								
								if(fft_rfd = '1') then
									fft_state <= FFT_LOAD;
									fft_start <= '0';
								end if;
							end if;
						when FFT_LOAD =>
							if(adc_fifo_clk = '1') then
								fft_xn_re <= adc_fifo_data_out;
							end if;
							
							adc_fifo_clk <= fft_clk;
							
							if(fft_rfd = '0') then
								fft_state <= FFT_WAIT_FOR_DV;
							end if;
						when FFT_WAIT_FOR_DV =>
							if(fft_dv = '1') then
								fft_ram_address <= fft_xk_index;
								fft_ram_data_in <= fft_xk_re & fft_xk_im;
								fft_state <= FFT_UNLOAD;
							end if;
						when FFT_UNLOAD =>
							if(fft_dv = '1') then
								fft_ram_address <= fft_xk_index;
								fft_ram_data_in <= fft_xk_re & fft_xk_im;
							else
								fft_state <= FFT_DISABLE;
							end if;
							
							fft_ram_clk <= not fft_ram_clk;
						when FFT_DISABLE =>
							fft_ram_clk <= '0';
							fft_ram_we <= '0';
							fft_start <= '0';
							controller_state <= MAG;
							fft_state <= FFT_ENABLE;
					end case;	
				
				when MAG =>
					controller_state <= ADC;
			end case;
		end if;
	end process;

	fft_instance : fft_burst_mode
	  PORT MAP (
	    clk => fft_clk,
	    ce => fft_ce,
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

	dcm_instance : vga_clock_dcm
	  port map(
	    in_100MHz => clk,
	    VGA_25MHz => vga_clk,
	    original_clk => original_clk,
	    dds_clk => dds_clk,
	    RESET  => rst);
	    
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
	
	adc_fifo : flow2_adc_fifo
	  PORT MAP (
	    clk => adc_fifo_clk,
	    rst => rst,
	    din => adc_fifo_data_in,
	    wr_en => adc_fifo_wr_en,
	    rd_en => adc_fifo_rd_en,
	    dout => adc_fifo_data_out,
	    full => adc_fifo_full,
	    empty => adc_fifo_empty
	  );
	  
	fft_ram_instance : flow2_fft_ram
	  PORT MAP (
	    a => fft_ram_address,
	    d => fft_ram_data_in,
	    clk => fft_ram_clk,
	    we => fft_ram_we,
	    spo => fft_ram_data_out
	  );
	  
	  
	vga_controller_process : process(vga_clk, rst)
	begin
		if(rst = '1') then
			blue_in <= (others => '0');
		elsif(rising_edge(vga_clk)) then
			if(x_pos > -1 and y_pos > -1 and x_pos < vga_ram'length) then
				if(vga_ram(x_pos) = to_unsigned(y_pos, vga_ram(0)'length)) then
					blue_in <= (others => '1');
				else
					blue_in <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	
	fft_clock_proces : process(original_clk, rst)
		constant max : unsigned(0 downto 0) := to_unsigned(1, 1);
		variable counter : unsigned(max'range) := (others => '0');
	begin
		if(rst = '1') then
			counter := (others => '0');
		elsif(rising_edge(original_clk)) then
			if(counter = max) then
				counter := (others => '0');
				fft_clk <= '1';
			else
				counter := counter + 1;
				fft_clk <= '0';
			end if;
		end if;
	end process;
		

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
				fft_scale <= switches;
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

end Behavioral;

