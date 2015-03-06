library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity scaler is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           input_val : in  STD_LOGIC_VECTOR (18 downto 0);
           output_val : out  STD_LOGIC_VECTOR (7 downto 0);
           output_dv : out  STD_LOGIC;
           output_index : out STD_LOGIC_VECTOR(8 downto 0);
           input_dv : in  STD_LOGIC;
           input_index : in STD_LOGIC_VECTOR(8 downto 0);
           scale_factor : in  STD_LOGIC_VECTOR (9 downto 0));
end scaler;

architecture Behavioral of scaler is

  constant delay : integer := 3;

  type dv_pipeline_t is array(0 to delay-2) of std_logic;
  signal dv_pipeline : dv_pipeline_t;
  
  type index_pipeline_t is array(0 to delay-2) of std_logic_vector(input_index'range);
  signal index_pipeline : index_pipeline_t;

  COMPONENT scaling_multiplier
    PORT (
      clk : IN STD_LOGIC;
      a : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
      b : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      p : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

  signal input_dv_buf : std_logic;
  signal input_val_buf : std_logic_vector(input_val'range);
  signal input_index_buf : std_logic_vector(input_index'range);
  signal output_val_buf : std_logic_vector(output_val'range);
  signal scale_factor_buf : std_logic_vector(scale_factor'range);
begin

  process(clk, rst)
  begin
    if(rst = '1') then
      dv_pipeline <= (others => '0');

      input_dv_buf <= '0';
      input_val_buf <= (others => '0');
      input_index_buf <= (others => '0');
      scale_factor_buf <= (others => '0');

      dv_pipeline <= (others => '0');
      index_pipeline <= (others => (others => '0'));

      output_dv <= '0';
      output_val <= (others => '0');
      output_index <= (others => '0');
    elsif(rising_edge(clk)) then
      input_dv_buf <= input_dv;
      input_val_buf <= input_val;
      scale_factor_buf <= scale_factor;
      input_index_buf <= input_index;

      dv_pipeline <= input_dv_buf & dv_pipeline(0 to dv_pipeline'length - 2);
      index_pipeline <= input_index_buf & index_pipeline(0 to index_pipeline'length - 2);
      
      output_dv <= dv_pipeline(dv_pipeline'length - 1);
      output_val <= output_val_buf;
      output_index <= index_pipeline(index_pipeline'length - 1);
    end if;
  end process;

  your_instance_name : scaling_multiplier
    PORT MAP (
      clk => clk,
      a => input_val_buf,
      b => scale_factor_buf,
      p => output_val_buf
    );

end Behavioral;

