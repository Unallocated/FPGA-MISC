library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sync_sram is
	Port(clk      : in    STD_LOGIC;
		 rst      : in    STD_LOGIC;
		 ram_addr : out   STD_LOGIC_VECTOR(21 downto 0);
		 ram_data : inout STD_LOGIC_VECTOR(15 downto 0);
		 ram_clk  : out   STD_LOGIC;
		 ram_lb   : out   STD_LOGIC;
		 ram_ub   : out   STD_LOGIC;
		 ram_ce   : out   STD_LOGIC;
		 ram_adv  : out   STD_LOGIC;
		 ram_cre  : out   STD_LOGIC;
		 ram_we   : out   STD_LOGIC;
		 ram_oe   : out   STD_LOGIC;
		 data_in  : in    STD_LOGIC_VECTOR(15 downto 0);
		 addr     : in    STD_LOGIC_VECTOR(21 downto 0);
		 data_out : out   STD_LOGIC_VECTOR(15 downto 0);
		 done     : out   STD_LOGIC;
		 start    : in    STD_LOGIC;
		 we       : in    STD_LOGIC);
end sync_sram;

architecture Behavioral of sync_sram is
	signal we_buffer        : std_logic                     := '0';
--	signal data_in_buffer   : std_logic_vector(15 downto 0) := (others => '0');
--	signal addr_buffer      : std_logic_vector(21 downto 0) := (others => '0');
	

	type state_type is (IDLE, SET_MODE, TRIGGER, STALL);
	signal state : state_type := IDLE;
begin
	
	ram_adv <= '0';
	ram_clk <= '0';
	ram_cre <= '0';

	process(clk, rst, start)
		variable last_start_value : std_logic := '0';
	begin
		if(rst = '1') then
			state <= IDLE;
		elsif(rising_edge(clk)) then
			case state is
				when IDLE =>
					if(start = '1' and last_start_value = '0') then
						state <= SET_MODE;
						we_buffer <= we;
						
						ram_addr <= addr;
						
						if(we = '1') then	
							ram_data <= data_in;
						else
							ram_data <= (others => 'Z');
						end if;
					end if;
				when SET_MODE =>
					if(we_buffer = '1') then
						ram_oe <= '1';
					else
						ram_oe <= '0';
						ram_we <= '1';
					end if;
					
					state <= TRIGGER;
				when TRIGGER =>
					if(we_buffer = '1') then
						ram_we <= '0';
					end if;
					
					state <= STALL;
				when STALL =>
					if(we_buffer = '0') then
						data_out <= ram_data;
					end if;
					
					state <= IDLE;
			end case;
		end if;
		last_start_value := start;
	end process;
					
end Behavioral;

