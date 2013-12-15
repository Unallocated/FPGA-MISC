library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fft_controller is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_in_clk : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           data_out_clk : out  STD_LOGIC;
           scale_in : in STD_LOGIC_VECTOR(7 downto 0);
           scale_we : in STD_LOGIC;
           start : in  STD_LOGIC;
           done : out STD_LOGIC);
end fft_controller;

architecture Behavioral of fft_controller is

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
	
	type state_t is (IDLE, WAIT_FOR_RFD, LOAD, STALL, UNLOAD);
	signal state : state_t := IDLE;
	
	signal last_start_value : std_logic := '0';
	signal start_buffer : std_logic := '0';
	
	constant max : unsigned(31 downto 0) := to_unsigned(1, 32);
	signal counter : unsigned(max'range) := (others => '0');
begin

	fft_ce <= '1';

	process(clk, rst)
	begin
		if(rst = '1') then
			counter <= (others => '0');
			fft_clk <= '0';
		elsif(rising_edge(clk)) then
			if(counter = max) then
				fft_clk <= '1';
				counter <= (others => '0');
			else
				fft_clk <= '0';
				counter <= counter + 1;
			end if;
		end if;
	end process;

	process(clk, rst)
	begin
		if(rst = '1') then
			done <= '1';
			fft_start <= '0';
			data_out_clk <= '0';
		elsif(rising_edge(clk)) then
			case state is 
				when IDLE =>
					fft_start <= '0';
					done <= '1';
					data_out_clk <= '0';
					if(start = '1' and last_start_value = '0') then
						done <= '0';
						fft_start <= '1';
						state <= WAIT_FOR_RFD;
					end if;
				when WAIT_FOR_RFD =>
					if(fft_rfd = '1') then
						state <= LOAD;
					end if;
				when LOAD =>
					if(fft_rfd = '1') then
						fft_xn_re <= data_in;
						if(fft_clk = '1') then
							data_in_clk <= '1';
						else
							data_in_clk <= '0';
						end if;
					else
						state <= STALL;
					end if;
				when STALL =>
					if(fft_dv = '1') then
						state <= UNLOAD;
						data_out <= fft_xk_re & fft_xk_im;
						
					end if;
				when UNLOAD =>
					if(fft_dv = '1') then
						data_out <= fft_xk_re & fft_xk_im;
						if(fft_clk = '0') then
							data_out_clk <= '1';
						else
							data_out_clk <= '0';
						end if;
					else
						state <= IDLE;
					end if;
			end case;
			
			last_start_value <= start;
		end if;
	end process;

	fft_instance : fft_burst_mode
	  PORT MAP (
	    clk => clk,
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

end Behavioral;
