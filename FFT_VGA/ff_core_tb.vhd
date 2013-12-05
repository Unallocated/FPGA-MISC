-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fft_core_tb IS
END fft_core_tb;

ARCHITECTURE behavior OF fft_core_tb IS
	type lut_t is array (0 to 255) of integer range 0 to 255;
	constant lut : lut_t := (127, 130, 133, 136, 139, 142, 145, 148, 151, 154,
		                     157, 160, 163, 166, 169, 172, 175, 178, 181, 184,
		                     186, 189, 192, 194, 197, 200, 202, 205, 207, 209,
		                     212, 214, 216, 218, 221, 223, 225, 227, 229, 230,
		                     232, 234, 235, 237, 239, 240, 241, 243, 244, 245,
		                     246, 247, 248, 249, 250, 250, 251, 252, 252, 253,
		                     253, 253, 253, 253, 254, 253, 253, 253, 253, 253,
		                     252, 252, 251, 250, 250, 249, 248, 247, 246, 245,
		                     244, 243, 241, 240, 239, 237, 235, 234, 232, 230,
		                     229, 227, 225, 223, 221, 218, 216, 214, 212, 209,
		                     207, 205, 202, 200, 197, 194, 192, 189, 186, 184,
		                     181, 178, 175, 172, 169, 166, 163, 160, 157, 154,
		                     151, 148, 145, 142, 139, 136, 133, 130, 127, 123,
		                     120, 117, 114, 111, 108, 105, 102, 99, 96, 93, 90,
		                     87, 84, 81, 78, 75, 72, 69, 67, 64, 61, 59, 56, 53, 51,
		                     48, 46, 44, 41, 39, 37, 35, 32, 30, 28, 26, 24, 23, 21,
		                     19, 18, 16, 14, 13, 12, 10, 9, 8, 7, 6, 5, 4, 3, 3, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 3, 4, 5, 6, 7, 8,
		                     9, 10, 12, 13, 14, 16, 18, 19, 21, 23, 24, 26, 28, 30,
		                     32, 35, 37, 39, 41, 44, 46, 48, 51, 53, 56, 59, 61, 64,
		                     67, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105,
		                     108, 111, 114, 117, 120, 123);
	signal lut_pos      : integer range 0 to 255 := 0;
	signal last_adc_clk : std_logic              := '0';

	signal fft_done, fft_en, fft_ce, fft_rfd, fft_start, fft_busy, fft_sclr, fft_edone, fft_dv : std_logic                    := '0';
	signal fft_xk_index, fft_xn_index                                                          : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_xk_re, fft_xn_re                                                                : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_xk_im, fft_xn_im                                                                : std_logic_vector(7 downto 0) := (others => '0');
	signal fft_blk_exp                                                                         : std_logic_vector(4 downto 0) := (others => '0');

	COMPONENT fft_core
		PORT(
			clk        : IN  STD_LOGIC;
			ce         : IN  STD_LOGIC;
			sclr       : IN  STD_LOGIC;
			start      : IN  STD_LOGIC;
			xn_re      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
			xn_im      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
			fwd_inv    : IN  STD_LOGIC;
			fwd_inv_we : IN  STD_LOGIC;
			rfd        : OUT STD_LOGIC;
			xn_index   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			busy       : OUT STD_LOGIC;
			edone      : OUT STD_LOGIC;
			done       : OUT STD_LOGIC;
			dv         : OUT STD_LOGIC;
			xk_index   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			xk_re      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			xk_im      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			blk_exp    : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
		);
	END COMPONENT;
	
	signal clk, adc_clk : std_logic := '0';
	constant clk_period : time := 1 ns;

BEGIN
	process(clk)
	begin
		if (rising_edge(clk)) then
--			if (adc_clk = '1' and last_adc_clk = '0') then
				fft_xn_re <= std_logic_vector(to_unsigned(lut(lut_pos), 8));
--			end if;
--			last_adc_clk <= adc_clk;
			if (lut_pos = 255) then
				lut_pos <= 0;
			else
				lut_pos <= lut_pos + 1;
			end if;
		end if;
	end process;
	
	clk_process :process
	   begin
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
	   end process;

	uut : fft_core
		PORT MAP(
			clk        => clk,
			ce         => fft_ce,
			sclr       => fft_sclr,
			start      => fft_start,
			xn_re      => fft_xn_re,
			xn_im      => (fft_xn_im'range => '0'),
			fwd_inv    => '1',
			fwd_inv_we => '1',
			rfd        => fft_rfd,
			xn_index   => fft_xn_index,
			busy       => fft_busy,
			edone      => fft_edone,
			done       => fft_done,
			dv         => fft_dv,
			xk_index   => fft_xk_index,
			xk_re      => fft_xk_re,
			xk_im      => fft_xk_im,
			blk_exp    => fft_blk_exp
		);

	--  Test Bench Statements
	tb : PROCESS
	BEGIN
		wait for 100 ns;                -- wait until global set/reset completes
		fft_ce <= '1';
		fft_sclr <= '0';
		wait for 100 ns;
		fft_start <= '1';
		wait until fft_done = '1';
		fft_start <= '0';
		wait until fft_dv = '0';
		fft_sclr <= '1';
		-- Add user defined stimulus here

	END PROCESS tb;
--  End Test Bench 

END;
