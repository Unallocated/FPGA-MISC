library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           adc_in : in  STD_LOGIC_VECTOR(7 downto 0);
           adc_clk : out  STD_LOGIC);
end main;

architecture Behavioral of main is
	COMPONENT fft
	  PORT (
	    clk : IN STD_LOGIC;
	    start : IN STD_LOGIC;
	    xn_re : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xn_im : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    fwd_inv : IN STD_LOGIC;
	    fwd_inv_we : IN STD_LOGIC;
	    scale_sch : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	    scale_sch_we : IN STD_LOGIC;
	    rfd : OUT STD_LOGIC;
	    xn_index : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	    busy : OUT STD_LOGIC;
	    edone : OUT STD_LOGIC;
	    done : OUT STD_LOGIC;
	    dv : OUT STD_LOGIC;
	    xk_index : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	    xk_re : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    xk_im : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    ovflo : OUT STD_LOGIC
	  );
	END COMPONENT;

	signal fft_en, start, fwd_inv, fwd_inv_we, scale_sch_we, rfd, busy, edone, done, dv, ovflo : std_logic := '0';
	signal xn_re, xn_im, xk_re, xk_im : std_logic_vector(7 downto 0) := (others => '0');
	signal scale_sch, xk_index, xn_index : std_logic_vector(11 downto 0) := (others => '0');

	signal adc_clk_buffer : std_logic := '0';

	type ram_t is array(0 to 2047) of std_logic_vector(7 downto 0);
	signal ram : ram_t := (others => (others => '0'));

	type state_t is (IDLE, LOADING, WAITING, UNLOADING);
	signal state : state_t := IDLE;
begin
	adc_clk <= adc_clk_buffer;

	fft_instance : fft
	  PORT MAP (
	    clk => clk,
	    start => start,
	    xn_re => xn_re,
	    xn_im => xn_im,
	    fwd_inv => '1',
	    fwd_inv_we => '1',
	    scale_sch => scale_sch,
	    scale_sch_we => scale_sch_we,
	    rfd => rfd,
	    xn_index => xn_index,
	    busy => busy,
	    edone => edone,
	    done => done,
	    dv => dv,
	    xk_index => xk_index,
	    xk_re => xk_re,
	    xk_im => xk_im,
	    ovflo => ovflo
	  );

	process(clk, rst)
	begin
		if(rst = '1') then
			adc_clk_buffer <= '0';
			start <= '0';
			state <= IDLE;
			ram <= (others => (others => '0'));
		else
			if(rising_edge(clk)) then
				case state is
				when IDLE =>
					start <= '1';
					if(rfd = '1') then
						state <= LOADING;
					end if;
				when LOADING =>
					xn_re <= adc_in;
					if(xn_index = (xn_index'range => '1')) then
						state <= WAITING;
					end if;
				when WAITING =>
					if(done = '1') then
						state <= UNLOADING;
					end if;
				when UNLOADING =>
					ram(integer((xk_index))) <= xk_re;
					if(xk_index = (xn_index'range => '1')) then
						state <= IDLE;
					end if;
				end case;
			end if;
		end if;
	end process;
					
					
					

end Behavioral;

