library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library unisim;
use unisim.vcomponents.all;

entity eth is
  port ( clk : in std_logic;
         rst : in std_logic;
         mdio : inout std_logic;
         mdc : out std_logic;
         eth_rst : out std_logic;
         tx_clk : in std_logic;
         tx_er : out std_logic;
         tx_en : out std_logic;
         tx_data : out std_logic_vector(3 downto 0);
         mdc_ext : out std_logic;
         mdio_ext : inout std_logic;
         leds : out std_logic_vector(7 downto 0);
         byte_select : in std_logic;
         sw : in std_logic_vector(3 downto 0)
  );
end eth;

architecture Behavioral of eth is
  
  signal smi_rd_en, smi_wr_en, smi_done, smi_working, smi_rdy : std_logic;
  signal smi_addr : std_logic_vector(3 downto 0);
  signal smi_data_in, smi_data_out : std_logic_vector(15 downto 0);
  COMPONENT smi_ramlike
  PORT(
    clk : IN std_logic;
    rst : IN std_logic;
    rd_en : IN std_logic;
    wr_en : IN std_logic;
    addr : IN std_logic_vector(3 downto 0);
    data_in : IN std_logic_vector(15 downto 0);    
    mdio : INOUT std_logic;      
    data_out : OUT std_logic_vector(15 downto 0);
    working : OUT std_logic;
    done : OUT std_logic;
    rdy : OUT std_logic
    );
  END COMPONENT;

  signal clk_100mhz, clk_10mhz : std_logic;
  COMPONENT clock_mgr
  PORT (
    clk_100mhz : IN std_logic;
    orig_clk : OUT std_logic;
    clk_10mhz : OUT std_logic;
    clk_10mhz_CE : IN std_logic
   );
  END COMPONENT;

  signal eth_rdy : std_logic;
  signal reset_counter : integer;

  type smi_state_t is (IDLE, START_READ, END_READ, WAIT_FOR_DONE);
  signal smi_state : smi_state_t;
  signal smi_counter : integer;
  signal mdio_buffered : std_logic;
  signal leds_buffer : std_logic_vector(leds'range);
begin

  leds <= leds_buffer;
  tx_data <= (others => '0');
  tx_er <= '1';
  tx_en <= '0';
  mdc <= clk_10mhz;
  mdc_ext <= clk_10mhz;
  mdio_ext <= mdio_buffered;
  mdio <= mdio_buffered;
  smi_addr <= sw;

  process(clk_10mhz, rst)
  begin
    if(rst = '1') then
      smi_rd_en <= '0';
      smi_state <= IDLE;
      smi_counter <= 0;
      leds_buffer <= x"7e";
      smi_wr_en <= '0';
    elsif(rising_edge(clk_10mhz)) then
      case smi_state is
        when IDLE =>
          smi_rd_en <= '0';
          if(smi_rdy = '1') then
            smi_counter <= smi_counter + 1;
            if(smi_counter = 100) then
              smi_counter <= 0;
              smi_state <= START_READ;
            end if;
          end if;

        when START_READ =>
          smi_rd_en <= '1';
          smi_state <= END_READ;

        when END_READ =>
          smi_rd_en <= '0';
          smi_state <= WAIT_FOR_DONE;

        when WAIT_FOR_DONE =>
          if(smi_done = '1') then
            --leds <= smi_data_out(15 downto 8);
            if(byte_select = '0') then
              leds_buffer <= smi_data_out(7 downto 0);
            else
              leds_buffer <= smi_data_out(15 downto 8);
            end if;
            smi_state <= IDLE;
          end if;

      end case;
    end if;
  end process;

  process(clk_100mhz, rst)
  begin
    if(rst = '1') then
      eth_rdy <= '0';
      eth_rst <= '1';
      reset_counter <= 0;
    elsif(rising_edge(clk_100mhz)) then
      eth_rst <= '0';
      if(reset_counter = 1_000) then
        eth_rst <= '1';
        eth_rdy <= '1';
      else
        reset_counter <= reset_counter + 1;
      end if;
    end if;
  end process;

  clk_mgr_inst : clock_mgr PORT MAP (
    clk_100mhz => clk,
    orig_clk => clk_100mhz,
    clk_10mhz => clk_10mhz,
    clk_10mhz_CE => eth_rdy
  ); 

  Inst_smi_ramlike: smi_ramlike PORT MAP(
    clk => clk_10mhz,
    rst => rst,
    mdio => mdio_buffered,
    rd_en => smi_rd_en,
    wr_en => smi_wr_en,
    addr => smi_addr,
    data_in => smi_data_in,
    data_out => smi_data_out,
    working => smi_working,
    done => smi_done,
    rdy => smi_rdy
  );

end Behavioral;

