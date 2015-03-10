library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- This is a pipelined scaling module for the FFT magnitudes.  It is required
-- because the output of the FFT is unscaled.  Because of that, there needs to 
-- be some kind of external scaling.  The way this module works is that the 
-- scale_factor input is a fixed point value: 9 downto 8 is the whole number,
-- and 7 downto 0 is the fraction.  So, 0010000000 would be 0.5 as an example.
-- The two bit growth accounts for the two whole number bits of scale_factor.
-- The fraction bits from the multiplication are discarded.
entity scaler is
    Port ( 
           -- Clock input
           clk : in  STD_LOGIC;
           -- Active high reset
           rst : in  STD_LOGIC;
           -- Input that is to be scaled (unsigned)
           input_val : in  STD_LOGIC_VECTOR (18 downto 0);
           -- Output value that has been scaled (unsigned)
           output_val : out  STD_LOGIC_VECTOR (20 downto 0);
           -- Shows that the outputs are valid
           output_dv : out  STD_LOGIC;
           -- Index of the current value (used to tell which sample this is)
           output_index : out STD_LOGIC_VECTOR(8 downto 0);
           -- Specifies that the inputs are valid
           input_dv : in  STD_LOGIC;
           -- Index of the current input value
           input_index : in STD_LOGIC_VECTOR(8 downto 0);
           -- Scaling factor.  9 downto 8 are the whole number, 7 downto 0 are the fraction
           scale_factor : in  STD_LOGIC_VECTOR (9 downto 0));
end scaler;

architecture Behavioral of scaler is
  -- number of cycles it takes for the first input to be valid (depth of the pipeline)
  constant delay : integer := 3;

  -- Type and signal that will be used to buffer the dv signal through the pipeline
  type dv_pipeline_t is array(0 to delay-2) of std_logic;
  signal dv_pipeline : dv_pipeline_t;
  
  -- Type and signal that will be used to buffer the index through the pipeline
  type index_pipeline_t is array(0 to delay-2) of std_logic_vector(input_index'range);
  signal index_pipeline : index_pipeline_t;

  -- IP core multiplier
  COMPONENT scaling_multiplier
    PORT (
      clk : IN STD_LOGIC;
      a : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
      b : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      p : OUT STD_LOGIC_VECTOR(28 DOWNTO 0)
    );
  END COMPONENT;

  -- Latches the dv input
  signal input_dv_buf : std_logic;
  -- Latches the val input
  signal input_val_buf : std_logic_vector(input_val'range);
  -- Latches the index input
  signal input_index_buf : std_logic_vector(input_index'range);
  -- Latches the scale factor input
  signal scale_factor_buf : std_logic_vector(scale_factor'range);
  -- Buffers the output from the multiplier
  signal output_val_buf : std_logic_vector(28 downto 0);
  
begin
  
  -- The main process that handles the pipeline
  process(clk, rst)
  begin
    -- Async reset
    if(rst = '1') then
      -- Resets all of the signals to zeros
      
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
      -- Latch each of the input signals
      input_dv_buf <= input_dv;
      input_val_buf <= input_val;
      scale_factor_buf <= scale_factor;
      input_index_buf <= input_index;

      -- Shift the dv and index pipelines by one position
      dv_pipeline <= input_dv_buf & dv_pipeline(0 to dv_pipeline'length - 2);
      index_pipeline <= input_index_buf & index_pipeline(0 to index_pipeline'length - 2);
      
      -- Set the output index and dv signals to be the last element in their respective pipelines
      output_dv <= dv_pipeline(dv_pipeline'length - 1);
      output_index <= index_pipeline(index_pipeline'length - 1);
      
      -- Set the output value to be the value of the buffered multiplier output
      output_val <= output_val_buf(28 downto 8);
    end if;
  end process;

  -- Instance of the scaling multiplier
  multiplier_inst : scaling_multiplier
    PORT MAP (
      clk => clk,
      a => input_val_buf,
      b => scale_factor_buf,
      p => output_val_buf
    );

end Behavioral;

