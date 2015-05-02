library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ethernet_wrapper is
  generic ( dest_mac : std_logic_vector(47 downto 0) := x"ffffffffffff";
            src_mac : std_logic_vector(47 downto 0) := x"010203040506";
            protocol : std_logic_vector(15 downto 0) := x"0800"
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
end ethernet_wrapper;

architecture behave of ethernet_wrapper is
 
  signal buffer_rd_en : std_logic;
  signal buffer_data_count : std_logic_vector(10 downto 0);
  signal buffer_data_out : std_logic_vector(data_out'range);
  COMPONENT ethernet_buffer
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
  signal header_pos : integer range 0 to 13;
  signal last_wr_en_val : std_logic;


  type state_t is (WAIT_FOR_SEND, SEND_HEADER, SEND_PAYLOAD, SEND_CRC);
  signal state : state_t;

  signal last_data_in_val : std_logic_vector(data_in'range);

  function crc32(initial_value : std_logic_vector(31 downto 0); data : std_logic_vector; is_last : std_logic) return std_logic_vector is
    variable crc : std_logic_vector(31 downto 0) := x"FFFFFFFF";
    variable temp : std_logic_vector(31 downto 0) := x"00000000";
  begin
    --for i in 0 to 7 loop
    --  temp(31-i) := data(i);
    --end loop;

    temp(31) := data(0);
    temp(30) := data(1);
    temp(29) := data(2);
    temp(28) := data(3);
    temp(27) := data(4);
    temp(26) := data(5);
    temp(25) := data(6);
    temp(24) := data(7);


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

  function calculate_starting_crc(src : std_logic_vector(src_mac'range); dst : std_logic_vector(dest_mac'range); proto : std_logic_vector(protocol'range)) return std_logic_vector is
    variable t : std_logic_vector(31 downto 0);
    variable x : std_logic_vector(7 downto 0);
  begin
    t := x"ffffffff";
    
    x := dst(47 downto 40);
    t := crc32(t, x, '0');
    x := dst(39 downto 32);
    t := crc32(t, x, '0');
    x := dst(31 downto 24);
    t := crc32(t, x, '0');
    x := dst(23 downto 16);
    t := crc32(t, x, '0');
    x := dst(15 downto 8);
    t := crc32(t, x, '0');
    x := dst(7 downto 0);
    t := crc32(t, x, '0');


    x := src(47 downto 40);
    t := crc32(t, x, '0');
    x := src(39 downto 32);
    t := crc32(t, x, '0');
    x := src(31 downto 24);
    t := crc32(t, x, '0');
    x := src(23 downto 16);
    t := crc32(t, x, '0');
    x := src(15 downto 8);
    t := crc32(t, x, '0');
    x := src(7 downto 0);
    t := crc32(t, x, '0');


    x := proto(15 downto 8);
    t := crc32(t, x, '0');
    x := proto(7 downto 0);
    t := crc32(t, x, '0');

    return t;
  end calculate_starting_crc;

  constant starting_crc : std_logic_vector(31 downto 0) := calculate_starting_crc(src_mac, dest_mac, protocol);
  signal latched_crc, running_crc : std_logic_vector(starting_crc'range);

	function reverse_any_vector (a: in std_logic_vector)
	return std_logic_vector is
		variable result: std_logic_vector(a'RANGE);
		alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
	begin
		for i in aa'RANGE loop
			result(i) := aa(i);
		end loop;
		return result;
	end; -- function reverse_any_vector
begin

  process(clk, rst)
  begin
    if(rst = '1') then
      latched_crc <= starting_crc;
      running_crc <= starting_crc;
			payload_pos <= (others => '0');
			state <= WAIT_FOR_SEND;
			dropped_frame <= '0';
			last_wr_en_val <= '0';
			buffer_rd_en <= '0';
			data_valid <= '0';
			last_data_in_val <= (others => '0');
			busy <= '0';
			data_out <= (others => '0');
    elsif(rising_edge(clk)) then
      
      last_wr_en_val <= wr_en;
      dropped_frame <= '0';
      last_data_in_val <= data_in;

      if(wr_en = '1') then
        running_crc <= crc32(running_crc, data_in, '0');
      elsif(wr_en = '0' and last_wr_en_val = '1') then
        if(state /= WAIT_FOR_SEND) then
          dropped_frame <= '1';
        else
          latched_crc <= reverse_any_vector(not running_crc);
          running_crc <= starting_crc;
          state <= SEND_HEADER;
          busy <= '1';
          payload_pos <= unsigned('0' & buffer_data_count) + 1;
        end if;
      end if;

      case state is
        when WAIT_FOR_SEND =>
          null;
        
        when SEND_HEADER =>
					data_valid <= '1';
					header_pos <= header_pos + 1;
          case header_pos is
            when 0 =>
              data_out <= dest_mac(47 downto 40);
            when 1 =>
              data_out <= dest_mac(39 downto 32);
            when 2 =>
              data_out <= dest_mac(31 downto 24);
            when 3 =>
              data_out <= dest_mac(23 downto 16);
            when 4 =>
              data_out <= dest_mac(15 downto 8);
            when 5 =>
              data_out <= dest_mac(7 downto 0);

            when 6 =>
              data_out <= src_mac(47 downto 40);
            when 7 =>
              data_out <= src_mac(39 downto 32);
            when 8 =>
              data_out <= src_mac(31 downto 24);
            when 9 =>
              data_out <= src_mac(23 downto 16);
            when 10 =>
              data_out <= src_mac(15 downto 8);
            when 11 =>
              data_out <= src_mac(7 downto 0);

            when 12 =>
              data_out <= protocol(15 downto 8);
							buffer_rd_en <= '1';
            when 13 =>
              data_out <= protocol(7 downto 0);
              state <= SEND_PAYLOAD;
							header_pos <= 0;
            when others =>
              null;
          end case;

        when SEND_PAYLOAD =>
          payload_pos <= payload_pos - 1;
          data_out <= buffer_data_out;

          if(payload_pos = 1) then
            payload_pos <= (others => '0');
            state <= SEND_CRC;
            buffer_rd_en <= '0';
          end if;

				when SEND_CRC =>
					header_pos <= header_pos + 1;

					case header_pos is
						when 0 =>
							data_out <= latched_crc(31 downto 24);
						when 1 =>
							data_out <= latched_crc(23 downto 16);
						when 2 =>
							data_out <= latched_crc(15 downto 8);
						when 3 =>
							data_out <= latched_crc(7 downto 0);
						when 4 =>
							data_valid <= '0';
							busy <= '0';
							header_pos <= 0;
							data_out <= (others => '0');
							state <= WAIT_FOR_SEND;

						when others => 
							null;
					end case;
      end case;
    end if;
  end process;

  buffer_inst : ethernet_buffer
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
