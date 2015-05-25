library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.frame_types.all;

library unisim;
use unisim.vcomponents.all;

entity eth2 is
  port ( clk : in std_logic;
         rst : in std_logic;
         mdio : inout std_logic;
         mdc : out std_logic;
         eth_rst : out std_logic;
			tx_er : out std_logic;
         tx_clk : in std_logic;
         tx_en : out std_logic;
         tx_data : out std_logic_vector(3 downto 0);
         leds : out std_logic_vector(7 downto 0);
         rx : in std_logic
  );
end eth2;

architecture Behavioral of eth2 is
  
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

  signal clk_100mhz, smi_clk : std_logic;
  COMPONENT clock_mgr
  PORT (
    base_clk : IN std_logic;
    base_clk_copy : OUT std_logic;
    smi_clk : OUT std_logic;
    smi_clk_ce : IN std_logic
   );
  END COMPONENT;

  signal current_frame : frame_t;
  signal frame_valid, last_frame_valid : std_logic;
  COMPONENT uart_comms
  GENERIC(
    clk_rate : positive := 25_000_000;
    baud_rate: positive := 500_000
  );
  PORT(
    clk : IN std_logic;
    rst : IN std_logic;
    rx : IN std_logic;          
    frame : OUT frame_t;
    frame_valid : OUT std_logic
    );
  END COMPONENT;

  signal eth_rdy : std_logic;
  signal reset_counter : integer;

  type smi_state_t is (IDLE, START_READ, END_READ, WAIT_FOR_DONE);
  signal smi_state : smi_state_t;
  signal smi_counter : integer;

  signal link_detected : std_logic;

  constant payload : std_logic_vector(0 to (72 * 8) - 1) := x"55555555555555d5ffffffffffff007f28c9a48608010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020304";
  signal payload_pos : integer range 0 to payload'high;
  type tx_state_t is (WAIT_FOR_LINK, SEND_PAYLOAD_LOW, SEND_PAYLOAD_HIGH, STALL);
  signal byte_pos, nibble_pos : integer;
  signal tx_state : tx_state_t;
  signal stall_counter : integer;
  signal frame_data : frame_t;
begin

  mdc <= smi_clk;
  tx_er <= '0';
  smi_addr <= "0001";

  Inst_uart_comms: uart_comms PORT MAP(
    clk => tx_clk,
    rst => rst,
    rx => rx,
    frame => current_frame,
    frame_valid => frame_valid
  );

  process(tx_clk, rst)
  begin
    if(rst = '1') then
      payload_pos <= 0;
      tx_state <= WAIT_FOR_LINK;
      stall_counter <= 0;
		  leds <= "00001111";
    elsif(rising_edge(tx_clk)) then
      case tx_state is
        when WAIT_FOR_LINK =>
          if(link_detected = '1') then
            tx_state <= SEND_PAYLOAD_LOW;
            byte_pos <= 0;
            leds <= "01111110";
          end if;
        
        when SEND_PAYLOAD_LOW =>
          tx_en <= '1';

          tx_data <= payload((byte_pos * 8) + 4 to (byte_pos * 8) + 7);
          tx_state <= SEND_PAYLOAD_HIGH;

        when SEND_PAYLOAD_HIGH =>
          byte_pos <= byte_pos + 1;
          tx_data <= payload((byte_pos * 8) to (byte_pos * 8) + 3);
          tx_state <= SEND_PAYLOAD_LOW;

          if(byte_pos = (payload'length - 8) / 8) then
            byte_pos <= 0;
            tx_state <= STALL;
          end if;

        when STALL =>
          tx_en <= '0';
          stall_counter <= stall_counter + 1;

          if(stall_counter = 16 - 1) then
            stall_counter <= 0;
            tx_state <= SEND_PAYLOAD_LOW;
          end if;


      end case;
    end if;
  end process;

  process(smi_clk, rst)
  begin
    if(rst = '1') then
      link_detected <= '0';
      smi_rd_en <= '0';
      smi_state <= IDLE;
      smi_counter <= 0;
      smi_wr_en <= '0';
    elsif(rising_edge(smi_clk)) then
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
            smi_state <= IDLE;
            link_detected <= smi_data_out(2);
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
    base_clk => clk,
    base_clk_copy => clk_100mhz,
    smi_clk => smi_clk,
    smi_clk_ce => eth_reset_complete
  ); 

  Inst_smi_ramlike: smi_ramlike PORT MAP(
    clk => smi_clk,
    rst => rst,
    mdio => mdio,
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

