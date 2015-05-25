library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ethernet is
  generic ( data_width : positive := 4);
	port ( clk : in std_logic;
		     rst : in std_logic;
		     --mdio : inout std_logic;
		     --mdc : out std_logic;
		     --int : out std_logic;
		     eth_rst : out std_logic;
		     --collision : in std_logic;
		     --crs : in std_logic;
		     --rx_dv : in std_logic;
		     --rx_clk : in std_logic;
		     --rx_err : in std_logic;
		     --rx_data : in std_logic_vector(data_width-1 downto 0);
		   
		     --gtx_clk : out std_logic;
		     tx_clk : in std_logic;
		     tx_er : out std_logic;
		     tx_en : out std_logic;
		     tx_data : out std_logic_vector(data_width-1 downto 0);

         leds : out std_logic_vector(7 downto 0)
	);
end ethernet;

architecture behave of ethernet is
	
  type state_t is (SEND_HEADER, SEND_PAYLOAD, SEND_CHECKSUM, STALL);
  signal state : state_t;
  signal reset_counter : integer;

  signal ethernet_header : std_logic_vector((14 * 8) - 1 downto 0);
  signal ethernet_header_counter : integer range 0 to ethernet_header'length / 8;
  signal payload : std_logic_vector((256 * 8) - 1 downto 0);

  signal payload_counter : integer range 0 to 256 * 8;
  signal checksum_counter : integer range 0 to 3;
  signal stall_counter : integer range 0 to 100;

  signal ready : std_logic;

	signal original_clk, gigabit_clk, half_original_clk, megabit_clk : std_logic;
	component clocking
		port (
			CLK_IN1 : in  std_logic;
		  orig    : out std_logic;
		  gigabit : out std_logic;
		  half    : out std_logic;
		  megabit : out std_logic
		 );
	end component;
	
begin


  leds(3 downto 0) <= (others => tx_clk);
  tx_er <= '1';
  --mdio <= 'Z';
  --mdc <= '0';

  process(clk, rst)
  begin
    if(rst = '1') then
      ready <= '0';
      eth_rst <= '0';
      reset_counter <= 0;
      leds(7 downto 4) <= "1010";
    elsif(rising_edge(clk)) then
      if(reset_counter = 100_0) then
        ready <= '1';
        eth_rst <= '1';
        leds(7 downto 4) <= "1100";
      else
        eth_rst <= '0';
        ready <= '0';
        reset_counter <= reset_counter + 1;
        leds(7 downto 4) <= "0011";
      end if;
    end if;
  end process;

  process(tx_clk, rst)
  begin
    if(rst = '1') then
      state <= SEND_HEADER;
      tx_en <= '0';
      ethernet_header_counter <= 0;
      ethernet_header <= x"ffffffffffff_000000000000_0800";
      payload_counter <= 0;
      checksum_counter <= 0;
      stall_counter <= 0;
      payload <= x"00_01_02_03_04_05_06_07_08_09_0a_0b_0c_0d_0e_0f_10_11_12_13_14_15_16_17_18_19_1a_1b_1c_1d_1e_1f_20_21_22_23_24_25_26_27_28_29_2a_2b_2c_2d_2e_2f_30_31_32_33_34_35_36_37_38_39_3a_3b_3c_3d_3e_3f_40_41_42_43_44_45_46_47_48_49_4a_4b_4c_4d_4e_4f_50_51_52_53_54_55_56_57_58_59_5a_5b_5c_5d_5e_5f_60_61_62_63_64_65_66_67_68_69_6a_6b_6c_6d_6e_6f_70_71_72_73_74_75_76_77_78_79_7a_7b_7c_7d_7e_7f_80_81_82_83_84_85_86_87_88_89_8a_8b_8c_8d_8e_8f_90_91_92_93_94_95_96_97_98_99_9a_9b_9c_9d_9e_9f_a0_a1_a2_a3_a4_a5_a6_a7_a8_a9_aa_ab_ac_ad_ae_af_b0_b1_b2_b3_b4_b5_b6_b7_b8_b9_ba_bb_bc_bd_be_bf_c0_c1_c2_c3_c4_c5_c6_c7_c8_c9_ca_cb_cc_cd_ce_cf_d0_d1_d2_d3_d4_d5_d6_d7_d8_d9_da_db_dc_dd_de_df_e0_e1_e2_e3_e4_e5_e6_e7_e8_e9_ea_eb_ec_ed_ee_ef_f0_f1_f2_f3_f4_f5_f6_f7_f8_f9_fa_fb_fc_fd_fe_ff";
    elsif(rising_edge(tx_clk)) then
      if(ready = '1') then

        case state is
          when SEND_HEADER =>
            tx_en <= '1';
            tx_data <= ethernet_header(ethernet_header'high downto ethernet_header'high - 3);
            ethernet_header <= ethernet_header(ethernet_header'high - 4 downto 0) & ethernet_header(ethernet_header'high downto ethernet_header'high - 3);

            if(ethernet_header_counter = ethernet_header'length - 4) then
              state <= SEND_PAYLOAD;
              payload_counter <= 0;
            else
              ethernet_header_counter <= ethernet_header_counter + 4;
            end if;
            
          
          when SEND_PAYLOAD =>
            tx_data <= payload(payload_counter + 3 downto payload_counter);
            if(payload_counter = (256 * 8) - 4) then
              state <= SEND_CHECKSUM;
              checksum_counter <= 0;
            else
              payload_counter <= payload_counter + 4;
            end if;

          when SEND_CHECKSUM =>
            checksum_counter <= checksum_counter + 1;
            case checksum_counter is
              when 0 =>
                tx_data <= x"3";
              when 1 =>
                tx_data <= x"b";
              when 2 =>
                tx_data <= x"9";
              when 3 =>
                tx_data <= x"9";
                stall_counter <= 0;
                state <= STALL;
                checksum_counter <= 0;
            end case;

          when STALL =>
            tx_en <= '0';
            if(stall_counter = 100) then
              state <= SEND_HEADER;
              ethernet_header_counter <= 0;
            else
              stall_counter <= stall_counter + 1;
            end if;

        end case;
      end if;
    end if;
  end process;

end behave;
