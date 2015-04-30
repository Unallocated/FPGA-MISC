library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity udp_wrapper is
  generic ( dest_port : std_logic_vector(15 downto 0);
            src_port : std_logic_vector(15 downto 0)
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
         data_idx : out std_logic_vector(10 downto 0);
         data_valid : out std_logic;
         dropped_frame : out std_logic
       );
end udp_wrapper;

architecture behave of udp_wrapper is
 
  signal buffer_rd_en : std_logic;
  signal buffer_data_count : std_logic_vector(10 downto 0);
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

  signal d_port_buffer, s_port_buffer : std_logic_vector(dest_port'range);
  signal d_pos_buffer : std_logic_vector(10 downto 0);
 
  signal last_wr_en_val : std_logic;


  type state_t is (WAIT_FOR_SEND, SEND_HEADER, SEND_DATA);
  signal state : state_t;

  signal is_first_byte : std_logic;
  signal last_data_in_val : std_logic_vector(data_in'range);
  signal running_checksum, latched_checksum : unsigned(15 downto 0);
begin

  process(clk, rst)
  begin
    if(rst = '1') then
      is_first_byte <= '1';
      last_wr_en_val <= '1';
      running_checksum <= (others => '0');
      latched_checksum <= (others => '0');
      state <= WAIT_FOR_SEND;
      last_data_in_val <= (others => '0');
      dropped_frame <= '0';
    elsif(rising_edge(clk)) then
      last_wr_en_val <= wr_en;
      dropped_frame <= '0';

      if(wr_en = '1') then
        is_first_byte <= not is_first_byte;
        if(is_first_byte = '1') then
          last_data_in_val <= data_in;
        else
          if(unsigned('0' & last_data_in_val & data_in) + unsigned('0' & running_checksum) > 65535) then
            running_checksum <= (unsigned(last_data_in_val & data_in) + running_checksum + 1);
          else
            running_checksum <= (unsigned(last_data_in_val & data_in) + running_checksum);
          end if;
        end if;
      elsif(wr_en = '0' and last_wr_en_val = '1') then
        running_checksum <= (others => '0');
        latched_checksum <= running_checksum;
        is_first_byte <= '1';
        if(state = WAIT_FOR_SEND) then
          state <= SEND_HEADER;
        else
          dropped_frame <= '1';
        end if;
      end if;
      
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
      dout => data_out,
      full => buffer_full,
      empty => buffer_empty,
      data_count => buffer_data_count,
      prog_full => buffer_prog_full
    );

end behave;
