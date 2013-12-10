library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use WORK.uas.ALL;

entity fft_with_ram is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
--           adc_clk : out  STD_LOGIC;
--           adc_in : in  STD_LOGIC_VECTOR (7 downto 0);
           hs : out  STD_LOGIC;
           vs : out  STD_LOGIC;
           blue : out  STD_LOGIC_VECTOR (1 downto 0);
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0));
end fft_with_ram;

architecture Behavioral of fft_with_ram is

	signal base_clk, base_clk180 : std_logic;
	signal vga_clk, vga_clk180 : std_logic;
	signal adc_clk180, adc_clk180_ce : std_logic;
	
	component dcm
		port(
		  BASE_INPUT     : in  std_logic;
		  BASE_OUT       : out std_logic;
		  BASE_OUT_180   : out std_logic;
		  VGA_OUT        : out std_logic;
		  VGA_OUT_180    : out std_logic;
		  ADC_OUT        : out std_logic;
		  ADC_OUT_180    : out std_logic;
		  ADC_OUT_180_CE : in  std_logic;
		  RESET          : in  std_logic
		 );
	end component;
	
	signal fft_done, fft_en, fft_ce, fft_rfd, fft_start, fft_busy, fft_sclr, fft_edone, fft_dv : std_logic := '0';
	signal fft_xk_index, fft_xn_index : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_xk_re, fft_xn_re : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_xk_im, fft_xn_im : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_blk_exp : std_logic_vector(4 downto 0) := (others => '0');
	
	COMPONENT fft_core
	  PORT (
		 clk : IN STD_LOGIC;
		 ce : IN STD_LOGIC;
		 sclr : IN STD_LOGIC;
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
		 xk_index : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 xk_re : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 xk_im : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 blk_exp : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal adc_ram_in_clk, adc_ram_out_clk : std_logic := '0';
	signal adc_ram_in_addr, adc_ram_out_addr : std_logic_vector(fft_xk_index'range) := (others => '0');
	signal adc_ram_in_data, adc_ram_out_data : std_logic_vector(fft_xk_re'range) := (others => '0');
	signal adc_ram_in_we : std_logic_vector(0 downto 0) := "0";
	
	COMPONENT adc_ram
	  PORT (
	    clka : IN STD_LOGIC;
	    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    clkb : IN STD_LOGIC;
	    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal fft_ram_in_clk, fft_ram_out_clk : std_logic := '0';
	signal fft_ram_in_addr, fft_ram_out_addr : std_logic_vector(fft_xk_index'range) := (others => '0');
	signal fft_ram_in_we : std_logic_vector(0 downto 0) := "0";
	signal fft_ram_in_en, fft_ram_out_en : std_logic := '0';
	signal fft_ram_in_data, fft_ram_out_data : std_logic_vector((fft_xk_index'length * 2)-1 downto 0) := (others => '0');
	
	COMPONENT fft_ram_simple
	  PORT (
	    clka : IN STD_LOGIC;
	    ena : IN STD_LOGIC;
	    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	    clkb : IN STD_LOGIC;
	    enb : IN STD_LOGIC;
	    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal mult_a, mult_b : std_logic_vector(7 downto 0) := (others => '0');
	signal mult_p : std_logic_vector(15 downto 0) := (others => '0');
	
	COMPONENT multiplier
	  PORT (
	    clk : IN STD_LOGIC;
	    a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    p : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal sqrt_in : std_logic_vector((fft_xk_re'length * 2) - 1 downto 0) := (others => '0');
	signal sqrt_out : std_logic_vector(fft_xk_re'high + 1 downto 0) := (others => '0');
	
	COMPONENT sqrt
	  PORT (
	    x_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	    x_out : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	  );
	END COMPONENT;
	
	
	signal vga_ram_in_clk, vga_ram_out_clk : std_logic := '0';
	signal vga_ram_in_addr, vga_ram_out_addr : std_logic_vector(fft_xk_index'range) := (others => '0');
	signal vga_ram_in_data, vga_ram_out_data : std_logic_vector(fft_xk_re'range) := (others => '0');
	signal vga_ram_in_we : std_logic_vector(0 downto 0) := "0";
	signal vga_ram_in_en : std_logic := '0';
	
	COMPONENT vga_ram
	  PORT (
	    clka : IN STD_LOGIC;
	    ena : IN STD_LOGIC;
	    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    clkb : IN STD_LOGIC;
	    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal blue_in : std_logic_vector(1 downto 0) := (others => '0');
	signal red_in, green_in : std_logic_vector(2 downto 0) := (others => '0');
	signal x_pos, y_pos : integer := 0;
	
	COMPONENT vga_configurable
		Generic ( 
				  config      : vga_timing := vga_25mhz_640x480; -- Allow the user to specify custom VGA timings.  Default to 25MHz at 640x480
				  red_width   : positive    := 3;                 -- Let the user change the number of red color bits
				  green_width : positive    := 3;                 -- Let the user change the number of green color bits
				  blue_width  : positive    := 2                  -- Let the user change the number of blue color bits
				);
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
			x_pos : OUT integer range -1 to vga_25mhz_640x480.horizontal_video - 1;
			y_pos : OUT integer range -1 to vga_25mhz_640x480.vertical_video - 1
			);
	END COMPONENT;
	
	signal dds_out : std_logic_vector(7 downto 0) := (others => '0');
	signal dds_data : std_logic_vector(7 downto 0) := (others => '1');
	signal dds_we, dds_we_n, dds_clk : std_logic := '0';
	
	COMPONENT dds
	  PORT (
	    clk : IN STD_LOGIC;
	    we : IN STD_LOGIC;
	    data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal adc_en : std_logic;
	
	type master_state_t is (INIT, SAMPLE, FFT, MAG);
	signal master_state : master_state_t := INIT;
	
	type init_state_t is (INIT_CLEAR, INIT_STALL);
	signal init_state : init_state_t := INIT_CLEAR;
	
	type fft_state_t is (FFT_WAIT_FOR_RFD, FFT_LOAD, FFT_WAIT_FOR_DV, FFT_UNLOAD);
	signal fft_state : fft_state_t := FFT_WAIT_FOR_RFD;
	
	type adc_state_t is (ADC_SAMPLE, ADC_WAIT);
	signal adc_state : adc_state_t := ADC_SAMPLE;
	
	type mag_state_t is (MAG_MULT, MAG_CORDIC_START, MAG_CORDIC_STOP);
	signal mag_state : mag_state_t := MAG_MULT;
	
	signal mag_pos : unsigned(fft_xk_index'range) := (others => '0');
begin

	adc_ram_in_data <= dds_out;
	fft_xn_re <= adc_ram_out_data;
	adc_ram_out_addr <= fft_xn_index;
	fft_ram_in_addr <= fft_xk_index;
	fft_ram_in_data <= fft_xk_re & fft_xk_im;
	fft_ram_out_addr <= std_logic_vector(mag_pos);
	vga_ram_in_data <= std_logic_vector(unsigned(sqrt_out(7 downto 0)) + 128);
	vga_ram_in_addr <= std_logic_vector(unsigned(mag_pos));
	--adc_clk <= not adc_clk180;
	vga_ram_out_addr <= std_logic_vector(to_unsigned(x_pos, 8) + 1);
	
	process(adc_clk180)
		variable counter : integer range 0 to 255 := 0;
	begin
		if(rising_edge(adc_clk180)) then
			if(adc_ram_in_we = "0") then
				counter := 0;
			else
				if(counter = 255) then
					counter := 0;
				else
					counter := counter + 1;
				end if;
			end if;
			
			adc_ram_in_addr <= std_logic_vector(to_unsigned(counter, adc_ram_in_addr'length));
		end if;
	end process;
	
	process(base_clk, rst)
		constant max : unsigned(31 downto 0) := to_unsigned(1, 32);
		variable counter : unsigned(max'range) := (others => '0');
		variable counter2 : unsigned(max'range) := (others => '0');
	begin
		if(rst = '1') then
			counter := (others => '0');
			counter2 := (others => '0');
			master_state <= INIT;
			init_state <= INIT_CLEAR;
			fft_state <= FFT_WAIT_FOR_RFD;
			adc_clk180_ce <= '1';
			adc_ram_in_we <= "0";
			
			--adc_fifo_wr_en <= '0';
			mag_pos <= (others => '0');
		elsif(rising_edge(base_clk)) then
			if(counter2 = 100000000) then
				counter2 := (others => '0');
				dds_data <= std_logic_vector(unsigned(dds_data) + 1);
				dds_we <= '1';
			else
				dds_we <= '0';
				counter2 := counter2 + 1;
			end if;
			
			
			if(counter = max) then
				counter := (others => '0');
				dds_clk <= '1';
			else
				counter := counter + 1;
				dds_clk <= '0';
			end if;
		
			case master_state is
			when INIT =>
				master_state <= SAMPLE;
				adc_ram_in_we <= "1";
				adc_clk180_ce <= '1';
				mag_pos <= (others => '0');
			when SAMPLE =>
				case adc_state is
				when ADC_SAMPLE =>
					if(adc_ram_in_addr = (adc_ram_in_addr'range => '1')) then
						adc_state <= ADC_WAIT;
					end if;
				when ADC_WAIT =>
					master_state <= FFT;
					adc_ram_in_we <= "0";
					adc_state <= ADC_SAMPLE;
					fft_state <= FFT_WAIT_FOR_RFD;
				end case;
			when FFT =>
				case fft_state is
				when FFT_WAIT_FOR_RFD =>
					fft_ce <= '1';
					fft_start <= '1';
					
					if(fft_rfd = '1') then
						fft_state <= FFT_LOAD;
						
					end if;
				when FFT_LOAD =>
					
					if(fft_rfd = '0') then
						fft_state <= FFT_WAIT_FOR_DV;
					end if;
				when FFT_WAIT_FOR_DV =>
					
					if(fft_edone = '1') then
						fft_start <= '0';
					end if;
					
					if(fft_dv = '1') then
						fft_state <= FFT_UNLOAD;
						fft_ram_in_we <= "1";
						fft_ram_in_en <= '1';
					end if;
				when FFT_UNLOAD => 
					if(fft_dv = '0') then
						fft_ram_in_we <= "0";
						fft_ram_in_en <= '0';
						fft_state <= FFT_WAIT_FOR_RFD;
						master_state <= MAG;
						mag_pos <= (mag_pos'range => '0');
						fft_ram_out_en <= '1';
						vga_ram_in_we <= "1";
						vga_ram_in_en <= '1';
					end if;
				end case;
			when MAG =>
--				master_state <= INIT;
				case mag_state is 
					when MAG_MULT =>
						mult_a <= fft_ram_out_data(7 downto 0);
						mult_b <= fft_ram_out_data(15 downto 8);
						
						mag_state <= MAG_CORDIC_START;
					when MAG_CORDIC_START =>
						sqrt_in <= mult_p;
						mag_state <= MAG_CORDIC_STOP;
					when MAG_CORDIC_STOP =>
						if(mag_pos = (mag_pos'range => '1')) then
							master_state <= INIT;
							mag_pos <= (mag_pos'range => '0');
							fft_ram_out_en <= '0';
							vga_ram_in_we <= "0";
							vga_ram_in_en <= '0';
						else
							mag_pos <= mag_pos + 1;
						end if;
						
						mag_state <= MAG_MULT;
				end case;
			end case;
		end if;
	end process;
	
	vga_controller : process(vga_clk, rst)
	begin
		if(rst = '1') then
			blue_in <= (others => '0');
		elsif(rising_edge(vga_clk)) then
			blue_in <= (others => '0');
			if(x_pos > -1 and y_pos > -1 and x_pos < (2 ** fft_xk_index'length) and y_pos < 256) then
				--if(vga_ram(x_pos) <= std_logic_vector(to_unsigned(y_pos, vga_ram(0)'length))) then
				if(unsigned(vga_ram_out_data) <= to_unsigned(y_pos, fft_xk_re'length)) then
					blue_in <= (others => '1');
				end if;
			end if;
		end if;
	end process;
	

	adc_ram_inst : adc_ram
	  PORT MAP (
	    clka => adc_clk180,
	    wea => adc_ram_in_we,
	    addra => adc_ram_in_addr,
	    dina => adc_ram_in_data,
	    clkb => base_clk180,
	    addrb => adc_ram_out_addr,
	    doutb => adc_ram_out_data
	  );

	dcm_inst : dcm
	  port map(
	    BASE_INPUT     => clk,
		 BASE_OUT       => base_clk,
		 BASE_OUT_180   => base_clk180,
		 VGA_OUT        => vga_clk,
		 VGA_OUT_180    => vga_clk180,
		 ADC_OUT        => open,
		 ADC_OUT_180    => adc_clk180,
		 ADC_OUT_180_CE => adc_clk180_ce,
		 RESET          => rst);

	fft_core_inst : fft_core
	  PORT MAP (
		 clk => base_clk,
		 ce => fft_ce,
		 sclr => fft_sclr,
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
		 xk_index => fft_xk_index,
		 xk_re => fft_xk_re,
		 xk_im => fft_xk_im,
		 blk_exp => fft_blk_exp
	  );
	  
	fft_ram_inst : fft_ram_simple
	  PORT MAP (
	    clka => base_clk180,
	    ena => fft_ram_in_en,
	    wea => "1",
	    addra => fft_ram_in_addr,
	    dina => fft_ram_in_data,
	    clkb => base_clk180,
	    enb => fft_ram_out_en,
	    addrb => fft_ram_out_addr,
	    doutb => fft_ram_out_data
	  );
	  
	  multiplier_inst : multiplier
	  PORT MAP (
	    clk => base_clk,
	    a => mult_a,
	    b => mult_b,
	    p => mult_p
	  );
	  
	sqrt_inst : sqrt
  	PORT MAP (
	    x_in => sqrt_in,
	    x_out => sqrt_out
	  );
	  
	vga_ram_inst : vga_ram
	  PORT MAP (
	    clka => base_clk180,
	    ena => vga_ram_in_en,
	    wea => vga_ram_in_we,
	    addra => vga_ram_in_addr,
	    dina => vga_ram_in_data,
	    clkb => vga_clk,
	    addrb => vga_ram_out_addr,
	    doutb => vga_ram_out_data
	  );
	  
	  
	vga_instance : vga_configurable 
		GENERIC MAP(
			config => vga_25mhz_640x480
		)
		PORT MAP(
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
	
	
	dds_inst : dds
	  PORT MAP (
	    clk => dds_clk,
	    we => dds_we,
	    data => dds_data,
	    sine => dds_out
	  );
end Behavioral;

