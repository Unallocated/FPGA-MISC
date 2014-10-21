library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity serial_master is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           tx : out  STD_LOGIC;
           leds : out  STD_LOGIC_VECTOR (7 downto 0));
end serial_master;

architecture Behavioral of serial_master is

	COMPONENT serial_rx
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		rx : IN std_logic;          
		leds : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT serial_tx
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;          
		tx : OUT std_logic
		);
	END COMPONENT;

begin

	Inst_serial_rx: serial_rx PORT MAP(
		clk => clk,
		rst => rst,
		rx => rx,
		leds => leds
	);

	Inst_serial_tx: serial_tx PORT MAP(
		clk => clk,
		rst => rst,
		tx => tx
	);

end Behavioral;


