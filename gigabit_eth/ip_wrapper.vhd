library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ip_wrapper is
  generic ( src_ip : std_logic_vector(31 downto 0) := x"0a0a0a0a";
            dest_ip : std_logic_vector(31 downto 0) := x"ffffffff";
            ttl : std_logic_vector(7 downto 0) := x"ff";
            protocol : std_logic_vector(7 downto 0) := x"11"
  );
  port ( clk : in std_logic;
         rst : in std_logic;
         data_in : in std_logic_vector(7 downto 0);
         wr_en : in std_logic;
         busy : out std_logic;
         buffer_full : out std_logic;
         buffer_empty : out std_logic;
         buffer_prog_full : out std_logic;
         buffer_prog_full_val : in std_logic_vector(10 downto 0);
         data_out : out std_logic_vector(7 downto 0);
         data_valid : out std_logic;
         dropped_frame : out std_logic
       );
end ip_wrapper;

architecture behave of ip_wrapper is
 
  signal buffer_rd_en : std_logic;
  signal buffer_data_count : std_logic_vector(10 downto 0);
  signal buffer_data_out : std_logic_vector(data_out'range);
  COMPONENT udp_buffer
    PORT (
      rst : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en : IN STD_LOGIC;
      rd_en : IN STD_LOGIC;
      prog_full_thresh : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full : OUT STD_LOGIC;
      empty : OUT STD_LOGIC;
      data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
      prog_full : OUT STD_LOGIC
    );
  END COMPONENT;

  signal payload_pos : unsigned(11 downto 0);
  signal actual_length : std_logic_vector(15 downto 0);
  signal header_pos : integer range 0 to 19;
  signal last_wr_en_val : std_logic;


  type state_t is (WAIT_FOR_SEND, SEND_HEADER, SEND_PAYLOAD);
  signal state : state_t;

  signal latched_checksum : unsigned(15 downto 0);

  function checksum_calc (current_checksum : unsigned; new_data : std_logic_vector) return unsigned is
  begin
    if(unsigned('0' & new_data) + unsigned('0' & current_checksum) > 65535) then
      return (unsigned(new_data) + current_checksum + 1);
    else
      return (unsigned(new_data) + current_checksum);
    end if;
  end checksum_calc;

begin

  process(clk, rst)
  begin
    if(rst = '1') then
      busy <= '0';
      payload_pos <= (others => '0');
      buffer_rd_en <= '0';
      last_wr_en_val <= '0';
      state <= WAIT_FOR_SEND;
      dropped_frame <= '0';
      data_valid <= '0';
      data_out <= (others => '0');
      latched_checksum <= (others => '0');
      actual_length <= (others => '0');
    elsif(rising_edge(clk)) then
      last_wr_en_val <= wr_en;
      dropped_frame <= '0';
      
      if(wr_en = '0' and last_wr_en_val = '1') then
        payload_pos <= unsigned('0' & buffer_data_count) + 1;
        actual_length <= std_logic_vector(unsigned("00000" & buffer_data_count) + 20);
        if(state = WAIT_FOR_SEND) then
          state <= SEND_HEADER;
          busy <= '1';
        else
          dropped_frame <= '1';
        end if;
      end if;
      
      case state is
        when WAIT_FOR_SEND =>
          data_out <= (others => '0');
          data_valid <= '0';
          header_pos <= 0;

        when SEND_HEADER =>
          data_valid <= '1';
          header_pos <= header_pos + 1;

          case header_pos is
            when 0 =>
              -- Version and IHL
              data_out <= x"45";
              -- First part of source IP
              latched_checksum <= checksum_calc(to_unsigned(0, 16), src_ip(31 downto 16));
            when 1 =>
              -- DSCP and ECN
              data_out <= x"00";
              latched_checksum <= checksum_calc(latched_checksum, x"4500");
            when 2 =>
              -- Total length 1
              data_out <= actual_length(15 downto 8);
              -- Second part of source IP
              latched_checksum <= checksum_calc(latched_checksum, src_ip(15 downto 0));
            when 3 =>
              -- Total length 2
              data_out <= actual_length(7 downto 0);
              latched_checksum <= checksum_calc(latched_checksum, actual_length);
            when 4 =>
              -- ID 1
              data_out <= x"00";
              -- First part of dest IP
              latched_checksum <= checksum_calc(latched_checksum, dest_ip(31 downto 16));
            when 5 =>
              -- ID 2
              data_out <= x"00";
              latched_checksum <= checksum_calc(latched_checksum, x"0000");
            when 6 =>
              -- Flags and first part of fragment offset
              data_out <= x"00";
              -- Second part of dest IP
              latched_checksum <= checksum_calc(latched_checksum, dest_ip(15 downto 0));
            when 7 =>
              -- Second part of fragment offset
              data_out <= x"00";
              latched_checksum <= checksum_calc(latched_checksum, x"0000");
            when 8 =>
              -- TTL
              data_out <= ttl;
            when 9 =>
              -- Protocol
              data_out <= protocol;
              latched_checksum <= not checksum_calc(latched_checksum, ttl & protocol);
            when 10 =>
              -- Checksum 1
              data_out <= std_logic_vector(latched_checksum(15 downto 8));
            when 11 =>
              -- Checksum 2
              data_out <= std_logic_vector(latched_checksum(7 downto 0));
            when 12 =>
              data_out <= src_ip(31 downto 24);
            when 13 =>
              data_out <= src_ip(23 downto 16);
            when 14 =>
              data_out <= src_ip(15 downto 8);
            when 15 =>
              data_out <= src_ip(7 downto 0);
            when 16 =>
              data_out <= dest_ip(31 downto 24);
            when 17 =>
              data_out <= dest_ip(23 downto 16);
            when 18 =>
              data_out <= dest_ip(15 downto 8);
              buffer_rd_en <= '1';
            when 19 =>
              data_out <= dest_ip(7 downto 0);
              state <= SEND_PAYLOAD;
            when others =>
              null;
          end case;

        when SEND_PAYLOAD =>
          payload_pos <= payload_pos - 1;
          data_out <= buffer_data_out;

          if(payload_pos = 3) then
            buffer_rd_en <= '0';
          end if;

          if(payload_pos = 1) then
            payload_pos <= (others => '0');
            state <= WAIT_FOR_SEND;
            buffer_rd_en <= '0';
            busy <= '0';
            data_valid <= '0';
            data_out <= (others => '0');
          end if;
      end case;
    end if;
  end process;

  buffer_inst : udp_buffer
    PORT MAP (
      rst => rst,
      clk => clk,
      din => data_in,
      wr_en => wr_en,
      rd_en => buffer_rd_en,
      prog_full_thresh => buffer_prog_full_val,
      dout => buffer_data_out,
      full => buffer_full,
      empty => buffer_empty,
      data_count => buffer_data_count,
      prog_full => buffer_prog_full
    );

end behave;
