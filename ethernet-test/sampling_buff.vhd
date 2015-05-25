library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity sampling_buff is
  Generic ( frame_size : positive := 1000 );
  Port ( wr_clk : in  STD_LOGIC;
         rst : in  STD_LOGIC;
         wr_en : in  STD_LOGIC;
         rd_clk : in  STD_LOGIC;
         dv : out STD_LOGIC;
         ovflo : out STD_LOGIC;
         rdy : out STD_LOGIC;
         data_in : in  STD_LOGIC_VECTOR (7 downto 0);
         data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end sampling_buff;

architecture Behavioral of sampling_buff is

  signal rd_en, full, empty, prog_full : std_logic;
  signal rd_count, wr_count : std_logic_vector(10 downto 0);
  COMPONENT sampling_buffer
    PORT (
      rst : IN STD_LOGIC;
      wr_clk : IN STD_LOGIC;
      rd_clk : IN STD_LOGIC;
      din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en : IN STD_LOGIC;
      rd_en : IN STD_LOGIC;
      prog_full_thresh : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full : OUT STD_LOGIC;
      empty : OUT STD_LOGIC;
      rd_data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
      wr_data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
      prog_full : OUT STD_LOGIC
    );
  END COMPONENT;
  
  type state_t is (RESETTING, WAITING, UNLOADING);
  signal state : state_t;

  signal position : unsigned(integer(floor(log2((real(frame_size) + 1.0)))) downto 0);
begin

  process(rd_clk, rst)
  begin
    if(rst = '1') then
      state <= RESETTING;
      position <= (others => '0');
      rd_en <= '0';
      dv <= '0';
      ovflo <= '0';
      rdy <= '0';
    elsif(rising_edge(rd_clk)) then
      case state is
        when RESETTING =>
          if(full = '0' and empty = '1') then
            state <= WAITING;
            rdy <= '1';
          end if;
        when WAITING =>
          if(prog_full = '1') then
            state <= UNLOADING;
            position <= (others => '0');
            dv <= '1';
            rd_en <= '1';
          end if;
        when UNLOADING =>
          if(full = '1') then
            ovflo <= '1';
          end if;

          position <= position + 1;
          if(position = to_unsigned(frame_size, position'length) - 1) then
            rd_en <= '1';
          end if;

          if(position = to_unsigned(frame_size, position'length)) then
            state <= WAITING;
            rd_en <= '0';
            dv <= '0';
            position <= (others => '0');
          end if;
      end case;
    end if;
  end process;

  sampling_buffer_inst : sampling_buffer
    PORT MAP (
      rst => rst,
      wr_clk => wr_clk,
      rd_clk => rd_clk,
      din => data_in,
      wr_en => wr_en,
      rd_en => rd_en,
      prog_full_thresh => std_logic_vector(to_unsigned(frame_size, 11)),
      dout => data_out,
      full => full,
      empty => empty,
      rd_data_count => rd_count,
      wr_data_count => wr_count,
      prog_full => prog_full
    );

end Behavioral;

