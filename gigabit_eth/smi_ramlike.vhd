library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity smi_ramlike is
  generic ( hw_addr : std_logic_vector(4 downto 0) );
  port ( clk : in std_logic;
         rst : in std_logic;
         mdio : inout std_logic;
         rd_en : in std_logic;
         wr_en : in std_logic;
         addr : in std_logic_vector(4 downto 0);
         data_in : in std_logic_vector(15 downto 0);
         data_out : out std_logic_vector(15 downto 0);
         working : out std_logic;
         done : out std_logic;
         rdy : out std_logic
  );
end smi_ramlike;

architecture behave of smi_ramlike is

  type state_t is (DELAY, IDLE, ONES, SOF, OPCODE, PHY_ADDR, REG_ADDR, STALL, PROCESS_DATA);
  signal state : state_t;

  constant opcode_write : std_logic_vector(1 downto 0) := "10";
  constant opcode_read : std_logic_vector(1 downto 0) := "01";

  signal counter : integer;

  signal last_rd_en, last_wr_en : std_logic;

  signal currently_writing : std_logic;
  signal data_in_buffer, data_out_buffer : std_logic_vector(data_in'range);
  signal addr_buffer : std_logic_vector(addr'range);
begin

  process(clk, rst)
  begin
    if(rst = '1') then
      state <= DELAY;
      counter <= 0;
      working <= '0';
      done <= '0';
      rdy <= '0';
      mdio <= '1';
      data_out_buffer <= (others => '0');
      data_out <= (others => '0');
      data_in_buffer <= (others => '0');
      currently_writing <= '0';
      last_rd_en <= '1';
      last_wr_en <= '1';
      addr_buffer <= (others => '0');
    elsif(rising_edge(clk)) then
      last_rd_en <= rd_en;
      last_wr_en <= wr_en;

      case state is
        when DELAY =>
          rdy <= '0';
          counter <= counter + 1;
          if(counter = 100) then
            counter <= 0;
            state <= IDLE;
          end if;

        when IDLE =>
          rdy <= '1';
          working <= '0';

          if(last_wr_en = '0' and wr_en = '1') then
            currently_writing <= '1';
            state <= ONES;
            working <= '1';
            done <= '0';
            data_in_buffer <= data_in;
            addr_buffer <= addr;
            counter <= 0;
          elsif(last_rd_en = '0' and rd_en = '1') then
            currently_writing <= '0';
            state <= ONES;
            working <= '1';
            done <= '0';
            data_in_buffer <= data_in;
            addr_buffer <= addr;
            counter <= 0;
          end if;

        when ONES =>
          mdio <= '1';
          counter <= counter + 1;
          if(counter = 31) then
            state <= SOF;
            counter <= 0;
          end if;

        when SOF =>
          counter <= counter + 1;
          if(counter = 0) then
            mdio <= '0';
          else
            mdio <= '1';
            state <= OPCODE;
            counter <= 0;
          end if;

        when OPCODE =>
          counter <= counter + 1;
          if(currently_writing = '1') then
            mdio <= opcode_write(counter);
          else
            mdio <= opcode_read(counter);
          end if;

          if(counter = 1) then
            state <= PHY_ADDR;
            counter <= 0;
          end if;

        when PHY_ADDR =>
          counter <= counter + 1;
          
          mdio <= hw_addr(counter);
          
          if(counter = 4) then
            counter <= 0;
            state <= REG_ADDR;
          end if;

        when REG_ADDR =>
          counter <= counter + 1;

          --if(counter = 0) then
          --  mdio <= '0';
          --else
            mdio <= addr_buffer(counter);
          --end if;

          if(counter = 4) then
            state <= STALL;
            counter <= 0;
          end if;

        when STALL =>
          counter <= counter + 1;

          if(counter = 2) then
            state <= PROCESS_DATA;
            counter <= 0;
            mdio <= 'Z';
          end if;
        
        when PROCESS_DATA =>
          counter <= counter + 1;

          if(counter < 16) then
            if(currently_writing = '1') then
              mdio <= data_in_buffer(data_in_buffer'high - counter);
            else
              data_out_buffer(data_out_buffer'high - counter) <= mdio;
            end if;
          end if;

          if(counter = 16) then
            if(currently_writing = '0') then
              data_out <= data_out_buffer;
            end if;

            done <= '1';
            working <= '0';
            mdio <= '1';
            state <= IDLE;
          end if;

      end case;
    end if;
  end process;

end behave;
