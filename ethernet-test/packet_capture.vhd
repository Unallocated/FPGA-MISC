library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity packet_capture is
  port ( clk : in std_logic;
         rst : in std_logic;
         eth_rst_n : out std_logic;
         tx_en : out std_logic;
         tx_data : out std_logic_vector(3 downto 0);
         tx_clk : in std_logic;
         tx_er : out std_logic;
         mdio : inout std_logic;
         mdc : out std_logic;
         adc_clk : out std_logic;
         adc_data : in std_logic_vector(7 downto 0);
         leds : out std_logic_vector(7 downto 0);
         sine_out : out std_logic_vector(7 downto 0);
         sine_inc : in std_logic_vector(7 downto 0)
  );
end packet_capture;

architecture behave of packet_capture is
 
  signal original_clk, smi_clk, adc_clk_b : std_logic;
  component packet_capture_dcm
  PORT (
    CLK_IN1           : in     std_logic;
    original_clk          : out    std_logic;
    smi_clk_CE       : in     std_logic;
    smi_clk          : out    std_logic;
    adc_clk_CE       : in     std_logic;
    adc_clk          : out    std_logic
   );
  end component;

  signal eth_reset_complete, eth_link_established : std_logic;
  constant eth_reset_counter_max : positive := 100_000_000;
  signal eth_reset_counter : integer range 0 to eth_reset_counter_max;
  
  type smi_state_t is (IDLE, START_READ, END_READ, WAIT_FOR_DONE);
  signal smi_state : smi_state_t;
  constant smi_counter_max : positive := 100;
  signal smi_counter : integer range 0 to smi_counter_max;

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
 
  signal fifo_wr_en, fifo_rd_en : std_logic;
  signal fifo_dout : std_logic_vector(3 downto 0);
  signal fifo_din : std_logic_vector(adc_data'range);
  signal fifo_empty, fifo_full, fifo_prog_full, last_fifo_prog_full : std_logic;
  COMPONENT packet_capture_fifo
    PORT (
      rst : IN STD_LOGIC;
      wr_clk : IN STD_LOGIC;
      rd_clk : IN STD_LOGIC;
      din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en : IN STD_LOGIC;
      rd_en : IN STD_LOGIC;
      dout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      full : OUT STD_LOGIC;
      empty : OUT STD_LOGIC;
      prog_full : OUT STD_LOGIC
    );
  END COMPONENT;

  signal sine_out_buffer : std_logic_vector(7 downto 0);
  COMPONENT sine_gen
    PORT (
      clk : IN STD_LOGIC;
      pinc_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

  type eth_tx_state_t is (WAIT_FOR_FIFO_FULL, SEND_PREAMBLE, SEND_HEADER, SEND_DATA, SEND_CRC, PACKET_GAP);
  signal eth_tx_state : eth_tx_state_t;
  
  constant eth_source_mac : std_logic_vector(0 to (6 * 8) - 1) := x"000102030405";
  constant eth_dest_mac : std_logic_vector(0 to (6 * 8) - 1) := x"ffffffffffff";
  constant eth_protocol_id : std_logic_vector(0 to (2 * 8) - 1) := x"0800";

  constant eth_preamble : std_logic_vector(0 to (9 * 8) - 1) := x"55_55_55_55_55_55_55_55_5D";
  constant eth_header : std_logic_vector(0 to (14 * 8) - 1) := eth_dest_mac & eth_source_mac & eth_protocol_id;
  constant eth_payload_size_bytes : positive := 60;
  
  signal eth_tx_counter : integer range 0 to (eth_payload_size_bytes * 2);
  signal pattern : std_logic_vector(31 downto 0);
  
  function crc32(initial_value : std_logic_vector(31 downto 0); data : std_logic_vector(7 downto 0); is_last : std_logic) return std_logic_vector is
    variable crc : std_logic_vector(31 downto 0) := x"FFFFFFFF";
    variable temp : std_logic_vector(31 downto 0) := x"00000000";
  begin
    for i in 0 to 7 loop
      temp(31-i) := data(i);
    end loop;

    crc := initial_value;

    for i in 0 to 7 loop

      if(((temp xor crc) and x"80000000") = x"80000000") then
        crc := (crc(30 downto 0) & '0') xor x"04C11DB7";
      else
        crc := crc(30 downto 0) & '0';
      end if;

      temp := temp(30 downto 0) & '0';

    end loop;

    if(is_last = '1') then
      for i in 31 downto 0 loop
        temp(i) := not crc(31 - i);
      end loop;

      return temp;
    else
      return crc;
    end if;
  end crc32;

  signal crc : std_logic_vector(31 downto 0);
  signal is_first_nibble : std_logic;
  signal last_nibble : std_logic_vector(3 downto 0);
begin


  tx_er <= '0';
  --leds <= smi_wr_en & smi_rd_en & smi_done & smi_working & smi_rdy & "010";
  leds <= fifo_prog_full & fifo_full & fifo_empty & tx_clk & "1" & smi_done & eth_reset_complete & eth_link_established;
  adc_clk <= adc_clk_b;
  mdc <= smi_clk;

  process(adc_clk_b, rst)
    variable counter : unsigned(7 downto 0);
    variable nibble : std_logic;
  begin
    if(rst = '1') then
      fifo_din <= (others => '0');
      counter := (others => '0');
      nibble := '0';
      pattern <= x"11223344";
    elsif(rising_edge(adc_clk_b)) then
      sine_out <= std_logic_vector(unsigned(sine_out_buffer) + 128);
      if(fifo_empty = '1' and fifo_full = '1') then
        null;
      else
        fifo_din <= adc_data(3 downto 0) & adc_data(7 downto 4);
        --fifo_din <= x"a6";
        --fifo_din <= std_logic_vector(counter(3 downto 0)) & std_logic_vector(counter(7 downto 4));
        counter := counter + 1;
      end if;
    end if;
  end process;

  process(tx_clk, rst)
  begin
    if(rst = '1') then
      eth_tx_state <= WAIT_FOR_FIFO_FULL;
      eth_tx_counter <= 0;
      tx_en <= '0';
      tx_data <= (others => '0');
      fifo_rd_en <= '0';
      crc <= (others => '1');
      is_first_nibble <= '1';
      last_nibble <= (others => '0');
    elsif(rising_edge(tx_clk)) then
      case eth_tx_state is
        when WAIT_FOR_FIFO_FULL =>
          tx_en <= '0';
          tx_data <= (others => '0');
          if(fifo_prog_full = '1') then
            eth_tx_state <= SEND_PREAMBLE;
            eth_tx_counter <= 0;
          end if;
        when SEND_PREAMBLE =>
          tx_en <= '1';
          eth_tx_counter <= eth_tx_counter + 4;
          tx_data <= eth_preamble((eth_tx_counter) to (eth_tx_counter) + 3);

          if(eth_tx_counter = eth_preamble'high - 3) then
            eth_tx_state <= SEND_HEADER;
            eth_tx_counter <= 0;
            crc <= (others => '1');
            is_first_nibble <= '1';
          end if;
        when SEND_HEADER =>
          is_first_nibble <= not is_first_nibble;
          eth_tx_counter <= eth_tx_counter + 4;
          tx_data <= eth_header((eth_tx_counter) to (eth_tx_counter) + 3);
  
          if(is_first_nibble = '1') then
            last_nibble <= eth_header((eth_tx_counter) to (eth_tx_counter) + 3);
          else
            crc <= crc32(crc, eth_header((eth_tx_counter) to (eth_tx_counter) + 3) & last_nibble, '0');
          end if;
           
          if(eth_tx_counter = eth_header'high - 3) then
            eth_tx_state <= SEND_DATA;
            eth_tx_counter <= 0;
            fifo_rd_en <= '1';
          end if;
        when SEND_DATA =>
          --fifo_rd_en <= '1';
          is_first_nibble <= not is_first_nibble;       
          tx_data <= fifo_dout;
          eth_tx_counter <= eth_tx_counter + 1;
          
          if(eth_tx_counter = (eth_payload_size_bytes * 2) - 1) then
            fifo_rd_en <= '0';
            crc <= crc32(crc, fifo_dout & last_nibble, '1');
          --elsif(eth_tx_counter = (eth_payload_size_bytes * 2)) then
          --  fifo_rd_en <= '0';
            eth_tx_state <= SEND_CRC;
            eth_tx_counter <= 0;
          else
            if(is_first_nibble = '1') then
              last_nibble <= fifo_dout;
            else
              crc <= crc32(crc, fifo_dout & last_nibble, '0');
            end if;
          end if;

        when SEND_CRC =>
          eth_tx_counter <= eth_tx_counter + 1;
          
          case eth_tx_counter is
            when 7 =>
              tx_data <= crc(31 downto 28);
              eth_tx_state <= PACKET_GAP;
            when 6 =>
              tx_data <= crc(27 downto 24);
            when 5 =>
              tx_data <= crc(23 downto 20);
            when 4 =>
              tx_data <= crc(19 downto 16);
            when 3 =>
              tx_data <= crc(15 downto 12);
            when 2 =>
              tx_data <= crc(11 downto 8);
            when 1 =>
              tx_data <= crc(7 downto 4);
            when 0 =>
              tx_data <= crc(3 downto 0);
            when others =>
              eth_tx_state <= PACKET_GAP;
          end case;
              --tx_data <= crc(31 downto 28);
              --tx_data <= crc(27 downto 24);
              --tx_data <= crc(23 downto 20);
              --tx_data <= crc(19 downto 16);
              --tx_data <= crc(15 downto 12);
              --tx_data <= crc(11 downto 8);
              --tx_data <= crc(7 downto 4);
              --tx_data <= crc(3 downto 0);
              


          --tx_data <= crc(31 - eth_tx_counter downto 31 - eth_tx_counter - 3);
          --if(eth_tx_counter = 28) then
          --  eth_tx_state <= PACKET_GAP;
          --end if;
        when PACKET_GAP =>
          tx_en <= '0';
          eth_tx_counter <= eth_tx_counter + 1;
          if(eth_tx_counter = 100) then
            eth_tx_counter <= 0;
            eth_tx_state <= WAIT_FOR_FIFO_FULL;
          end if;
      end case;
    end if;
  end process;

  process(smi_clk, rst)
  begin
    if(rst = '1') then
      eth_link_established <= '0';
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
            if(smi_counter = smi_counter_max) then
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
            eth_link_established <= smi_data_out(2);
          end if;
      end case;
    end if;
  end process;

  process(original_clk, rst)
  begin
    if(rst = '1') then
      eth_reset_complete <= '0';
      eth_rst_n <= '0';
      eth_reset_counter <= 0;
    elsif(rising_edge(original_clk)) then
      eth_rst_n <= '0';
      eth_reset_complete <= '0';

      if(eth_reset_counter = eth_reset_counter_max) then
        eth_rst_n <= '1';
        eth_reset_complete <= '1';
      else
        eth_reset_counter <= eth_reset_counter + 1;
      end if;
    end if;
  end process;

  fifo_inst : packet_capture_fifo
  PORT MAP (
    rst => rst,
    wr_clk => adc_clk_b,
    rd_clk => tx_clk,
    din => fifo_din,
    wr_en => eth_link_established,
    rd_en => fifo_rd_en,
    dout => fifo_dout,
    full => fifo_full,
    empty => fifo_empty,
    prog_full => fifo_prog_full
  );

  Inst_smi_ramlike: smi_ramlike PORT MAP(
    clk => smi_clk,
    rst => rst,
    mdio => mdio,
    rd_en => smi_rd_en,
    wr_en => smi_wr_en,
    addr => "0001",
    data_in => (others => '0'),
    data_out => smi_data_out,
    working => smi_working,
    done => smi_done,
    rdy => smi_rdy
  );


  dcm_inst : packet_capture_dcm
  port map (
    CLK_IN1 => clk,
    original_clk => original_clk,
    smi_clk_CE => eth_reset_complete,
    smi_clk => smi_clk,
    adc_clk_CE => eth_link_established,
    adc_clk => adc_clk_b);

  sine_gen_inst : sine_gen
    PORT MAP (
      clk => adc_clk_b,
      pinc_in => sine_inc,
      sine => sine_out_buffer
    );

end behave;
