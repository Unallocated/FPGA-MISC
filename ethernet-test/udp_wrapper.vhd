library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity udp_wrapper is
  generic ( dest_port : std_logic_vector(15 downto 0) := x"8000";
            src_port : std_logic_vector(15 downto 0) := x"8000"
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
end udp_wrapper;

architecture behave of udp_wrapper is
 
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

  signal d_pos_buffer : std_logic_vector(10 downto 0);
  signal payload_pos : unsigned(d_pos_buffer'length downto 0);
  signal header_pos : integer range 0 to 7;
  signal last_wr_en_val : std_logic;


  type state_t is (WAIT_FOR_SEND, SEND_HEADER, SEND_PAYLOAD);
  signal state : state_t;

  signal is_first_byte : std_logic;
  signal last_data_in_val : std_logic_vector(data_in'range);
  signal running_checksum, latched_checksum : unsigned(15 downto 0);

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
      d_pos_buffer <= (others => '0');
      payload_pos <= (others => '0');
      buffer_rd_en <= '0';
      is_first_byte <= '1';
      last_wr_en_val <= '0';
      running_checksum <= (others => '0');
      latched_checksum <= (others => '0');
      state <= WAIT_FOR_SEND;
      last_data_in_val <= (others => '0');
      dropped_frame <= '0';
      data_valid <= '0';
      data_out <= (others => '0');
    elsif(rising_edge(clk)) then
      last_wr_en_val <= wr_en;
      dropped_frame <= '0';
      
      last_data_in_val <= data_in;

      if(wr_en = '1') then
        is_first_byte <= not is_first_byte;
        if(is_first_byte = '0') then
          running_checksum <= checksum_calc(running_checksum, last_data_in_val & data_in);
        end if;
      elsif(wr_en = '0' and last_wr_en_val = '1') then
        d_pos_buffer <= buffer_data_count;
        payload_pos <= unsigned('0' & buffer_data_count) + 1;
        running_checksum <= (others => '0');
        
        if(is_first_byte = '0') then
          latched_checksum <= checksum_calc(running_checksum, x"00" & data_in);
        else
          latched_checksum <= running_checksum;
        end if;
        is_first_byte <= '1';
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
              data_out <= src_port(15 downto 8);
            when 1 =>
              data_out <= src_port(7 downto 0);
              latched_checksum <= checksum_calc(latched_checksum, src_port);
            when 2 =>
              data_out <= dest_port(15 downto 8);
            when 3 =>
              data_out <= dest_port(7 downto 0);
              latched_checksum <= checksum_calc(latched_checksum, src_port);
            when 4 =>
              data_out <= "00000" & std_logic_vector(payload_pos(10 downto 8));
            when 5 =>
              data_out <= std_logic_vector(payload_pos(7 downto 0));
              latched_checksum <= checksum_calc(latched_checksum, "00000" & std_logic_vector(payload_pos(payload_pos'high -1 downto 0)));
            when 6 =>
              data_out <= std_logic_vector(latched_checksum(15 downto 8));
              buffer_rd_en <= '1';
            when 7 =>
              data_out <= std_logic_vector(latched_checksum(7 downto 0));
              state <= SEND_PAYLOAD;
            when others =>
              null;
          end case;

        when SEND_PAYLOAD =>
          payload_pos <= payload_pos - 1;
          data_out <= buffer_data_out;

          if(payload_pos = 2) then
            buffer_rd_en <= '0';
          end if;

          if(payload_pos = 0) then
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
