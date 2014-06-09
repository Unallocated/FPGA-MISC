library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity master is
	Generic ( 
		clk_rate  : integer := 1_000;
		rst_value : std_logic := '1'
	);
	Port ( clk      : in  STD_LOGIC;
	       rst      : in  STD_LOGIC;
               adc_clk  : out  STD_LOGIC;
               adc_data : in  STD_LOGIC_VECTOR (7 downto 0));
end master;

architecture Behavioral of master is

	COMPONENT adc_fifo
	  PORT (
	    clk : IN STD_LOGIC;
	    rst : IN STD_LOGIC;
	    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    wr_en : IN STD_LOGIC;
	    rd_en : IN STD_LOGIC;
	    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    full : OUT STD_LOGIC;
	    wr_ack : OUT STD_LOGIC;
	    empty : OUT STD_LOGIC;
	    valid : OUT STD_LOGIC
	  );
	END COMPONENT;

	COMPONENT fft
	  PORT (
	    clk : IN STD_LOGIC;
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
	    xk_index : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xk_re : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xk_im : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;

	signal slow_clk : std_logic := '0';
	signal slow_clk_en : std_logic := '0';

	type adc_state_t is (WAIT_FOR_FIFO, CLK_HIGH, CLK_LOW, FIFO_CLK_HIGH, FIFO_CLK_LOW, WAIT_FOR_WR_ACK);
	signal adc_state : adc_state_t := WAIT_FOR_FIFO;

	signal fifo_status : std_logic := '0';

	type fft_state_t is (FFT_FIFO_CLK_HIGH, FFT_LOAD_SAMPLE, FFT_WAIT);
	signal fft_state : fft_state_t := FFT_FIFO_CLK_HIGH;

	signal fft_scale_sch, fft_in_re, fft_in_im, fft_out_re, fft_out_im : std_logic_vector(7 downto 0);
	signal fft_in_idx, fft_out_idx : std_logic_vector(7 downto 0);
	signal fft_scale_sch_we, fft_clk, fft_start, fft_rfd, fft_busy, fft_done, fft_edone, fft_div : std_logic := '0';
	
	signal adc_fifo_rd_en, adc_fifo_wr_en, adc_fifo_ready : std_logic := '0';
	signal adc_fifo_data_in, adc_fifo_data_out : std_logic_vector(adc_data'range) := (others => '0');
	signal adc_fifo_clk, adc_fifo_empty, adc_fifo_full, adc_fifo_wr_ack, adc_fifo_valid : std_logic := '0';
	signal adc_last_fifo_full, adc_last_fifo_empty : std_logic := '0';
begin

	adc_fifo_inst : adc_fifo
	  PORT MAP (
	    clk => adc_fifo_clk,
	    rst => rst,
	    din => adc_fifo_data_in,
	    wr_en => adc_fifo_wr_en,
	    rd_en => adc_fifo_rd_en,
	    dout => adc_fifo_data_out,
	    full => adc_fifo_full,
	    wr_ack => adc_fifo_wr_ack,
	    empty => adc_fifo_empty,
	    valid => adc_fifo_valid
	  );

	fft_inst  : fft
	  PORT MAP (
	    clk => fft_clk,
	    start => '1',
	    xn_re => fft_in_re,
	    xn_im => fft_in_im,
	    fwd_inv => '0',
	    fwd_inv_we => '0',
	    scale_sch => fft_scale_sch,
	    scale_sch_we => fft_scale_sch_we,
	    rfd => fft_rfd,
	    xn_index => fft_in_idx,
	    busy => fft_busy,
	    edone => fft_edone,
	    done => fft_done,
	    dv => fft_div,
	    xk_index => fft_out_idx,
	    xk_re => fft_out_re,
	    xk_im => fft_out_im
	  );

	slow_clk <= clk and slow_clk_en;
	adc_fifo_wr_en <= '0' when fifo_status = '1' else '1';
	adc_fifo_rd_en <= '0' when fifo_status = '0' else '1';
	
	fifo_status_proc : process(adc_fifo_full, adc_fifo_empty, rst)
	begin
		if(rst = '1') then
			fifo_status <= '0';
		elsif(adc_fifo_ready = '1' and adc_last_fifo_full = '0' and adc_fifo_full = '1') then
			fifo_status <= '1';
		elsif(adc_fifo_ready = '1' and adc_last_fifo_empty = '0' and adc_fifo_empty = '1') then
			fifo_status <= '0';
		end if;
	end process;

	fifo_proc : process(slow_clk, rst)
	begin
		if(rst = '1') then
			adc_clk <= '0';
			adc_state <= CLK_HIGH;
		elsif(rising_edge(slow_clk)) then
			if(fifo_status = '0') then
				case adc_state is
					when WAIT_FOR_FIFO =>
						if(adc_fifo_full = '0') then
							adc_fifo_ready <= '1';
							adc_state <= CLK_HIGH;
							adc_fifo_clk <= '0';
						else
							adc_fifo_clk <= not adc_fifo_clk;
						end if;
					when CLK_HIGH =>
						adc_clk <= '1';
						adc_state <= CLK_LOW;
					when CLK_LOW =>
						adc_clk <= '0';
						adc_fifo_data_in <= adc_data;
						adc_state <= FIFO_CLK_HIGH;
					when FIFO_CLK_HIGH =>
						adc_fifo_clk <= '1';
						adc_state <= FIFO_CLK_LOW;
					when FIFO_CLK_LOW =>
						adc_fifo_clk <= '0';
						adc_state <= WAIT_FOR_WR_ACK;
					when WAIT_FOR_WR_ACK =>
						if(adc_fifo_wr_ack = '1') then
							adc_state <= CLK_HIGH;
							adc_fifo_clk <= '0';
						else
							adc_fifo_clk <= not adc_fifo_clk;
						end if;
				end case;
			else
				case fft_state is
					when FFT_FIFO_CLK_HIGH =>
						adc_fifo_clk <= '1';
						fft_state <= FFT_LOAD_SAMPLE;
						fft_clk <= '0';
					when FFT_LOAD_SAMPLE =>
						fft_in_re <= adc_fifo_data_out;
						adc_fifo_clk <= '0';
						
						fft_state <= FFT_FIFO_CLK_HIGH;
						fft_clk <= '1';
					when FFT_WAIT =>
						null;
				end case;
			end if;
		end if;
	end process;

	clk_divider_proc : process(clk, rst)
		variable clk_counter : unsigned(31 downto 0) := (others => '0');
		constant max : unsigned(clk_counter'range) := to_unsigned(clk_rate / 100, clk_counter'length);
	begin
		if(rst = rst_value) then
			clk_counter := max;
			slow_clk_en <= '0';
		elsif(rising_edge(clk)) then
			slow_clk_en <= '0';
			if(clk_counter = 0) then
				slow_clk_en <= '1';
				clk_counter := max;
			else
				clk_counter := clk_counter - 1;
			end if;
		end if;
	end process;
end Behavioral;

