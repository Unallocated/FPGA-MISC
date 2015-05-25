library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity e is
  generic ( data_width : positive := 4);
	port ( clk : in std_logic;
		     rst : in std_logic;
		     --mdio : inout std_logic;
		     --mdc : out std_logic;
		     --int : out std_logic;
		     eth_rst : out std_logic;
		     --collision : in std_logic;
		     --crs : in std_logic;
		     --rx_dv : in std_logic;
		     --rx_clk : in std_logic;
		     --rx_err : in std_logic;
		     --rx_data : in std_logic_vector(data_width-1 downto 0);
		   
		     --gtx_clk : out std_logic;
		     tx_clk : in std_logic;
		     tx_er : out std_logic;
		     tx_en : out std_logic;
		     tx_data : out std_logic_vector(data_width-1 downto 0);

         leds : out std_logic_vector(7 downto 0)
	);
end e;

architecture behave of e is
	  signal ready : std_logic;
    signal reset_counter : integer;
    signal payload : std_logic_vector((132 * 4) - 1 downto 0);
    signal pos : integer range 0 to payload'length - 1;

    type state_t is (SEND_PAYLOAD, STALL);
    signal state : state_t;
    signal stall_counter : integer;
begin

  leds(3 downto 0) <= (others => tx_clk);
  tx_er <= '1';
  --mdio <= 'Z';
  --mdc <= '0';

  process(clk, rst)
  begin
    if(rst = '1') then
      ready <= '0';
      eth_rst <= '0';
      reset_counter <= 0;
      leds(7 downto 4) <= "1010";
    elsif(rising_edge(clk)) then
      if(reset_counter = 100_000_000) then
        ready <= '1';
        eth_rst <= '1';
        leds(7 downto 4) <= "1100";
      else
        eth_rst <= '0';
        ready <= '0';
        reset_counter <= reset_counter + 1;
        leds(7 downto 4) <= "0011";
      end if;
    end if;
  end process;

  process(tx_clk, rst)
  begin
    if(rst = '1') then
      pos <= 0;
      state <= SEND_PAYLOAD;
      stall_counter <= 0;
      tx_en <= '0';
      payload <= x"0050b60a6ae7007f28c9a486080045000034e58540003c06e0381700a051c0a8010c0050de0ee30299e035123dd280100208c97700000101080a315e43a62917c5f5";
    elsif(rising_edge(tx_clk)) then
      if(ready = '1') then
        case state is
          when SEND_PAYLOAD =>
            tx_en <= '1';
            tx_data <= payload(payload'high downto payload'high - 3);
            payload <= payload(payload'high - 4 downto 0) & payload(payload'high downto payload'high - 3);
            if(pos = payload'length - 4) then
              state <= STALL;
              stall_counter <= 0;
            else
              pos <= pos + 4;
            end if;
          
          when STALL =>
            tx_en <= '0';
            if(stall_counter = 100_000) then
              pos <= 0;
              state <= SEND_PAYLOAD;
            else
              stall_counter <= stall_counter + 1;
            end if;
          
        end case;
      end if;
    end if;
  end process;

end behave;
