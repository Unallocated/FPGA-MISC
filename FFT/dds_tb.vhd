LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;

ENTITY dds_tb IS
END dds_tb;
 
ARCHITECTURE behavior OF dds_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dds
    PORT(
         clk : IN  std_logic;
         we : IN  std_logic;
         data : IN  std_logic_vector(7 downto 0);
         rdy : OUT  std_logic;
         rfd : OUT  std_logic;
         sine : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal we : std_logic := '0';
   signal data : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal rdy : std_logic;
   signal rfd : std_logic;
   signal sine : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dds PORT MAP (
          clk => clk,
          we => we,
          data => data,
          rdy => rdy,
          rfd => rfd,
          sine => sine
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

	process(clk)
		file output_file : text open write_mode is "/tmp/dds.out";
		variable ln : line;
		variable a : unsigned(7 downto 0);
		variable pos : integer := 0;
		variable set : integer := -4;
		variable odd : std_logic := '0';
	begin
		if(rising_edge(clk)) then
			if(rfd = '1' and pos /= 256) then
				if(set = -4) then
					data <= "01111111";
					set := set + 1;
				elsif(set = -3) then
					we <= '1';
					set := set + 1;
				elsif(set = -2) then
					we <= '0';
					set := set + 1;
				elsif(set = -1) then
					set := set + 1;
				elsif(sine(7) = '1') then
					a := unsigned(sine) - 127;
				else
					a := unsigned(sine) + 128;
				end if;

				if(odd = '0') then
					write(ln, sine);
					write(ln, " ");
					write(ln, std_logic_vector(a));
					writeline(output_file, ln);
					pos := pos + 1;
				end if;
				odd := not odd;
			end if;
		end if;
	end process;
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
