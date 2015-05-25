library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity smi is
  generic ( data_width : positive := 4);
  port ( clk : in std_logic;
         rst : in std_logic;
         mdio : inout std_logic;
         mdc : out std_logic;
         eth_rst : out std_logic;
         tx_clk : in std_logic;
         tx_en : out std_logic;
         tx_data : out std_logic_vector(data_width-1 downto 0);
         ext_mdio : out std_logic;
         ext_mdc : out std_logic;
         sw : in std_logic_vector(3 downto 0);
         leds : out std_logic_vector(7 downto 0)
  );
end smi;

architecture behave of smi is

  signal reset_counter : integer;
  signal reset_done : std_logic;
  
  signal mdio_pos : integer;
  constant mdio_get_link_status : std_logic_vector(natural range <>) := x"FFFFFFFF" & "01" & "10" & "00000" & "00001";
  type mdio_state_t is (SEND_COMMAND, READ_BACK, IDLE);
  signal mdio_state : mdio_state_t;

  signal mdio_buffer : std_logic;

  signal mdc_counter : integer;
  signal mdc_clk : std_logic;
begin

  tx_en <= '0';
  tx_data <= (others => '0');
  mdc <= mdc_clk;
  ext_mdc <= mdc_clk;
  ext_mdio <= mdio_buffer;
  mdio <= mdio_buffer;

  process(clk, rst)
  begin
    if(rst = '1') then
      mdc_counter <= 0;
      mdc_clk <= '0';
    elsif(rising_edge(clk)) then
      mdc_counter <= mdc_counter + 1;
      if(mdc_counter = 100) then
        mdc_clk <= not mdc_clk;
        mdc_counter <= 0;
      end if;
    end if;
  end process;

  process(clk, rst)
  begin
    if(rst = '1') then
      reset_counter <= 0;
      reset_done <= '0';
      eth_rst <= '0';
      leds(3 downto 0) <= (others => '0');
    elsif(rising_edge(clk)) then
      if(reset_done = '0') then
        reset_counter <= reset_counter + 1;
        leds(3 downto 0) <= "1100";
        if(reset_counter = 100_0) then
          reset_counter <= 0;
          reset_done <= '1';
          eth_rst <= '1';
          leds(3 downto 0) <= "0010";
        end if;
      end if;
    end if;
  end process;

  process(mdc_clk, rst)
  begin
    if(rst = '1') then
      leds(7 downto 4) <= (others => '0');
      mdio_buffer <= '0';
      mdio_pos <= 0;
      mdio_state <= SEND_COMMAND;
    elsif(rising_edge(mdc_clk)) then
      if(reset_done = '1') then
        case mdio_state is
          when SEND_COMMAND =>
            mdio_pos <= mdio_pos + 1;
            if(mdio_pos < mdio_get_link_status'length) then
              mdio_buffer <= mdio_get_link_status(mdio_pos);
            else
              mdio_state <= READ_BACK;
              mdio_pos <= 0;
              mdio_buffer <= 'Z';
            end if;
          
          when READ_BACK =>
            mdio_buffer <= 'Z';
            mdio_pos <= mdio_pos + 1;
            if(mdio_pos = to_integer(unsigned(sw))) then
              leds(7 downto 4) <= (others => mdio);
            elsif(mdio_pos = 16) then
              mdio_pos <= 0;
              mdio_state <= IDLE;
            end if;

          when IDLE =>
            mdio_buffer <= '0';
            mdio_state <= SEND_COMMAND;
        end case;
      end if;
    end if;
  end process;

end behave;
