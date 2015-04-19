library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture test of tb is
  signal my_crc : std_logic_vector(31 downto 0);

  function crc32(initial_value : std_logic_vector(31 downto 0); data : std_logic_vector(7 downto 0); is_last : std_logic) return std_logic_vector is
    variable crc : std_logic_vector(31 downto 0) := x"FFFFFFFF";
    variable temp : std_logic_vector(31 downto 0) := x"00000000";
  begin
    for i in 0 to 7 loop
      temp(31-i) := data(i);
    end loop;

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


begin

  process
  begin
    wait for 10 ns;
    my_crc <= crc32(x"ffffffff", x"61", '0');
    wait for 10 ns;
    my_crc <= crc32(my_crc, x"62", '0');
    wait for 1 ns;
    my_crc <= crc32(my_crc, x"63", '1');
    wait for 1 ns;
    
    wait;
  end process;

end test;
