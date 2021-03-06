library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fft is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           adc_clk : out  STD_LOGIC;
           adc_data : in  STD_LOGIC_VECTOR (7 downto 0);
           hs : out  STD_LOGIC;
           vs : out  STD_LOGIC;
           blue : out  STD_LOGIC_VECTOR (0 downto 0);
           red : out  STD_LOGIC_VECTOR (0 downto 0);
           green : out  STD_LOGIC_VECTOR (0 downto 0));
end fft;

architecture Behavioral of fft is

	signal base_clk, base_clk180 : std_logic;
	signal vga_clk, vga_clk180 : std_logic;
	signal adc_clk180, adc_clk_ce, adc_clk180_ce : std_logic;
	
	component dcm
		port(
		  BASE_INPUT     : in  std_logic;
		  BASE_OUT       : out std_logic;
		  BASE_OUT_180   : out std_logic;
		  VGA_OUT        : out std_logic;
		  VGA_OUT_180    : out std_logic;
		  ADC_OUT        : out std_logic;
		  ADC_OUT_CE     : in  std_logic;
		  ADC_OUT_180    : out std_logic;
		  ADC_OUT_180_CE : in  std_logic;
		  RESET          : in  std_logic
		 );
	end component;
	
	signal adc_fifo_rst : std_logic := '0';
	signal adc_fifo_wr_ack : std_logic := '0';
	signal adc_fifo_rd_en, adc_fifo_wr_en : std_logic := '0';
	signal adc_fifo_din, adc_fifo_dout : std_logic_vector(7 downto 0) := (others => '0');
	signal adc_fifo_full, adc_fifo_empty : std_logic := '0';
	signal adc_fifo_almost_full, adc_fifo_almost_empty : std_logic := '0';
	signal adc_fifo_overflow, adc_fifo_underflow : std_logic := '0';
	signal adc_fifo_rd_en_extend : std_logic := '0';
	signal adc_fifo_wr_data_count : std_logic_vector(8 downto 0) := (others => '0');
	
	COMPONENT adc_fifo
	  PORT (
		 rst : IN STD_LOGIC;
		 wr_clk : IN STD_LOGIC;
		 rd_clk : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 wr_en : IN STD_LOGIC;
		 rd_en : IN STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 full : OUT STD_LOGIC;
		 almost_full : OUT STD_LOGIC;
		 empty : OUT STD_LOGIC;
		 almost_empty : OUT STD_LOGIC;
		 wr_data_count : OUT STD_LOGIC_VECTOR(8 downto 0);
		 underflow : out std_logic;
		 overflow: out std_logic;
		 wr_ack : out std_logic
	  );
	END COMPONENT;
	
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
	
	signal fft_ram_in_clk, fft_ram_out_clk : std_logic := '0';
	signal fft_ram_in_addr, fft_ram_out_addr : std_logic_vector(fft_xk_index'range) := (others => '0');
	signal fft_ram_in_we, fft_ram_out_we : std_logic := '0';
	signal fft_ram_in_en, fft_ram_out_en : std_logic := '0';
	signal fft_ram_in_data, fft_ram_out_data : std_logic_vector((fft_xk_index'length * 2)-1 downto 0) := (others => '0');
	
	COMPONENT fft_ram
	  PORT (
		 clka : IN STD_LOGIC;
	     ena : IN STD_LOGIC;
	     wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	     addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	     dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	     douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	     clkb : IN STD_LOGIC;
	     enb : IN STD_LOGIC;
	     web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	     addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	     dinb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	     doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
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
	
	signal adc_en : std_logic;
	
	type master_state_t is (INIT, SAMPLE, FFT, MAG);
	signal master_state : master_state_t := INIT;
	
	type init_state_t is (INIT_CLEAR, INIT_STALL);
	signal init_state : init_state_t := INIT_CLEAR;
	
	type fft_state_t is (FFT_WAIT_FOR_RFD, FFT_LOAD, FFT_WAIT_FOR_DV, FFT_UNLOAD);
	signal fft_state : fft_state_t := FFT_WAIT_FOR_RFD;
	
	type adc_state_t is (ADC_SAMPLE, ADC_WAIT);
	signal adc_state : adc_state_t := ADC_SAMPLE;
begin

	adc_fifo_din <= adc_data;
	fft_xn_re <= adc_fifo_dout;
	fft_ram_in_addr <= fft_xk_index;
	fft_ram_in_data <= fft_xk_re & fft_xk_im;
	
	process(base_clk, rst)
	begin
		if(rst = '1') then
			adc_fifo_rst <= '0';
			master_state <= INIT;
			init_state <= INIT_CLEAR;
			fft_state <= FFT_WAIT_FOR_RFD;
			adc_fifo_rd_en_extend <= '0';
			adc_clk180_ce <= '1';
			adc_clk_ce <= '1';
			--adc_fifo_wr_en <= '0';
		elsif(rising_edge(base_clk)) then
			case master_state is
			when INIT =>
				case init_state is
				when INIT_CLEAR =>
					adc_fifo_rst <= '1';
					adc_clk180_ce <= '1';
					adc_clk_ce <= '1';
					init_state <= INIT_STALL;
				when INIT_STALL =>
					adc_fifo_rst <= '0';
					if(adc_fifo_full = '0' and adc_fifo_empty = '1' and adc_fifo_overflow = '0') then
						master_state <= SAMPLE;
						adc_state <= ADC_SAMPLE;
						adc_fifo_wr_en <= '1';
					end if;
				end case;
			when SAMPLE =>
				case adc_state is
				when ADC_SAMPLE =>
					--if(adc_fifo_almost_full = '1') then
					if(adc_fifo_wr_data_count = std_logic_vector(to_unsigned(220, 9))) then
						
						adc_fifo_wr_en <= '0';
					--elsif(adc_fifo_wr_data_count = std_logic_vector(to_unsigned(255, 9))) then
					end if;
					
					if(adc_fifo_wr_ack = '0') then
						adc_clk180_ce <= '1';
						
						adc_state <= ADC_WAIT;
					end if;
				when ADC_WAIT =>
					master_state <= FFT;
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
						adc_fifo_rd_en <= '1';
						
					end if;
				when FFT_LOAD =>
					
					if(fft_rfd = '0') then
						fft_state <= FFT_WAIT_FOR_DV;
					end if;
				when FFT_WAIT_FOR_DV =>
					adc_fifo_rd_en <= '0';
					
					if(fft_edone = '1' or fft_done = '1') then
						fft_start <= '0';
					end if;
					
					if(fft_dv = '1') then
						fft_state <= FFT_UNLOAD;
						adc_fifo_rst <= '0';
						fft_ram_in_we <= '1';
						fft_ram_in_en <= '1';
					end if;
				when FFT_UNLOAD => 
					if(fft_dv = '0') then
						fft_ram_in_we <= '0';
						fft_ram_in_en <= '0';
						fft_state <= FFT_WAIT_FOR_RFD;
						master_state <= MAG;
					end if;
				end case;
			when MAG =>
				master_state <= INIT;
			end case;
		end if;
	end process;
	
	adc_fifo_inst : adc_fifo
	  PORT MAP (
		 rst => adc_fifo_rst,
		 wr_clk => adc_clk180,
		 rd_clk => base_clk180,
		 din => adc_data,
		 wr_en => '1',
		 rd_en => adc_fifo_rd_en,
		 dout => adc_fifo_dout,
		 full => adc_fifo_full,
		 almost_full => adc_fifo_almost_full,
		 empty => adc_fifo_empty,
		 wr_data_count => adc_fifo_wr_data_count,
		 almost_empty => adc_fifo_almost_empty,
		 underflow => adc_fifo_underflow,
		 overflow => adc_fifo_overflow,
		 wr_ack => adc_fifo_wr_ack
	  );

	dcm_inst : dcm
	  port map(
	    BASE_INPUT     => clk,
		 BASE_OUT       => base_clk,
		 BASE_OUT_180   => base_clk180,
		 VGA_OUT        => vga_clk,
		 VGA_OUT_180    => vga_clk180,
		 ADC_OUT        => adc_clk,
		 ADC_OUT_CE     => adc_clk_ce,
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
	  
	fft_ram_inst : fft_ram
	  PORT MAP (
	    clka => fft_ram_in_clk,
	    ena => fft_ram_in_en,
	    wea => "1",
	    addra => fft_ram_in_addr,
	    dina => fft_ram_in_data,
	    douta => open,
	    clkb => fft_ram_out_clk,
	    enb => fft_ram_out_en,
	    web => "0",
	    addrb => fft_ram_out_addr,
	    dinb => (fft_ram_in_data'range => '0'),
	    doutb => fft_ram_out_data
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
	  
end Behavioral;

