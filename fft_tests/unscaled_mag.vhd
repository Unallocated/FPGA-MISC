library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unscaled_mag is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           re : in  STD_LOGIC_VECTOR (17 downto 0);
           im : in  STD_LOGIC_VECTOR (17 downto 0);
           idx : in  STD_LOGIC_VECTOR (8 downto 0);
           dv : in STD_LOGIC;
           mag_val : out  STD_LOGIC_VECTOR (18 downto 0);
           mag_idx : out  STD_LOGIC_VECTOR (8 downto 0);
           mag_dv : out  STD_LOGIC);
end unscaled_mag;

architecture Behavioral of unscaled_mag is

  constant mult_delay : integer := 2;
  constant add_delay : integer := 2;
  constant sqrt_delay : integer := 11;

  constant total_delay : integer := mult_delay + add_delay + sqrt_delay - 1;


  signal re_buf, im_buf : std_logic_vector(re'range);
  signal idx_buf : std_logic_vector(idx'range);
  signal dv_buf : std_logic;

  signal idx_out_buf : std_logic_vector(mag_idx'range);
  signal dv_out_buf : std_logic;
  signal val_out_buf : std_logic_vector(mag_val'range);

  type dv_pipeline_t is array(0 to total_delay) of std_logic;
  type idx_pipeline_t is array(0 to total_delay) of std_logic_vector(idx'range);

  signal dv_pipeline : dv_pipeline_t;
  signal idx_pipeline : idx_pipeline_t;

  signal mult_p_re, mult_p_im : std_logic_vector(35 downto 0);
  COMPONENT unscaled_multiplier
    PORT (
      clk : IN STD_LOGIC;
      a : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
      b : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
      p : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
    );
  END COMPONENT;

  signal adder_out : std_logic_vector(35 downto 0);
  COMPONENT unscaled_adder
    PORT (
      a : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
      b : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
      clk : IN STD_LOGIC;
      ce : IN STD_LOGIC;
      s : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
    );
  END COMPONENT;
  
  signal sqrt_out : std_logic_vector(18 downto 0);
  COMPONENT unscaled_sqrt
    PORT (
      x_in : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
      x_out : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
      clk : IN STD_LOGIC;
      sclr : IN STD_LOGIC
    );
  END COMPONENT;
begin

  process(clk, rst)
  begin
    if(rst = '1') then
      dv_pipeline <= (others => '0');
      idx_buf <= (others => '0');
      dv_buf <= '0';
      re_buf <= (others => '0');
      im_buf <= (others => '0');

      idx_pipeline <= (others => (others => '0'));

      idx_out_buf <= (others => '0');
      dv_out_buf <= '0';
      val_out_buf <= (others => '0');

      mag_val <= (others => '0');
      mag_dv <= '0';
      mag_idx <= (others => '0');

    elsif(rising_edge(clk)) then
      re_buf <= re;
      im_buf <= im;
      idx_buf <= idx;
      dv_buf <= dv;

      dv_pipeline <= dv_buf & dv_pipeline(0 to dv_pipeline'length - 2);
      idx_pipeline <= idx_buf & idx_pipeline(0 to idx_pipeline'length - 2);

      dv_out_buf <= dv_pipeline(dv_pipeline'length - 1);
      idx_out_buf <= idx_pipeline(idx_pipeline'length - 1);
      val_out_buf <= sqrt_out;

      mag_val <= val_out_buf;
      mag_dv <= dv_out_buf;
      mag_idx <= idx_out_buf;
    end if;
  end process;
  
  re_mult : unscaled_multiplier
  PORT MAP (
    clk => clk,
    a => re_buf,
    b => re_buf,
    p => mult_p_re
  );

  im_mult : unscaled_multiplier
  PORT MAP (
    clk => clk,
    a => im_buf,
    b => im_buf,
    p => mult_p_im
  );

  adder : unscaled_adder
  PORT MAP (
    a => mult_p_re,
    b => mult_p_im,
    clk => clk,
    ce => '1',
    s => adder_out
  );

  sqrt : unscaled_sqrt
  PORT MAP (
    x_in => adder_out,
    x_out => sqrt_out,
    clk => clk,
    sclr => rst
  );
end Behavioral;

