library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity usrp_like is
  generic ( eth_width : positive;
            eth_source : std_logic_vector((6 * 8) - 1 downto 0);
            eth_dest : std_logic_vector((6 * 8) - 1 downto 0);
            ip_source : std_logic_vector((4 * 8) - 1 downto 0);
            ip_dest : std_logic_vector((4 * 8) - 1 downto 0);
            udp_source : std_logic_vector((2 * 8) - 1 downto 0);
            udp_dest : std_logic_vector((2 * 8) - 1 downto 0);
            payload_size : positive range 1 to 1400;
            reset_pause_cycles : positive);
  port ( clk : in std_logic;
         rst : in std_logic;
         eth_rst_n : out std_logic;
         eth_tx_data : out std_logic_vector(eth_width-1 downto 0);
         eth_tx_en : out std_logic;
         eth_tx_er : out std_logic;
         eth_tx_clk : in std_logic;
         eth_link_established : in std_logic;
         eth_rst_complete : out std_logic;
         data_in : in std_logic_vector(7 downto 0);
         wr_en : in std_logic;
         wr_clk : in std_logic;
         buffer_full : out std_logic;
         buffer_empty : out std_logic);
end usrp_like;

architecture behave of usrp_like is
  function crc32(initial_value : std_logic_vector(31 downto 0); data_asdf : std_logic_vector; is_last : std_logic) return std_logic_vector is
    variable crc : std_logic_vector(31 downto 0) := x"FFFFFFFF";
    variable temp : std_logic_vector(31 downto 0) := x"00000000";
  begin
    temp(31) := data_asdf(0);
    temp(30) := data_asdf(1);
    temp(29) := data_asdf(2);
    temp(28) := data_asdf(3);
    temp(27) := data_asdf(4);
    temp(26) := data_asdf(5);
    temp(25) := data_asdf(6);
    temp(24) := data_asdf(7);
    --for i in 0 to 7 loop
    --  temp(31-i) := data_asdf(i);
    --end loop;

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

  function nibbleReverse(data : in std_logic_vector((50 * 8) - 1 downto 0)) return std_logic_vector is
    variable temp : std_logic_vector(data'range) := (others => '0');
    variable pos : integer range 0 to data'length := data'high;
  begin
    for i in (data'length/8) - 1 downto 0 loop
      temp(pos downto pos-3) := data(pos-4 downto pos-7);
      temp(pos-4 downto pos-7) := data(pos downto pos-3);
      if(pos > 8) then
        pos := pos - 8;
      end if;
    end loop;

    return temp;
  end nibbleReverse;

  function calculateIPChecksum(data : in std_logic_vector(159 downto 0)) return std_logic_vector is
    variable temp : unsigned(31 downto 0) := (others => '0');
    variable cs : std_logic_vector(31 downto 0) := (others => '0');
  begin
    temp := unsigned(x"0000" & data(159 downto 144)) + 
            unsigned(x"0000" & data(143 downto 128)) + 
            unsigned(x"0000" & data(127 downto 112)) + 
            unsigned(x"0000" & data(111 downto 96)) + 
            unsigned(x"0000" & data(95 downto 80)) + 
            unsigned(x"0000" & data(79 downto 64)) + 
            unsigned(x"0000" & data(63 downto 48)) + 
            unsigned(x"0000" & data(47 downto 32)) + 
            unsigned(x"0000" & data(31 downto 16)) + 
            unsigned(x"0000" & data(15 downto 0));

    cs := not std_logic_vector((x"0000" & temp(15 downto 0)) + temp(30 downto 16));
    return cs(15 downto 0);
  end calculateIPChecksum;

  function buildIPHeader(data : in std_logic_vector(159 downto 0)) return std_logic_vector is
    variable temp : std_logic_vector(data'range);
  begin
    temp := data;
    temp(79 downto 64) := calculateIPChecksum(data);

    return temp;
  end buildIPHeader;

  function neededBits (max : integer) return integer is
    variable vec : integer := integer(ceil(log2(real(max) + 1.0)));
  begin
    return vec;
  end neededBits;

  constant eth_header_preamble : std_logic_vector((8 * 8) - 1 downto 0) := x"55_55_55_55_55_55_55_D5";
  constant eth_link_type       : std_logic_vector(15 downto 0) := x"0800";
  constant eth_header          : std_logic_vector((eth_header_preamble'length + eth_dest'length + eth_source'length + eth_link_type'length) - 1 downto 0) := eth_header_preamble & eth_dest & eth_source & eth_link_type; 
  constant ip_header           : std_logic_vector((20 * 8) - 1 downto 0) := buildIPHeader(x"45_00" & std_logic_vector(to_unsigned(payload_size + 20 + 8, 16)) & x"0000_0000_FF_11_0000" & ip_source & ip_dest);
  constant udp_header          : std_logic_vector((8 * 8) - 1 downto 0) := udp_source & udp_dest & std_logic_vector(to_unsigned(payload_size + 8, 16)) & x"0000";
  constant packet_header       : std_logic_vector((eth_header'length + ip_header'length + udp_header'length) - 1 downto 0) := nibbleReverse(eth_header & ip_header & udp_header);

  signal buffer_rd_en, buffer_prog_full : std_logic;
  signal buffer_dout : std_logic_vector(3 downto 0);
  signal buffer_din : std_logic_vector(7 downto 0);
  COMPONENT usrp_like_buffer
    PORT (
      rst : IN STD_LOGIC;
      wr_clk : IN STD_LOGIC;
      rd_clk : IN STD_LOGIC;
      din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en : IN STD_LOGIC;
      rd_en : IN STD_LOGIC;
      prog_full_thresh : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
      dout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      full : OUT STD_LOGIC;
      empty : OUT STD_LOGIC;
      prog_full : OUT STD_LOGIC
    );
  END COMPONENT;

  type reset_state_t is (RESET_COUNT, RESET_COMPLETE);
  signal reset_state : reset_state_t;
  
  signal reset_counter : unsigned(neededBits(reset_pause_cycles-1) - 1 downto 0);
  signal eth_reset_complete : std_logic;

  signal packet_header_data_position : unsigned(neededBits(packet_header'length) - 1 downto 0);
  signal payload_data_position : unsigned(neededBits(payload_size * 2) - 1 downto 0);
  
  type eth_transmit_state_t is (WAIT_FOR_DATA, SEND_HEADERS, SEND_PAYLOAD, SEND_ETH_CRC, PACKET_GAP);
  signal eth_transmit_state : eth_transmit_state_t;

  signal eth_crc : std_logic_vector(31 downto 0);
  signal eth_crc_is_first_nibble : std_logic;
  signal eth_crc_position : unsigned(neededBits(eth_crc'length/4) - 1 downto 0);
  signal eth_crc_last_nibble : std_logic_vector(3 downto 0);

  signal eth_packet_gap_counter : unsigned(neededBits(100) - 1 downto 0);
begin
  buffer_din <= data_in(3 downto 0) & data_in(7 downto 4);
  eth_rst_complete <= eth_reset_complete;

  process(eth_tx_clk, rst)
    variable byte_holder : std_logic_vector(7 downto 0);
  begin
    if(rst = '1') then
      eth_transmit_state <= WAIT_FOR_DATA;
      eth_tx_data <= (others => '0');
      eth_tx_en <= '0';
      eth_tx_er <= '0';
      buffer_rd_en <= '0';
      packet_header_data_position <= (others => '0');
      eth_crc_is_first_nibble <= '1';
      eth_crc <=  (others => '1');
      eth_crc_last_nibble <= (others => '0');
      eth_crc_position <= (others => '0');
      eth_packet_gap_counter <= (others => '0');
    elsif(rising_edge(eth_tx_clk)) then
      if(eth_reset_complete = '1' and eth_link_established = '1') then
        case eth_transmit_state is
          when WAIT_FOR_DATA =>
            eth_tx_en <= '0';
            eth_tx_data <= (others => '0');

            if(buffer_prog_full = '1') then
              eth_transmit_state <= SEND_HEADERS;
              packet_header_data_position <= to_unsigned(packet_header'high, packet_header_data_position'length);
              eth_crc <= (others => '1');              
            end if;
          
          when SEND_HEADERS =>
            eth_tx_en <= '1';
            packet_header_data_position <= packet_header_data_position - 4;
            eth_tx_data <= packet_header(to_integer(packet_header_data_position) downto to_integer(packet_header_data_position - 3));

            if(packet_header_data_position < packet_header'length - eth_header_preamble'high) then
              if(eth_crc_is_first_nibble = '1') then
                eth_crc_last_nibble <= packet_header(to_integer(packet_header_data_position) downto to_integer(packet_header_data_position - 3));
              else
                byte_holder(7 downto 4) := packet_header(to_integer(packet_header_data_position) downto to_integer(packet_header_data_position - 3));
                byte_holder(3 downto 0) := eth_crc_last_nibble;
                eth_crc <= crc32(eth_crc, byte_holder, '0');
                --eth_crc <= crc32(eth_crc, packet_header(to_integer(packet_header_data_position) downto to_integer(packet_header_data_position - 3)) & eth_crc_last_nibble, '0');
              end if;

              eth_crc_is_first_nibble <= not eth_crc_is_first_nibble;
            end if;

            if(packet_header_data_position = 3) then
              buffer_rd_en <= '1';
            end if;

            if(packet_header_data_position = 3) then
              eth_transmit_state <= SEND_PAYLOAD;
              packet_header_data_position <= (others => '0');
              payload_data_position <= (others => '0');
            end if;
          when SEND_PAYLOAD =>
            eth_crc_is_first_nibble <= not eth_crc_is_first_nibble;
            payload_data_position <= payload_data_position + 1;
            eth_tx_data <= buffer_dout;

            if(payload_data_position = (payload_size * 2) - 1) then
              buffer_rd_en <= '0';
              eth_transmit_state <= SEND_ETH_CRC;
              payload_data_position <= (others => '0');
              eth_crc <= crc32(eth_crc, buffer_dout & eth_crc_last_nibble, '1');
              eth_crc_position <= (others => '0');
            else
              if(eth_crc_is_first_nibble = '1') then
                eth_crc_last_nibble <= buffer_dout;
              else
                eth_crc <= crc32(eth_crc, buffer_dout & eth_crc_last_nibble, '0');
              end if;
            end if;

          when SEND_ETH_CRC =>
            eth_crc_position <= eth_crc_position + 1;
            
            case to_integer(eth_crc_position) is
              when 7 =>
                eth_tx_data <= eth_crc(31 downto 28);
                eth_transmit_state <= PACKET_GAP;
                eth_crc_position <= (others => '0');
                eth_packet_gap_counter <= (others => '0');
              when 6 =>
                eth_tx_data <= eth_crc(27 downto 24);
              when 5 =>
                eth_tx_data <= eth_crc(23 downto 20);
              when 4 =>
                eth_tx_data <= eth_crc(19 downto 16);
              when 3 =>
                eth_tx_data <= eth_crc(15 downto 12);
              when 2 =>
                eth_tx_data <= eth_crc(11 downto 8);
              when 1 =>
                eth_tx_data <= eth_crc(7 downto 4);
              when 0 =>
                eth_tx_data <= eth_crc(3 downto 0);
              when others =>
                eth_transmit_state <= PACKET_GAP;
            end case;


          when PACKET_GAP =>
            eth_tx_en <= '0';
            eth_packet_gap_counter <= eth_packet_gap_counter + 1;

            if(eth_packet_gap_counter = 100) then
              eth_packet_gap_counter <= (others => '0');
              eth_transmit_state <= WAIT_FOR_DATA;
            end if;

        end case;
            
      end if;
    end if;
  end process;

  -- The ethernet reset line needs to be held low for a minimum
  -- period of time.  This time is specify at instantiation time
  -- by a generic parameter 'reset_pause_cycles'.  The wait is 
  -- actually one cycle past that value since 0 counts.  No biggie.
  -- While there is a minimum period of time to wait, there is no max.
  process(clk, rst)
  begin
    if(rst = '1') then

      reset_counter <= (others => '0');
      eth_rst_n <= '0';
      eth_reset_complete <= '0';
      reset_state <= RESET_COUNT;

    elsif(rising_edge(clk)) then

      case reset_state is

        when RESET_COUNT =>
          reset_counter <= reset_counter + 1;
          eth_rst_n <= '0';
          eth_reset_complete <= '0';
          if(reset_counter = reset_pause_cycles) then
            reset_state <= RESET_COMPLETE;
            reset_counter <= (others => '0');
          end if;

        when RESET_COMPLETE =>
          eth_rst_n <= '1';
          eth_reset_complete <= '1';

      end case;

    end if;
  end process;


  -- FIFO that will hold data until it's time to transmit.  
  data_buffer_inst : usrp_like_buffer
    PORT MAP (
      rst => rst,
      wr_clk => wr_clk,
      rd_clk => eth_tx_clk,
      din => buffer_din,
      wr_en => wr_en,
      rd_en => buffer_rd_en,
      prog_full_thresh => std_logic_vector(to_unsigned(payload_size,14)),
      dout => buffer_dout,
      full => buffer_full,
      empty => buffer_empty,
      prog_full => buffer_prog_full
    );

  
end behave;
