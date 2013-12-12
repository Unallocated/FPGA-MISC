library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_test_parent is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_clk : out  STD_LOGIC);
end clk_test_parent;

architecture Behavioral of clk_test_parent is

	signal en : std_logic := '0';

	COMPONENT clk_test
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		data_in : IN std_logic_vector(7 downto 0);
		en : IN std_logic;          
		data_clk : OUT std_logic;
		data_out : OUT std_logic_vector(7 downto 0);
		data_out_clk : OUT std_logic
		);
	END COMPONENT;
	
	signal wr_clk, rd_clk, wr_en, rd_en, full, empty : std_logic := '0';
	signal dout, din : std_logic_vector(7 downto 0) := (others => '0');
	
	COMPONENT flow_3_adc_fifo
	  PORT (
	    rst : IN STD_LOGIC;
	    wr_clk : IN STD_LOGIC;
	    rd_clk : IN STD_LOGIC;
	    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    wr_en : IN STD_LOGIC;
	    rd_en : IN STD_LOGIC;
	    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    full : OUT STD_LOGIC;
	    empty : OUT STD_LOGIC
	  );
	END COMPONENT;

	type state_t is (INIT, WRITING, READING);
	signal state : state_t := INIT;

begin

	rd_clk <= clk;

	process(clk, rst)
	begin
		if(rst = '1') then
			state <= INIT;
		elsif(rising_edge(clk)) then
			case state is 
				when INIT =>
					if(full = '0') then
						state <= WRITING;
					end if;
				when WRITING =>
					wr_en <= '1';
					rd_en <= '0';
					en <= '1';
					
					if(full = '1') then
						wr_en <= '0';
						rd_en <= '1';
						en <= '0';
						state <= READING;
					end if;
				when READING =>
					rd_en <= '1';
					wr_en <= '0';
					en <= '0';
					
					if(empty = '1') then
						wr_en <= '1';
						rd_en <= '0';
						en <= '1';
						state <= WRITING;
					end if;
			end case;
			
			
		end if;
	end process;

	your_instance_name : flow_3_adc_fifo
	  PORT MAP (
	    rst => rst,
	    wr_clk => wr_clk,
	    rd_clk => rd_clk,
	    din => din,
	    wr_en => wr_en,
	    rd_en => rd_en,
	    dout => dout,
	    full => full,
	    empty => empty
	  );

	Inst_clk_test: clk_test PORT MAP(
		clk => clk,
		rst => rst,
		data_in => data_in,
		data_clk => data_clk,
		data_out => din,
		data_out_clk => wr_clk,
		en => en
	);

end Behavioral;

