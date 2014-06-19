library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fft_flow_3 is
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
end fft_flow_3;

architecture Behavioral of fft_flow_3 is
	constant clock_speed : unsigned(31 downto 0) := to_unsigned(100_000_000, 32);
	constant adc_clk_divider : unsigned(31 downto 0) := to_unsigned(32, 32);
	constant is_test : std_logic := '1';
	
	type master_state_t is (INIT, ADC, FFT, MAG);
	signal master_state : master_state_t := INIT;
	
	signal adc_fifo_wr_clk, adc_fifo_rd_clk, adc_fifo_wr_en, adc_fifo_rd_en, adc_fifo_full, adc_fifo_empty : std_logic := '0';
	signal adc_fifo_din, adc_fifo_dout : std_logic_vector(7 downto 0) := (others => '0');

	COMPONENT flow_3_adc_fifo
	  PORT (
	    rst    : IN  STD_LOGIC;
	    wr_clk : IN  STD_LOGIC;
	    rd_clk : IN  STD_LOGIC;
	    din    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
	    wr_en  : IN  STD_LOGIC;
	    rd_en  : IN  STD_LOGIC;
	    dout   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    full   : OUT STD_LOGIC;
	    empty  : OUT STD_LOGIC
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
	
	signal adc_sampler_en, adc_sampler_clk : std_logic := '0';
	
	COMPONENT adc_sampler
	PORT(
		clk : IN std_logic;
		en : IN std_logic;
		rst : IN std_logic;
		adc_in : IN std_logic_vector(7 downto 0);          
		adc_clk : OUT std_logic;
		data_out : OUT std_logic_vector(7 downto 0);
		clk_out : OUT std_logic
		);
	END COMPONENT;

begin

	adc_sampler_en <= '1';
	
	brain : process(original_clk, rst)
	begin
		if(rst = '1') then
			master_state <= INIT;
			
		elsif(rising_edge(original_clk)) then
			case master_state is 
				when INIT =>
					adc_fifo_wr_en <= '0';
					if(adc_fifo_empty = '1' and adc_fifo_full = '0') then
						adc_fifo_wr_en <= '1';
						master_state <= ADC;
					end if;
				when ADC =>
					
					if(adc_fifo_full = '1') then
						adc_fifo_wr_en <= '0';
						master_state <= FFT;
					end if;
				when FFT =>
					null;
				when MAG =>
					null;
			end case;
		end if;
	end process;	 

	adc_clk_gen_proc : process(original_clk, rst)
		constant max : unsigned(31 downto 0) := clock_speed / (adc_clk_divider * 2);
		variable counter : unsigned(max'range) := (others => '0');
	begin
		if(rst = '1') then
			counter := (others => '0');
			adc_sampler_clk <= '0';
		elsif(rising_edge(original_clk)) then
			if(is_test = '1') then
				adc_sampler_clk <= not adc_sampler_clk;
			else
				if(counter = max) then
					counter := (others => '0');
					adc_sampler_clk <= not adc_sampler_clk;
				else
					counter := counter + 1;
				end if;
			end if;
		end if;
	end process;
	
--	adc_fifo_rd_clk_gen_proc : process(original_clk, rst)
--		constant max : unsigned(31 downto 0) := clock_speed / (adc_clk_divider * 4);
--		variable counter : unsigned(max'range) := (others => '0');
--	begin
--		if(rst = '1') then
--			counter := (others => '0');
--		elsif(rising_edge(original_clk)) then
--			if(is_test = '1') then
--				adc_fifo_rd_clk <= not adc_fifo_rd_clk;
--			else
--				if(counter = max) then
--					adc_fifo_rd_clk <= not adc_fifo_rd_clk;
--					counter := (others => '0');
--				else
--					counter := counter + 1;
--				end if;
--			end if;
--		end if;
--	end process;

	adc_fifo_inst : flow_3_adc_fifo
	  PORT MAP (
	    rst    => rst,
	    wr_clk => adc_fifo_wr_clk,
	    rd_clk => adc_fifo_rd_clk,
	    din    => adc_fifo_din,
	    wr_en  => adc_fifo_wr_en,
	    rd_en  => adc_fifo_rd_en,
	    dout   => adc_fifo_dout,
	    full   => adc_fifo_full,
	    empty  => adc_fifo_empty
	  );
	  
	dcm_instance : flow_3_dcm
	  port map(
	    CLK_IN1  => clk,
	    VGA_CLK  => vga_clk,
	    BASE_CLK => original_clk,
	    RESET    => rst);
	    
	Inst_adc_sampler: adc_sampler PORT MAP(
		clk => adc_sampler_clk,
		en => adc_sampler_en,
		rst => rst,
		adc_in => adc_in,
		adc_clk => adc_clk,
		data_out => adc_fifo_din,
		clk_out => adc_fifo_wr_clk
	);

end Behavioral;

