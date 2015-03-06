library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fft_unscaled is
  generic ( idx_width : positive := 9;
            out_width : positive := 18 );
  port ( clk : in std_logic;
         rst : in std_logic;
         re_in : in std_logic_vector(7 downto 0);
         re_out : out std_logic_vector(out_width - 1 downto 0);
         im_out : out std_logic_vector(out_width - 1 downto 0);
         index_out : out std_logic_vector(idx_width - 1 downto 0);
         start : in std_logic;
         rfd : out std_logic;
         busy : out std_logic;
         done : out std_logic;
         unload : in std_logic;
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
      xn_im => (others => '0'),
      fwd_inv => '1',
      fwd_inv_we => '1',
      rfd => rfd,
      xn_index => open,
      busy => busy,
      edone => open,
      done => done,
      dv => dv,
      unload => unload,
      xk_index => index_out,
      xk_re => re_out,
      xk_im => im_out
    );
end behave;
