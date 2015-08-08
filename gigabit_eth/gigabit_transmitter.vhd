library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gigabit_transmitter is
  port ( tx_clk : in  STD_LOGIC;
         rst : in  STD_LOGIC;
         tx_er : out  STD_LOGIC;
         tx_data : out  STD_LOGIC_VECTOR (7 downto 0);
         tx_en : out  STD_LOGIC;
         link_established : in  STD_LOGIC;
         reset_complete : in  STD_LOGIC;
         wr_en : in std_logic;
         data_in : in std_logic_vector(7 downto 0)
      );
end gigabit_transmitter;

architecture behave of gigabit_transmitter is

  signal data_buffer : std_logic_vector(7 downto 0);
  signal wr_en_buffer : std_logic;

  type state_t is (WAIT_FOR_DATA, SEND);
  signal state : state_t;
begin

  tx_er <= '0';

  process(tx_clk, rst)
  begin
    if(rst = '1') then
      tx_data <= (others => '0');
      tx_en <= '0';
      state <= WAIT_FOR_DATA;
    elsif(rising_edge(tx_clk)) then
      if(link_established = '1' and reset_complete = '1') then
        case state is
          when WAIT_FOR_DATA =>
            tx_en <= '0';
            if(wr_en = '1') then
              data_buffer <= data_in;
              state <= SEND;
              tx_en <= '1';
            end if;

          when SEND =>
            tx_data <= data_buffer;
            
            if(wr_en = '1') then
              data_buffer <= data_in;
            else
              state <= WAIT_FOR_DATA;
            end if;
        end case;
      end if;
    end if;
  end process;

end behave;

