library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adc_sampler is
    Port ( clk : in  STD_LOGIC;
    	   en : in STD_LOGIC;
           rst : in  STD_LOGIC;
           adc_in : in  STD_LOGIC_VECTOR (7 downto 0);
           adc_clk : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0);
           clk_out : out  STD_LOGIC);
end adc_sampler;

architecture Behavioral of adc_sampler is
	type state_t is (ADC_CLK_HIGH, ADC_CLK_LOW, DATA_CLK_HIGH);
	signal state : state_t := ADC_CLK_HIGH;
	signal just_started : std_logic := '1';
begin

	process(clk, rst)
	begin
		if(rst = '1') then
			state <= ADC_CLK_HIGH;
			clk_out <= '0';
			data_out <= (others => '0');
			just_started <= '0';
		elsif(rising_edge(clk)) then
			if(en = '1') then
				case state is 
					when ADC_CLK_HIGH =>
						if(just_started = '1') then
							clk_out <= '0';
							adc_clk <= '1';
							state <= ADC_CLK_LOW;
						end if;
						
						just_started <= '1';					
					when ADC_CLK_LOW =>
						clk_out <= '0';
						adc_clk <= '0';
						data_out <= adc_in;
						state <= DATA_CLK_HIGH;
					when DATA_CLK_HIGH =>
						clk_out <= '1';
						state <= ADC_CLK_HIGH;
				end case;
			else
				clk_out <= '0';
			end if;
		end if;
	end process;

end Behavioral;

