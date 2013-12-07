library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity the_hard_way is
    Port ( clk : in  STD_LOGIC;
           so : out  STD_LOGIC;
           cs : out  STD_LOGIC;
           si : in  STD_LOGIC;
           sck : out  STD_LOGIC;
           rst : in  STD_LOGIC);
end the_hard_way;

architecture Behavioral of the_hard_way is

	signal pos : integer := 0;
	signal slow_clk : std_logic := '0';
begin

	process(clk, rst)
		variable count : integer := 0;
	begin
		if(rst = '1') then
			count := 0;
			slow_clk <= '0';
		elsif(rising_edge(clk)) then
			if(count = 500/2) then
				slow_clk <= not slow_clk;
				count := 0;
			else
				count := count + 1;
			end if;
		end if;
	end process;
		

	process(slow_clk, rst)
	begin
		if(rst = '1') then
			pos <= 0;
		elsif(rising_edge(slow_clk)) then
			case pos is
				when 0 =>
					cs <= '1';
					sck <= '0';
				when 1 =>
					cs <= '0';
					
					
					-- command
					
				when 2 =>
					so <= '0';
				when 3 =>
					sck <= '1';
				when 4 =>
					sck <= '0';
					
				when 5 =>
					so <= '0';
				when 6 =>
					sck <= '1';
				when 7 =>
					sck <= '0';
					
				when 8 =>
					so <= '0';
				when 9 =>
					sck <= '1';
				when 10 =>
					sck <= '0';
					
				when 11 =>
					so <= '0';
				when 12 =>
					sck <= '1';
				when 13 =>
					sck <= '0';
					
				when 14 =>
					so <= '0';
				when 15 =>
					sck <= '1';
				when 16 =>
					sck <= '0';
					
				when 17 =>
					so <= '0';
				when 18 =>
					sck <= '1';
				when 19 =>
					sck <= '0';
					
				when 20 =>
					so <= '1';
				when 21 =>
					sck <= '1';
				when 22 =>
					sck <= '0';
					
				when 23 =>
					so <= '0';
				when 24 =>
					sck <= '1';
				when 25 =>
					sck <= '0';
					
					
					
					
					
					-- address
					
				when 26 =>
					so <= '0';
				when 27 =>
					sck <= '1';
				when 28 =>
					sck <= '0';
					
				when 29 =>
					so <= '0';
				when 30 =>
					sck <= '1';
				when 31 =>
					sck <= '0';
					
				when 32 =>
					so <= '0';
				when 33 =>
					sck <= '1';
				when 34 =>
					sck <= '0';
					
				when 35 =>
					so <= '0';
				when 36 =>
					sck <= '1';
				when 37 =>
					sck <= '0';
					
				when 38 =>
					so <= '0';
				when 39 =>
					sck <= '1';
				when 40 =>
					sck <= '0';
					
				when 41 =>
					so <= '0';
				when 42 =>
					sck <= '1';
				when 43 =>
					sck <= '0';
					
				when 44 =>
					so <= '0';
				when 45 =>
					sck <= '1';
				when 46 =>
					sck <= '0';
					
				when 47 =>
					so <= '0';
				when 48 =>
					sck <= '1';
				when 49 =>
					sck <= '0';
					
				when 50 =>
					so <= '0';
				when 51 =>
					sck <= '1';
				when 52 =>
					sck <= '0';
					
				when 53 =>
					so <= '0';
				when 54 =>
					sck <= '1';
				when 55 =>
					sck <= '0';
					
				when 56 =>
					so <= '0';
				when 57 =>
					sck <= '1';
				when 58 =>
					sck <= '0';
					
				when 59 =>
					so <= '0';
				when 60 =>
					sck <= '1';
				when 61 =>
					sck <= '0';
					
				when 62 =>
					so <= '0';
				when 63 =>
					sck <= '1';
				when 64 =>
					sck <= '0';
					
				when 65 =>
					so <= '0';
				when 66 =>
					sck <= '1';
				when 67 =>
					sck <= '0';
					
				when 68 =>
					so <= '1';
				when 69 =>
					sck <= '1';
				when 70 =>
					sck <= '0';
					
				when 71 =>
					so <= '0';
				when 72 =>
					sck <= '1';
				when 73 =>
					sck <= '0';
					cs <= '1';
					
					
					
					-- reading
					
					
					
					-- command
					
				when 74 =>
					cs <= '0';
					so <= '0';
				when 75 =>
					sck <= '1';
				when 76 =>
					sck <= '0';
					
				when 77 =>
					so <= '0';
				when 78 =>
					sck <= '1';
				when 79 =>
					sck <= '0';
					
				when 80 =>
					so <= '0';
				when 81 =>
					sck <= '1';
				when 82 =>
					sck <= '0';
					
				when 83 =>
					so <= '0';
				when 84 =>
					sck <= '1';
				when 85 =>
					sck <= '0';
					
				when 86 =>
					so <= '0';
				when 87 =>
					sck <= '1';
				when 88 =>
					sck <= '0';
					
				when 89 =>
					so <= '0';
				when 90 =>
					sck <= '1';
				when 91 =>
					sck <= '0';
					
				when 92 =>
					so <= '1';
				when 93 =>
					sck <= '1';
				when 94 =>
					sck <= '0';
					
				when 95 =>
					so <= '1';
				when 96 =>
					sck <= '1';
				when 97 =>
					sck <= '0';
					
					
					
					
					-- address
					
				when 98 =>
					so <= '0';
				when 99 =>
					sck <= '1';
				when 100 =>
					sck <= '0';
					
				when 101 =>
					so <= '0';
				when 102 =>
					sck <= '1';
				when 103 =>
					sck <= '0';
					
				when 104 =>
					so <= '0';
				when 105 =>
					sck <= '1';
				when 106 =>
					sck <= '0';
					
				when 107 =>
					so <= '0';
				when 108 =>
					sck <= '1';
				when 109 =>
					sck <= '0';
					
				when 110 =>
					so <= '0';
				when 111 =>
					sck <= '1';
				when 112 =>
					sck <= '0';
					
				when 113 =>
					so <= '0';
				when 114 =>
					sck <= '1';
				when 115 =>
					sck <= '0';
					
				when 116 =>
					so <= '0';
				when 117 =>
					sck <= '1';
				when 118 =>
					sck <= '0';
					
				when 119 =>
					so <= '0';
				when 120 =>
					sck <= '1';
				when 121 =>
					sck <= '0';
					
				when 122 =>
					so <= '0';
				when 123 =>
					sck <= '1';
				when 124 =>
					sck <= '0';
					
				when 125 =>
					so <= '0';
				when 126 =>
					sck <= '1';
				when 127 =>
					sck <= '0';
					
				when 128 =>
					so <= '0';
				when 129 =>
					sck <= '1';
				when 130 =>
					sck <= '0';
					
				when 131 =>
					so <= '0';
				when 132 =>
					sck <= '1';
				when 133 =>
					sck <= '0';
					
				when 134 =>
					so <= '0';
				when 135 =>
					sck <= '1';
				when 136 =>
					sck <= '0';
					
				when 137 =>
					so <= '0';
				when 138 =>
					sck <= '1';
				when 139 =>
					sck <= '0';
					
				when 140 =>
					so <= '0';
				when 141 =>
					sck <= '1';
				when 142 =>
					sck <= '0';
					
				when 143 =>
					so <= '1';
				when 144 =>
					sck <= '1';
				when 145 =>
					sck <= '0';
				
				
				
				
				
				when 74 =>
					cs <= '0';
					so <= '0';
				when 75 =>
					sck <= '1';
				when 76 =>
					sck <= '0';
					
				when 77 =>
					so <= '0';
				when 78 =>
					sck <= '1';
				when 79 =>
					sck <= '0';
					
				when 80 =>
					so <= '0';
				when 81 =>
					sck <= '1';
				when 82 =>
					sck <= '0';
					
				when 83 =>
					so <= '0';
				when 84 =>
					sck <= '1';
				when 85 =>
					sck <= '0';
					
				when 86 =>
					so <= '0';
				when 87 =>
					sck <= '1';
				when 88 =>
					sck <= '0';
					
				when 89 =>
					so <= '0';
				when 90 =>
					sck <= '1';
				when 91 =>
					sck <= '0';
					
				when 92 =>
					so <= '1';
				when 93 =>
					sck <= '1';
				when 94 =>
					sck <= '0';
					
				when 95 =>
					so <= '1';
				when 96 =>
					sck <= '1';
				when 97 =>
					sck <= '0';
					cs <= '1';
				
				when others =>
					null;
					
				
				
			end case;
			
			if(pos = 145) then
				pos <= 0;
			else
				pos <= pos + 1;
			end if;
		end if;
	end process;

end Behavioral;

