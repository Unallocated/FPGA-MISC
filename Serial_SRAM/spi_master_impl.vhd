library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity spi_master_impl is
	Port(clk  : in  STD_LOGIC;
		 rst  : in  STD_LOGIC;
		 so   : out STD_LOGIC;
		 si   : in  STD_LOGIC;
		 leds : out STD_LOGIC_VECTOR(7 downto 0);
		 sck  : out STD_LOGIC;
		 cs   : out STD_LOGIC);
end spi_master_impl;

architecture Behavioral of spi_master_impl is
	type state_t is (INIT, STALL, FINISH);
	signal state : state_t := INIT;

	COMPONENT spi_master
		PORT(
			clk      : IN  std_logic;
			data_in  : IN  std_logic_vector(7 downto 0);
			sck      : OUT std_logic;
			si       : IN  std_logic;
			so       : OUT std_logic;
			rst      : IN  std_logic;
			data_out : OUT std_logic_vector(7 downto 0);
			rdy      : OUT std_logic;
			start    : IN  std_logic;
			cs       : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	signal data_in : std_logic_vector(7 downto 0) := (others => '0');
	signal start   : std_logic                    := '0';

	--Outputs
	signal rdy      : std_logic;
	
begin

	master: spi_master PORT MAP (
          clk => clk,
          data_in => data_in,
          sck => sck,
          si => si,
          so => so,
          rst => rst,
          data_out => leds,
          rdy => rdy,
          start => start,
          cs => cs
        );

	process(clk, rst) 
	begin
		if(rst = '1') then
			state <= INIT;
		elsif(rising_edge(clk)) then
			case state is
				when INIT =>
					if(rdy = '1') then
						data_in <= x"55";
						start <= '1';
						state <= STALL;
					end if;
				
				when STALL =>
					if(rdy = '0') then
						start <= '0';
						state <= FINISH;
					end if;
					
				when FINISH =>
					if(rdy = '1') then
						state <= INIT;
					end if;
			end case;
		end if;
	end process;

end Behavioral;

