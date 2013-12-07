library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_one is
    Port ( clk : in STD_LOGIC;
           rst : in  STD_LOGIC;
           start : in std_logic;
           so : out  STD_LOGIC;
           si : in  STD_LOGIC;
           sck : out  STD_LOGIC;
           we : in std_logic;
           address : in std_logic_vector(15 downto 0);
           data_in : in std_logic_vector(7 downto 0);
           data_out : out std_logic_vector(7 downto 0);
           done : out std_logic);
end test_one;

architecture Behavioral of test_one is

	type state_t is (IDLE, SEND_INST, SEND_ADDR, SEND_DATA, GET_DATA);
	signal state : state_t := IDLE;
	
--	signal en : std_logic := '0';
	
	constant READ : std_logic_vector(7 downto 0) := "00000011";
	constant WRITE : std_logic_vector(7 downto 0) := "00000010";
	
--	signal clk_0, clk_90 : std_logic := '0';
	
--	signal clk_buffered : std_logic;
--	component phase_gen
--		port
--		 (-- Clock in ports
--		  clk           : in     std_logic;
--		  -- Clock out ports
--		  clk_0          : out    std_logic;
--		  clk_90          : out    std_logic
--		 );
--		end component;
	
begin

	

	--sck <= (clk_90);

--	your_instance_name : phase_gen
--	  port map
--	   (-- Clock in ports
--	    clk => clk,
--	    -- Clock out ports
--	    clk_0 => clk_0,
--	    clk_90 => clk_90);

--	process(clk_0,rst) 
--	begin
--		if(rst = '1') then
--			slow_clk <= '0';
--		elsif(rising_edge(clk_0)) then
--			slow_clk <= not slow_clk;
--		end if;
--	end process;
	

	process(clk, rst)
		variable data_pos : integer range 0 to 15 := 0;
		variable local_addr : std_logic_vector(address'range) := (others => '1');
		variable local_data : std_logic_vector(data_in'range) := (others => '1');
		variable local_we : std_logic := '0';
		variable pulse : std_logic_vector(1 downto 0) := "00";
	begin
		if(rst = '1') then
			data_pos := 0;
			state <= IDLE;
--			en <= '0';
			done <= '1';
			pulse := "00";
		elsif(rising_edge(clk)) then
				if(pulse = "01") then
					sck <= '1';
					pulse := "10";
				elsif(pulse = "10") then
					sck <= '0';
					pulse := "00";
				else
					case state is
						when IDLE =>
--							en <= '0';
							done <= '1';
							data_pos := 7;
							so <= '0';
							if(start = '1') then
								state <= SEND_INST;
								done <= '0';
								local_we := we;
								local_data := data_in;
								local_addr := address;
							end if;
							
						when SEND_INST =>
							done <= '0';
--							en <= '1';
							if(local_we = '1') then
								so <= WRITE(data_pos);
							else
								so <= READ(data_pos);
							end if;
							
							if(data_pos = 0) then
								data_pos := local_addr'high;
								state <= SEND_ADDR;
							else
								data_pos := data_pos - 1;
								
							end if;
							pulse := "01";
						when SEND_ADDR =>
							so <= local_addr(data_pos);
							if(data_pos = 0) then
								data_pos := local_data'high;
								if(local_we = '1') then
									state <= SEND_DATA;
								else
									state <= GET_DATA;
								end if;
							else
								data_pos := data_pos - 1;
								
							end if;
							pulse := "01";
						when SEND_DATA =>
							so <= local_data(data_pos);
							if(data_pos = 0) then
								data_pos := 0;
								state <= IDLE;
							else
								data_pos := data_pos - 1;
								
							end if;
							pulse := "01";
						when GET_DATA =>
							local_data(data_pos) := si;
							if(data_pos = 0) then
								state <= IDLE;
								data_out <= local_data;
								data_pos := 0;
							else
								data_pos := data_pos - 1;
							end if;
							pulse := "01";
					end case;
				end if;
			end if;
	end process;		

end Behavioral;

