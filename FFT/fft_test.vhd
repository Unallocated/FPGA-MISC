-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
use ieee.std_logic_textio.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 
	constant numberOfBits : integer := 11;
	COMPONENT fft
	  PORT (
	    clk : IN STD_LOGIC;
	    start : IN STD_LOGIC;
	    xn_re : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xn_im : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    fwd_inv : IN STD_LOGIC;
	    fwd_inv_we : IN STD_LOGIC;
	    rfd : OUT STD_LOGIC;
	    xn_index : OUT STD_LOGIC_VECTOR(numberOfBits-1 DOWNTO 0);
	    busy : OUT STD_LOGIC;
	    edone : OUT STD_LOGIC;
	    done : OUT STD_LOGIC;
	    dv : OUT STD_LOGIC;
	    xk_index : OUT STD_LOGIC_VECTOR(numberOfBits-1 DOWNTO 0);
	    xk_re : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xk_im : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;

	COMPONENT dds
	PORT (
		clk : IN STD_LOGIC;
		we : IN STD_LOGIC;
		data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		rdy : OUT STD_LOGIC;
		rfd : OUT STD_LOGIC;
		sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	END COMPONENT;


	signal clk, start, fwd_inv, fwd_inv_we, scale_sch_we, rfd, busy, edone, done, dv : std_logic := '0';
	signal xn_re, xn_im, scale_sch, xk_re, xk_im : std_logic_vector(7 downto 0) := (others => '0');
	signal xk_index, xn_index : std_logic_vector(numberOfBits-1 downto 0) := (others => '0');
	constant period : time := 10 ns;

	--type ram_t is array (0 to 255) of integer range 0 to 255;
	--constant ram : ram_t := (127,130,133,136,139,142,145,148,151,154,157,160,163,166,169,172,175,178,181,184,186,189,192,194,197,200,202,205,207,209,212,214,216,218,221,223,225,227,229,230,232,234,235,237,239,240,241,243,244,245,246,247,248,249,250,250,251,252,252,253,253,253,253,253,254,253,253,253,253,253,252,252,251,250,250,249,248,247,246,245,244,243,241,240,239,237,235,234,232,230,229,227,225,223,221,218,216,214,212,209,207,205,202,200,197,194,192,189,186,184,181,178,175,172,169,166,163,160,157,154,151,148,145,142,139,136,133,130,127,123,120,117,114,111,108,105,102,99,96,93,90,87,84,81,78,75,72,69,67,64,61,59,56,53,51,48,46,44,41,39,37,35,32,30,28,26,24,23,21,19,18,16,14,13,12,10,9,8,7,6,5,4,3,3,2,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,2,3,3,4,5,6,7,8,9,10,12,13,14,16,18,19,21,23,24,26,28,30,32,35,37,39,41,44,46,48,51,53,56,59,61,64,67,69,72,75,78,81,84,87,90,93,96,99,102,105,108,111,114,117,120,123);
	type ram_t is array (0 to (2 ** numberOfBits) - 1) of std_logic_vector(7 downto 0);
	signal ram : ram_t := (others => (others => '0'));
	
	signal ram_pos : integer range 0 to (2 ** numberOfBits) - 1 := 0;
	signal loader_en, loader_clk, grabber_en, grabber_clk : std_logic := '0';

	signal sine_ready, ovflo : std_logic := '0';
	
	signal dds_we, dds_rdy, dds_rfd : std_logic := '0';
	signal dds_data, dds_sine : std_logic_vector(7 downto 0) := (others => '0');
	
	signal moo : integer := 0;

	file output : text open write_mode is "/tmp/xilinx.out";
BEGIN

	loader_clk <= not clk and loader_en and sine_ready;
	grabber_clk <= not clk and grabber_en and sine_ready;

	your_instance_name : dds
	PORT MAP (
		clk => clk,
		we => dds_we,
		data => dds_data,
		rdy => dds_rdy,
		rfd => dds_rfd,
		sine => dds_sine
	);

	fft_inst : fft
	  PORT MAP (
	    clk => clk,
	    start => start,
	    xn_re => xn_re,
	    xn_im => xn_im,
	    fwd_inv => fwd_inv,
	    fwd_inv_we => fwd_inv_we,
	    rfd => rfd,
	    xn_index => xn_index,
	    busy => busy,
	    edone => edone,
	    done => done,
	    dv => dv,
	    xk_index => xk_index,
	    xk_re => xk_re,
	    xk_im => xk_im
	  );

	

	clock_process : process
	begin
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
		clk <= '0';
	end process;

	loader : process(loader_clk)
	begin
		if(rising_edge(loader_clk)) then
			if(sine_ready = '1' and rfd = '1' and ram_pos /= 255) then
				--xn_re <= std_logic_vector(to_unsigned(ram(ram_pos), 8));
				xn_re <= ram(ram_pos);
				ram_pos <= ram_pos + 1;
			end if;
		end if;
	end process;
	
	grabber : process(grabber_clk)
		variable outie : line;
		variable temp : std_logic_vector(xk_index'range);
	begin
		if(rising_edge(grabber_clk)) then
			if(dv = '1') then
				write(outie, xk_re);
				write(outie, " ");
				write(outie, xk_im);
				write(outie, " ");
				--write(outie, std_logic_vector((signed(xk_re) + 128)));
				--write(outie, " ");
				--write(outie, std_logic_vector((signed(xk_im) + 128)));
				--write(outie, " ");
				write(outie, xk_index);
				writeLine(output, outie);
			end if;
		end if;
	end process;

	sine_gen : process(clk)
		variable pos : integer := -4;
		variable st : integer := 0;
		variable r_pos : integer := 0;
		variable a : unsigned(7 downto 0);
		file o : text open write_mode is "/tmp/dds.out";
		variable ln : line;
	begin
		if(rising_edge(clk)) then
			if(pos = -4) then
				if(dds_rdy = '0') then
					pos := pos - 1;
				end if;
			elsif(pos = -3) then
				dds_data <= "00111111";
			elsif(pos = -2) then
				dds_we <= '1';
			elsif(pos = -1) then
				dds_we <= '0';
			elsif(pos < (2 ** numberOfBits) - 1) then
				write(ln, dds_sine);
				writeLine(o, ln);
				ram(r_pos) <= dds_sine;
				r_pos := r_pos + 1;
			else
				sine_ready <= '1';
			end if;
			pos := pos + 1;
			moo <= pos;
		end if;
	end process;

	tb : PROCESS
	BEGIN
		wait for 100 ns; -- wait until global set/reset completes
		wait until sine_ready = '1';
		wait for 10 ns;
		fwd_inv <= '1';
		scale_sch <= "01010101";
		wait for 10 ns;
		fwd_inv_we <= '1';
		scale_sch_we <= '1';
		wait for 10 ns;
		fwd_inv_we <= '0';
		scale_sch_we <= '0';
		start <= '1';
		wait until rfd = '1';
		start <= '0';
		loader_en <= '1';
		wait until rfd = '0';
		loader_en <= '0';
		grabber_en <= '1';
		wait until dv = '0';
		grabber_en <= '0';
		wait for 8000 ns;
		wait;
	END PROCESS tb;
	--  End Test Bench 

END;
