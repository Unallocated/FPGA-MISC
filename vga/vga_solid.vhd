library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_solid is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           hs : out  STD_LOGIC;
           vs : out  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0));
end vga_solid;

architecture Behavioral of vga_solid is

	component vga_dcm
	port
	 (-- Clock in ports
	  CLK_IN1           : in     std_logic;
	  -- Clock out ports
	  CLK_OUT1          : out    std_logic;
	  -- Status and control signals
	  RESET             : in     std_logic
	 );
	end component;

	signal h_counter, v_counter : unsigned(9 downto 0) := (others => '0');
	signal vga_clk : std_logic := '0';
	
begin

	red <= (others => '0');
	green <= (others => '0');
	blue <= (others => '0');
	
	process(vga_clk, rst)
	begin
		if(rst = '1') then
			h_counter <= (others => '0');
			v_counter <= (others => '0');
		elsif(rising_edge(vga_clk)) then
			if(h_counter = 799) then
				h_counter <= (others => '0');
				if(v_counter = 524) then
					v_counter <= (others => '0');
				else
					v_counter <= v_counter + 1;
				end if;
			else
				h_counter <= h_counter + 1;
			end if;
			
			if(h_counter < 96) then
				hs <= '0';
			else
				hs <= '1';
			end if;
			
			if(h_counter > 96 + 
			
			if(v_counter < 2) then
				vs <= '0';
			else
				vs <= '1';
			end if;
		end if;
	end process;


	your_instance_name : vga_dcm
	  port map
		(-- Clock in ports
		 CLK_IN1 => clk,
		 -- Clock out ports
		 CLK_OUT1 => vga_clk,
		 -- Status and control signals
		 RESET  => rst);

end Behavioral;

