library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Wraps a Xilinx FFT block to only expose the required signals
-- Nothing really special happens here other than some signal re-naming
-- and the fact that the imaginary inputs are tied to zero.
entity fft_unscaled is
  generic ( 
            -- Log2(fftWidth)
            idx_width : positive := 9;
            -- Width of the real and imaginary outputs from the FFT
            out_width : positive := 18 );
  port ( 
         -- FFT clock
         clk : in std_logic;
         -- Active high reset
         rst : in std_logic;
         -- Real samples in
         re_in : in std_logic_vector(7 downto 0);
         -- Real output
         re_out : out std_logic_vector(out_width - 1 downto 0);
         -- Imaginary input
         im_out : out std_logic_vector(out_width - 1 downto 0);
         -- Index of the output
         index_out : out std_logic_vector(idx_width - 1 downto 0);
         -- Signal to start the FFT
         start : in std_logic;
         -- Used to tell that the FFT is collecting samples
         rfd : out std_logic;
         -- Used to tell that the FFT is busy calculating the input samples
         busy : out std_logic;
         -- Used to tell that the FFT is done calculating and ready to unload data
         done : out std_logic;
         -- Tells the FFT to unload the calculated values
         unload : in std_logic;
         -- Used to tell that the FFT outputs are valid
         dv : out std_logic
  );
end fft_unscaled;

architecture behave of fft_unscaled is

  COMPONENT fft_unscaled_512
    PORT (
      clk : IN STD_LOGIC;
      sclr : IN STD_LOGIC;
      start : IN STD_LOGIC;
      xn_re : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      xn_im : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      fwd_inv : IN STD_LOGIC;
      fwd_inv_we : IN STD_LOGIC;
      rfd : OUT STD_LOGIC;
      xn_index : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
      busy : OUT STD_LOGIC;
      edone : OUT STD_LOGIC;
      done : OUT STD_LOGIC;
      dv : OUT STD_LOGIC;
      unload : IN STD_LOGIC;
      xk_index : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
      xk_re : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
      xk_im : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
    );
  END COMPONENT;

begin

  fft_inst : fft_unscaled_512
    PORT MAP (
      clk => clk,
      sclr => rst,
      start => start,
      xn_re => re_in,
      -- This is a real only FFT, so imaginary inputs are tied to zero
      xn_im => (others => '0'),
      -- Always do a forward FFT
      fwd_inv => '1',
      -- Makes sure that the FFT type is assigned
      fwd_inv_we => '1',
      rfd => rfd,
      -- No need for the input index
      xn_index => open,
      busy => busy,
      -- This is the 'pre-done' signal and will not be needed
      edone => open,
      done => done,
      dv => dv,
      unload => unload,
      xk_index => index_out,
      xk_re => re_out,
      xk_im => im_out
    );
end behave;
