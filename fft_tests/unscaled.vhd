library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.frame_types.all;

entity unscaled is
  port (
    clk : in std_logic;
    rst : in std_logic;

    red : out std_logic_vector(2 downto 0);
    green : out std_logic_vector(2 downto 0);
    blue : out std_logic_vector(1 downto 0);

    hs : out std_logic;
    vs : out std_logic;

    sine_out : out std_logic_vector(7 downto 0);

    adc_in : in std_logic_vector(7 downto 0);
    adc_clk : out std_logic;

    rx : in std_logic
  );
end unscaled;

architecture behave of unscaled is

  signal uart_frame : frame_t;
  signal uart_frame_valid, last_uart_frame_valid : std_logic;
  COMPONENT uart_comms
    GENERIC(
      baud_rate : natural := 500_000;
      clk_rate  : natural := 100_000_000
    );
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      rx : IN std_logic;          
      frame : OUT frame_t;
      frame_valid : OUT std_logic
    );
  END COMPONENT;

  signal vga_blue_in : std_logic_vector(1 downto 0);
  signal vga_red_in, vga_green_in : std_logic_vector(2 downto 0);
  signal vga_v_blanking, vga_h_blanking : std_logic;
  signal vga_x_pos, vga_y_pos : integer;
  COMPONENT vga_configurable
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      blue_in : IN std_logic_vector(1 downto 0);
      red_in : IN std_logic_vector(2 downto 0);
      green_in : IN std_logic_vector(2 downto 0);          
      hs : OUT std_logic;
      vs : OUT std_logic;
      green : OUT std_logic_vector(2 downto 0);
      red : OUT std_logic_vector(2 downto 0);
      blue : OUT std_logic_vector(1 downto 0);
      v_blanking : OUT std_logic;
      h_blanking : OUT std_logic;
      x_pos : OUT integer;
      y_pos : OUT integer
    );
  END COMPONENT;

  signal fft_start, fft_unload, fft_busy, fft_done, fft_dv, fft_rfd : std_logic;
  signal fft_re_in : std_logic_vector(adc_in'range);
  signal fft_re_out, fft_im_out : std_logic_vector(17 downto 0);
  signal fft_index_out : std_logic_vector(8 downto 0);
  COMPONENT fft_unscaled
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      re_in : IN std_logic_vector(7 downto 0);
      start : IN std_logic;
      unload : IN std_logic;          
      re_out : OUT std_logic_vector(17 downto 0);
      im_out : OUT std_logic_vector(17 downto 0);
      index_out : OUT std_logic_vector(8 downto 0);
      rfd : OUT std_logic;
      busy : OUT std_logic;
      done : OUT std_logic;
      dv : OUT std_logic
    );
  END COMPONENT;

  signal mag_val : std_logic_vector(18 downto 0);
  signal mag_idx : std_logic_vector(8 downto 0);
  signal mag_dv : std_logic;
  COMPONENT unscaled_mag
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      re : IN std_logic_vector(17 downto 0);
      im : IN std_logic_vector(17 downto 0);
      idx : IN std_logic_vector(8 downto 0);
      dv : IN std_logic;          
      mag_val : OUT std_logic_vector(18 downto 0);
      mag_idx : OUT std_logic_vector(8 downto 0);
      mag_dv : OUT std_logic
    );
  END COMPONENT;

  signal scaler_factor : std_logic_vector(9 downto 0);
  signal scaler_out : std_logic_vector(7 downto 0);
  signal scaler_dv : std_logic;
  signal scaler_output_index : std_logic_vector(8 downto 0);
  COMPONENT scaler
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      input_val : IN std_logic_vector(18 downto 0);
      input_dv : IN std_logic;
      input_index : IN std_logic_vector(8 downto 0);
      scale_factor : IN std_logic_vector(9 downto 0);          
      output_val : OUT std_logic_vector(7 downto 0);
      output_index : OUT std_logic_vector(8 downto 0);
      output_dv : OUT std_logic
    );
  END COMPONENT;

  signal avg_factor : std_logic_vector(7 downto 0);
  signal avg_out : std_logic_vector(7 downto 0);
  signal avg_idx : std_logic_vector(8 downto 0);
  signal avg_dv : std_logic;
  COMPONENT averaging
    PORT(
      clk : IN std_logic;
      rst : IN std_logic;
      a : IN std_logic_vector(7 downto 0);
      mag_in : IN std_logic_vector(7 downto 0);
      mag_idx : IN std_logic_vector(8 downto 0);
      mag_valid : IN std_logic;          
      avg_out : OUT std_logic_vector(7 downto 0);
      avg_idx : OUT std_logic_vector(8 downto 0);
      avg_valid : OUT std_logic
      );
  END COMPONENT;
  
  signal result_fifo_din, result_fifo_dout : std_logic_vector(16 downto 0);
  signal result_fifo_full, result_fifo_empty, result_fifo_rd_en : std_logic;
  signal result_fifo_data_count : std_logic_vector(8 downto 0);
  COMPONENT result_fifo
    PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      din : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
      wr_en : IN STD_LOGIC;
      rd_en : IN STD_LOGIC;
      dout : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);
      full : OUT STD_LOGIC;
      empty : OUT STD_LOGIC;
      data_count : OUT STD_LOGIC_VECTOR(8 downto 0)
    );
  END COMPONENT;

  signal vga_ram_addra, vga_ram_addrb : std_logic_vector(8 downto 0);
  signal vga_ram_dina, vga_ram_doutb : std_logic_vector(7 downto 0);
  signal vga_ram_wea : std_logic_vector(0 downto 0);
  COMPONENT vga_ram
    PORT (
      clka : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      clkb : IN STD_LOGIC;
      addrb : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

  signal sine_pinc : std_logic_vector(15 downto 0);
  COMPONENT sine_gen
    PORT (
      clk : IN STD_LOGIC;
      pinc_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      sine : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;
 
  signal buffered_clk, vga_clk, fft_clk : std_logic;
  COMPONENT dcm
    PORT (
      clk_in_100mhz : in std_logic;
      clk_buffered : out std_logic;
      vga_clk : out std_logic;
      fft_clk : out std_logic
    );
  END COMPONENT;

  signal adc_in_buffer : std_logic_vector(adc_in'range);
  signal last_vga_v_blanking : std_logic;
  signal reset_countdown : integer;
  signal adc_in_offset : unsigned(7 downto 0);

  type result_fifo_state_t is (WAITING_FOR_FULL, WAITING_FOR_BLANKING, WAITING_FOR_EMPTY);
  signal result_fifo_state : result_fifo_state_t;
begin
  fft_re_in <= adc_in;
  adc_clk <= fft_clk;
  vga_ram_addra <= result_fifo_dout(8 downto 0);
  vga_ram_dina <= result_fifo_dout(16 downto 9);

  process(buffered_clk, rst)
  begin
    if(rst = '1') then
      last_uart_frame_valid <= '0';
      scaler_factor <= "0010000000";
      avg_factor <= "10000000";
      adc_in_offset <= (others => '0');
      sine_pinc <= x"00FF";
    elsif(rising_edge(buffered_clk)) then
      last_uart_frame_valid <= uart_frame_valid;

      if(last_uart_frame_valid = '0' and uart_frame_valid = '1') then
        case uart_frame(3) is
          when x"00" =>
            sine_pinc <= uart_frame(4) & uart_frame(5);
          when x"06" =>
            scaler_factor <= uart_frame(4)(1 downto 0) & uart_frame(5);
          when x"03" =>
            avg_factor <= uart_frame(4);
          when x"04" =>
            adc_in_offset <= unsigned(uart_frame(4));
          when others =>
            null;
        end case;
      end if;
    end if;
  end process;

  process(vga_clk, rst)
  begin
    if(rst = '1') then
      vga_blue_in <= (others => '0');
      vga_ram_addrb <= (others => '0');
      vga_green_in <= (others => '0');
      vga_red_in <= (others => '0');
    elsif(rising_edge(vga_clk)) then
      vga_blue_in <= (others => '0');

      if(vga_v_blanking = '0' and vga_h_blanking = '0' and vga_y_pos < 256 and vga_x_pos < 512) then
        vga_ram_addrb <= std_logic_vector(to_unsigned(vga_x_pos, 9));
        
        if(255 - unsigned(vga_ram_doutb) <= to_unsigned(vga_y_pos, 8)) then
          vga_blue_in <= (others => '1');
        end if;
      end if;
    end if;
  end process;

  process(fft_clk, rst)
  begin
    if(rst = '1') then
      result_fifo_state <= WAITING_FOR_FULL;
      result_fifo_rd_en <= '0';
      --vga_ram_dina <= (others => '0');
      --vga_ram_addra <= (others => '0');
      vga_ram_wea <= (others => '0');
    elsif(rising_edge(fft_clk)) then
      --vga_ram_dina <= result_fifo_dout(7 downto 0);
      --vga_ram_addra <= result_fifo_dout(16 downto 8);
      case result_fifo_state is
        when WAITING_FOR_FULL =>
          result_fifo_rd_en <= '0';
          if(result_fifo_full = '1' and result_fifo_empty = '0') then
            result_fifo_state <= WAITING_FOR_BLANKING;
          end if;
        when WAITING_FOR_BLANKING =>
          if(last_vga_v_blanking = '0' and vga_v_blanking = '1') then
            result_fifo_rd_en <= '1';
            vga_ram_wea <= (others => '1');
            result_fifo_state <= WAITING_FOR_EMPTY;
          end if;
        when WAITING_FOR_EMPTY =>
          if(result_fifo_empty = '1') then
            result_fifo_rd_en <= '0';
            vga_ram_wea <= (others => '0');
            result_fifo_state <= WAITING_FOR_FULL;
          end if;
      end case;
    end if;
  end process;

  process(fft_clk, rst)
  begin
    if(rst = '1') then
      fft_start <= '0';
      result_fifo_din <= (others => '0');
      fft_unload <= '0';
      last_vga_v_blanking <= '0';
      reset_countdown <= 3_000;
    elsif(rising_edge(fft_clk)) then
      if(reset_countdown /= 0) then
        reset_countdown <= reset_countdown - 1;
        if(reset_countdown = 1) then
          fft_start <= '1';
        end if;
      else
        fft_unload <= '0';
        last_vga_v_blanking <= vga_v_blanking;
        result_fifo_din <= avg_out & avg_idx;

        adc_in_buffer <= std_logic_vector(unsigned(adc_in) + adc_in_offset);

        if(fft_done = '1') then
          fft_start <= '0';
          fft_unload <= '1';
        end if;

        if(last_vga_v_blanking = '1' and vga_v_blanking = '0') then
          fft_start <= '1';
        end if;

      end if;
    end if;
  end process;

  Inst_uart_comms: uart_comms 
    PORT MAP(
      clk => buffered_clk,
      rst => rst,
      rx => rx,
      frame => uart_frame,
      frame_valid => uart_frame_valid
    );

  vga_ram_inst : vga_ram
    PORT MAP (
      clka => fft_clk,
      wea => vga_ram_wea,
      addra => vga_ram_addra,
      dina => vga_ram_dina,
      clkb => vga_clk,
      addrb => vga_ram_addrb,
      doutb => vga_ram_doutb
    );

  result_fifo_inst : result_fifo
    PORT MAP (
      clk => fft_clk,
      rst => rst,
      din => result_fifo_din,
      wr_en => avg_dv,
      rd_en => result_fifo_rd_en,
      dout => result_fifo_dout,
      full => result_fifo_full,
      empty => result_fifo_empty,
      data_count => result_fifo_data_count
    );

  averaging_inst : averaging PORT MAP(
      clk => fft_clk,
      rst => rst,
      a => avg_factor,
      mag_in => scaler_out,
      mag_idx => scaler_output_index,
      mag_valid => scaler_dv,
      avg_out => avg_out,
      avg_idx => avg_idx,
      avg_valid => avg_dv
    );

  scaler_inst : scaler 
    PORT MAP (
      clk => fft_clk,
      rst => rst,
      input_val => mag_val,
      input_index => mag_idx,
      output_val => scaler_out,
      output_dv => scaler_dv,
      output_index => scaler_output_index,
      input_dv => mag_dv,
      scale_factor => scaler_factor
    );

  unscaled_mag_inst : unscaled_mag 
    PORT MAP (
      clk => fft_clk,
      rst => rst,
      re => fft_re_out,
      im => fft_im_out,
      idx => fft_index_out,
      dv => fft_dv,
      mag_val => mag_val,
      mag_idx => mag_idx,
      mag_dv => mag_dv
    );

  vga_configurable_inst : vga_configurable 
    PORT MAP (
      clk => vga_clk,
      rst => rst,
      hs => hs,
      vs => vs,
      green => green,
      red => red,
      blue => blue,
      v_blanking => vga_v_blanking,
      h_blanking => vga_h_blanking,
      x_pos => vga_x_pos,
      y_pos => vga_y_pos,
      blue_in => vga_blue_in,
      red_in => vga_red_in,
      green_in => vga_green_in
    );

  Inst_fft_unscaled: fft_unscaled 
    PORT MAP (
      clk => fft_clk,
      rst => rst,
      re_in => adc_in_buffer,
      re_out => fft_re_out,
      im_out => fft_im_out,
      index_out => fft_index_out,
      start => fft_start,
      rfd => fft_rfd,
      busy => fft_busy,
      done => fft_done,
      unload => fft_unload,
      dv => fft_dv
    );

  sine_gen_inst : sine_gen
    PORT MAP (
      clk => fft_clk,
      pinc_in => sine_pinc,
      sine => sine_out
    );

  dcm_inst : dcm
    PORT MAP (
      clk_in_100mhz => clk,
      clk_buffered => buffered_clk,
      vga_clk => vga_clk,
      fft_clk => fft_clk
    );

end behave;
