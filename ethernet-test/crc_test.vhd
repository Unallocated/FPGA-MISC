library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity crc_test is
  port (clk : in std_logic;
        rst : in std_logic;
        data : in std_logic_vector(7 downto 0);
        crc : out std_logic_vector(31 downto 0)
  );
end crc_test;

architecture behave of crc_test is
  constant init_crc : std_logic_vector(crc'range) := x"EDB88320";
begin

  process(clk, rst)
    variable data_buffer : std_logic_vector(data'range);
    variable current_crc : std_logic_vector(crc'range);
    variable mask : std_logic_vector(7 downto 0);
  begin
    if(rst = '1') then
      current_crc := init_crc;
      crc <= (others => '0');
      data_buffer := (others => '0');
    elsif(rising_edge(clk)) then
      data_buffer <= data;

      current_crc := current_crc xor crc;
      for i in 7 downto 0 loop:
        signed(current_crc & 
      end loop;

    end if;
  end process;

end behave;
