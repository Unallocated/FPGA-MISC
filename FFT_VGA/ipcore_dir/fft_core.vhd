--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: fft_core.vhd
-- /___/   /\     Timestamp: Mon Dec  2 19:46:58 2013
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -w -sim -ofmt vhdl /root/FPGA-MISC/FFT_VGA/ipcore_dir/tmp/_cg/fft_core.ngc /root/FPGA-MISC/FFT_VGA/ipcore_dir/tmp/_cg/fft_core.vhd 
-- Device	: 6slx16csg324-3
-- Input file	: /root/FPGA-MISC/FFT_VGA/ipcore_dir/tmp/_cg/fft_core.ngc
-- Output file	: /root/FPGA-MISC/FFT_VGA/ipcore_dir/tmp/_cg/fft_core.vhd
-- # of Entities	: 1
-- Design Name	: fft_core
-- Xilinx	: /opt/Xilinx/14.7/ISE_DS/ISE/
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity fft_core is
  port (
    clk : in STD_LOGIC := 'X'; 
    ce : in STD_LOGIC := 'X'; 
    sclr : in STD_LOGIC := 'X'; 
    start : in STD_LOGIC := 'X'; 
    fwd_inv : in STD_LOGIC := 'X'; 
    fwd_inv_we : in STD_LOGIC := 'X'; 
    rfd : out STD_LOGIC; 
    busy : out STD_LOGIC; 
    edone : out STD_LOGIC; 
    done : out STD_LOGIC; 
    dv : out STD_LOGIC; 
    xn_re : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    xn_im : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    xn_index : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    xk_index : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    xk_re : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    xk_im : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    blk_exp : out STD_LOGIC_VECTOR ( 4 downto 0 ) 
  );
end fft_core;

architecture STRUCTURE of fft_core is
  signal NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i : STD_LOGIC; 
  signal U0_i_synth_non_floating_point_arch_e_xfft_inst_control_busy_i_reg2 : STD_LOGIC; 
  signal NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_run_addr_gen_done_int2 : STD_LOGIC; 
  signal U0_i_synth_non_floating_point_arch_e_xfft_inst_control_done_i_reg : STD_LOGIC; 
  signal U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_dv_d : STD_LOGIC; 
  signal sig00000001 : STD_LOGIC; 
  signal sig00000002 : STD_LOGIC; 
  signal sig00000003 : STD_LOGIC; 
  signal sig00000004 : STD_LOGIC; 
  signal sig00000005 : STD_LOGIC; 
  signal sig00000006 : STD_LOGIC; 
  signal sig00000007 : STD_LOGIC; 
  signal sig00000008 : STD_LOGIC; 
  signal sig00000009 : STD_LOGIC; 
  signal sig0000000a : STD_LOGIC; 
  signal sig0000000b : STD_LOGIC; 
  signal sig0000000c : STD_LOGIC; 
  signal sig0000000d : STD_LOGIC; 
  signal sig0000000e : STD_LOGIC; 
  signal sig0000000f : STD_LOGIC; 
  signal sig00000010 : STD_LOGIC; 
  signal sig00000011 : STD_LOGIC; 
  signal sig00000012 : STD_LOGIC; 
  signal sig00000013 : STD_LOGIC; 
  signal sig00000014 : STD_LOGIC; 
  signal sig00000015 : STD_LOGIC; 
  signal sig00000016 : STD_LOGIC; 
  signal sig00000017 : STD_LOGIC; 
  signal sig00000018 : STD_LOGIC; 
  signal sig00000019 : STD_LOGIC; 
  signal sig0000001a : STD_LOGIC; 
  signal sig0000001b : STD_LOGIC; 
  signal sig0000001c : STD_LOGIC; 
  signal sig0000001d : STD_LOGIC; 
  signal sig0000001e : STD_LOGIC; 
  signal sig0000001f : STD_LOGIC; 
  signal sig00000020 : STD_LOGIC; 
  signal sig00000021 : STD_LOGIC; 
  signal sig00000022 : STD_LOGIC; 
  signal sig00000023 : STD_LOGIC; 
  signal sig00000024 : STD_LOGIC; 
  signal sig00000025 : STD_LOGIC; 
  signal sig00000026 : STD_LOGIC; 
  signal sig00000027 : STD_LOGIC; 
  signal sig00000028 : STD_LOGIC; 
  signal sig00000029 : STD_LOGIC; 
  signal sig0000002a : STD_LOGIC; 
  signal sig0000002b : STD_LOGIC; 
  signal sig0000002c : STD_LOGIC; 
  signal sig0000002d : STD_LOGIC; 
  signal sig0000002e : STD_LOGIC; 
  signal sig0000002f : STD_LOGIC; 
  signal sig00000030 : STD_LOGIC; 
  signal sig00000031 : STD_LOGIC; 
  signal sig00000032 : STD_LOGIC; 
  signal sig00000033 : STD_LOGIC; 
  signal sig00000034 : STD_LOGIC; 
  signal sig00000035 : STD_LOGIC; 
  signal sig00000036 : STD_LOGIC; 
  signal sig00000037 : STD_LOGIC; 
  signal sig00000038 : STD_LOGIC; 
  signal sig00000039 : STD_LOGIC; 
  signal sig0000003a : STD_LOGIC; 
  signal sig0000003b : STD_LOGIC; 
  signal sig0000003c : STD_LOGIC; 
  signal sig0000003d : STD_LOGIC; 
  signal sig0000003e : STD_LOGIC; 
  signal sig0000003f : STD_LOGIC; 
  signal sig00000040 : STD_LOGIC; 
  signal sig00000041 : STD_LOGIC; 
  signal sig00000042 : STD_LOGIC; 
  signal sig00000043 : STD_LOGIC; 
  signal sig00000044 : STD_LOGIC; 
  signal sig00000045 : STD_LOGIC; 
  signal sig00000046 : STD_LOGIC; 
  signal sig00000047 : STD_LOGIC; 
  signal sig00000048 : STD_LOGIC; 
  signal sig00000049 : STD_LOGIC; 
  signal sig0000004a : STD_LOGIC; 
  signal sig0000004b : STD_LOGIC; 
  signal sig0000004c : STD_LOGIC; 
  signal sig0000004d : STD_LOGIC; 
  signal sig0000004e : STD_LOGIC; 
  signal sig0000004f : STD_LOGIC; 
  signal sig00000050 : STD_LOGIC; 
  signal sig00000051 : STD_LOGIC; 
  signal sig00000052 : STD_LOGIC; 
  signal sig00000053 : STD_LOGIC; 
  signal sig00000054 : STD_LOGIC; 
  signal sig00000055 : STD_LOGIC; 
  signal sig00000056 : STD_LOGIC; 
  signal sig00000057 : STD_LOGIC; 
  signal sig00000058 : STD_LOGIC; 
  signal sig00000059 : STD_LOGIC; 
  signal sig0000005a : STD_LOGIC; 
  signal sig0000005b : STD_LOGIC; 
  signal sig0000005c : STD_LOGIC; 
  signal sig0000005d : STD_LOGIC; 
  signal sig0000005e : STD_LOGIC; 
  signal sig0000005f : STD_LOGIC; 
  signal sig00000060 : STD_LOGIC; 
  signal sig00000061 : STD_LOGIC; 
  signal sig00000062 : STD_LOGIC; 
  signal sig00000063 : STD_LOGIC; 
  signal sig00000064 : STD_LOGIC; 
  signal sig00000065 : STD_LOGIC; 
  signal sig00000066 : STD_LOGIC; 
  signal sig00000067 : STD_LOGIC; 
  signal sig00000068 : STD_LOGIC; 
  signal sig00000069 : STD_LOGIC; 
  signal sig0000006a : STD_LOGIC; 
  signal sig0000006b : STD_LOGIC; 
  signal sig0000006c : STD_LOGIC; 
  signal sig0000006d : STD_LOGIC; 
  signal sig0000006e : STD_LOGIC; 
  signal sig0000006f : STD_LOGIC; 
  signal sig00000070 : STD_LOGIC; 
  signal sig00000071 : STD_LOGIC; 
  signal sig00000072 : STD_LOGIC; 
  signal sig00000073 : STD_LOGIC; 
  signal sig00000074 : STD_LOGIC; 
  signal sig00000075 : STD_LOGIC; 
  signal sig00000076 : STD_LOGIC; 
  signal sig00000077 : STD_LOGIC; 
  signal sig00000078 : STD_LOGIC; 
  signal sig00000079 : STD_LOGIC; 
  signal sig0000007a : STD_LOGIC; 
  signal sig0000007b : STD_LOGIC; 
  signal sig0000007c : STD_LOGIC; 
  signal sig0000007d : STD_LOGIC; 
  signal sig0000007e : STD_LOGIC; 
  signal sig0000007f : STD_LOGIC; 
  signal sig00000080 : STD_LOGIC; 
  signal sig00000081 : STD_LOGIC; 
  signal sig00000082 : STD_LOGIC; 
  signal sig00000083 : STD_LOGIC; 
  signal sig00000084 : STD_LOGIC; 
  signal sig00000085 : STD_LOGIC; 
  signal sig00000086 : STD_LOGIC; 
  signal sig00000087 : STD_LOGIC; 
  signal sig00000088 : STD_LOGIC; 
  signal sig00000089 : STD_LOGIC; 
  signal sig0000008a : STD_LOGIC; 
  signal sig0000008b : STD_LOGIC; 
  signal sig0000008c : STD_LOGIC; 
  signal sig0000008d : STD_LOGIC; 
  signal sig0000008e : STD_LOGIC; 
  signal sig0000008f : STD_LOGIC; 
  signal sig00000090 : STD_LOGIC; 
  signal sig00000091 : STD_LOGIC; 
  signal sig00000092 : STD_LOGIC; 
  signal sig00000093 : STD_LOGIC; 
  signal sig00000094 : STD_LOGIC; 
  signal sig00000095 : STD_LOGIC; 
  signal sig00000096 : STD_LOGIC; 
  signal sig00000097 : STD_LOGIC; 
  signal sig00000098 : STD_LOGIC; 
  signal sig00000099 : STD_LOGIC; 
  signal sig0000009a : STD_LOGIC; 
  signal sig0000009b : STD_LOGIC; 
  signal sig0000009c : STD_LOGIC; 
  signal sig0000009d : STD_LOGIC; 
  signal sig0000009e : STD_LOGIC; 
  signal sig0000009f : STD_LOGIC; 
  signal sig000000a0 : STD_LOGIC; 
  signal sig000000a1 : STD_LOGIC; 
  signal sig000000a2 : STD_LOGIC; 
  signal sig000000a3 : STD_LOGIC; 
  signal sig000000a4 : STD_LOGIC; 
  signal sig000000a5 : STD_LOGIC; 
  signal sig000000a6 : STD_LOGIC; 
  signal sig000000a7 : STD_LOGIC; 
  signal sig000000a8 : STD_LOGIC; 
  signal sig000000a9 : STD_LOGIC; 
  signal sig000000aa : STD_LOGIC; 
  signal sig000000ab : STD_LOGIC; 
  signal sig000000ac : STD_LOGIC; 
  signal sig000000ad : STD_LOGIC; 
  signal sig000000ae : STD_LOGIC; 
  signal sig000000af : STD_LOGIC; 
  signal sig000000b0 : STD_LOGIC; 
  signal sig000000b1 : STD_LOGIC; 
  signal sig000000b2 : STD_LOGIC; 
  signal sig000000b3 : STD_LOGIC; 
  signal sig000000b4 : STD_LOGIC; 
  signal sig000000b5 : STD_LOGIC; 
  signal sig000000b6 : STD_LOGIC; 
  signal sig000000b7 : STD_LOGIC; 
  signal sig000000b8 : STD_LOGIC; 
  signal sig000000b9 : STD_LOGIC; 
  signal sig000000ba : STD_LOGIC; 
  signal sig000000bb : STD_LOGIC; 
  signal sig000000bc : STD_LOGIC; 
  signal sig000000bd : STD_LOGIC; 
  signal sig000000be : STD_LOGIC; 
  signal sig000000bf : STD_LOGIC; 
  signal sig000000c0 : STD_LOGIC; 
  signal sig000000c1 : STD_LOGIC; 
  signal sig000000c2 : STD_LOGIC; 
  signal sig000000c3 : STD_LOGIC; 
  signal sig000000c4 : STD_LOGIC; 
  signal sig000000c5 : STD_LOGIC; 
  signal sig000000c6 : STD_LOGIC; 
  signal sig000000c7 : STD_LOGIC; 
  signal sig000000c8 : STD_LOGIC; 
  signal sig000000c9 : STD_LOGIC; 
  signal sig000000ca : STD_LOGIC; 
  signal sig000000cb : STD_LOGIC; 
  signal sig000000cc : STD_LOGIC; 
  signal sig000000cd : STD_LOGIC; 
  signal sig000000ce : STD_LOGIC; 
  signal sig000000cf : STD_LOGIC; 
  signal sig000000d0 : STD_LOGIC; 
  signal sig000000d1 : STD_LOGIC; 
  signal sig000000d2 : STD_LOGIC; 
  signal sig000000d3 : STD_LOGIC; 
  signal sig000000d4 : STD_LOGIC; 
  signal sig000000d5 : STD_LOGIC; 
  signal sig000000d6 : STD_LOGIC; 
  signal sig000000d7 : STD_LOGIC; 
  signal sig000000d8 : STD_LOGIC; 
  signal sig000000d9 : STD_LOGIC; 
  signal sig000000da : STD_LOGIC; 
  signal sig000000db : STD_LOGIC; 
  signal sig000000dc : STD_LOGIC; 
  signal sig000000dd : STD_LOGIC; 
  signal sig000000de : STD_LOGIC; 
  signal sig000000df : STD_LOGIC; 
  signal sig000000e0 : STD_LOGIC; 
  signal sig000000e1 : STD_LOGIC; 
  signal sig000000e2 : STD_LOGIC; 
  signal sig000000e3 : STD_LOGIC; 
  signal sig000000e4 : STD_LOGIC; 
  signal sig000000e5 : STD_LOGIC; 
  signal sig000000e6 : STD_LOGIC; 
  signal sig000000e7 : STD_LOGIC; 
  signal sig000000e8 : STD_LOGIC; 
  signal sig000000e9 : STD_LOGIC; 
  signal sig000000ea : STD_LOGIC; 
  signal sig000000eb : STD_LOGIC; 
  signal sig000000ec : STD_LOGIC; 
  signal sig000000ed : STD_LOGIC; 
  signal sig000000ee : STD_LOGIC; 
  signal sig000000ef : STD_LOGIC; 
  signal sig000000f0 : STD_LOGIC; 
  signal sig000000f1 : STD_LOGIC; 
  signal sig000000f2 : STD_LOGIC; 
  signal sig000000f3 : STD_LOGIC; 
  signal sig000000f4 : STD_LOGIC; 
  signal sig000000f5 : STD_LOGIC; 
  signal sig000000f6 : STD_LOGIC; 
  signal sig000000f7 : STD_LOGIC; 
  signal sig000000f8 : STD_LOGIC; 
  signal sig000000f9 : STD_LOGIC; 
  signal sig000000fa : STD_LOGIC; 
  signal sig000000fb : STD_LOGIC; 
  signal sig000000fc : STD_LOGIC; 
  signal sig000000fd : STD_LOGIC; 
  signal sig000000fe : STD_LOGIC; 
  signal sig000000ff : STD_LOGIC; 
  signal sig00000100 : STD_LOGIC; 
  signal sig00000101 : STD_LOGIC; 
  signal sig00000102 : STD_LOGIC; 
  signal sig00000103 : STD_LOGIC; 
  signal sig00000104 : STD_LOGIC; 
  signal sig00000105 : STD_LOGIC; 
  signal sig00000106 : STD_LOGIC; 
  signal sig00000107 : STD_LOGIC; 
  signal sig00000108 : STD_LOGIC; 
  signal sig00000109 : STD_LOGIC; 
  signal sig0000010a : STD_LOGIC; 
  signal sig0000010b : STD_LOGIC; 
  signal sig0000010c : STD_LOGIC; 
  signal sig0000010d : STD_LOGIC; 
  signal sig0000010e : STD_LOGIC; 
  signal sig0000010f : STD_LOGIC; 
  signal sig00000110 : STD_LOGIC; 
  signal sig00000111 : STD_LOGIC; 
  signal sig00000112 : STD_LOGIC; 
  signal sig00000113 : STD_LOGIC; 
  signal sig00000114 : STD_LOGIC; 
  signal sig00000115 : STD_LOGIC; 
  signal sig00000116 : STD_LOGIC; 
  signal sig00000117 : STD_LOGIC; 
  signal sig00000118 : STD_LOGIC; 
  signal sig00000119 : STD_LOGIC; 
  signal sig0000011a : STD_LOGIC; 
  signal sig0000011b : STD_LOGIC; 
  signal sig0000011c : STD_LOGIC; 
  signal sig0000011d : STD_LOGIC; 
  signal sig0000011e : STD_LOGIC; 
  signal sig0000011f : STD_LOGIC; 
  signal sig00000120 : STD_LOGIC; 
  signal sig00000121 : STD_LOGIC; 
  signal sig00000122 : STD_LOGIC; 
  signal sig00000123 : STD_LOGIC; 
  signal sig00000124 : STD_LOGIC; 
  signal sig00000125 : STD_LOGIC; 
  signal sig00000126 : STD_LOGIC; 
  signal sig00000127 : STD_LOGIC; 
  signal sig00000128 : STD_LOGIC; 
  signal sig00000129 : STD_LOGIC; 
  signal sig0000012a : STD_LOGIC; 
  signal sig0000012b : STD_LOGIC; 
  signal sig0000012c : STD_LOGIC; 
  signal sig0000012d : STD_LOGIC; 
  signal sig0000012e : STD_LOGIC; 
  signal sig0000012f : STD_LOGIC; 
  signal sig00000130 : STD_LOGIC; 
  signal sig00000131 : STD_LOGIC; 
  signal sig00000132 : STD_LOGIC; 
  signal sig00000133 : STD_LOGIC; 
  signal sig00000134 : STD_LOGIC; 
  signal sig00000135 : STD_LOGIC; 
  signal sig00000136 : STD_LOGIC; 
  signal sig00000137 : STD_LOGIC; 
  signal sig00000138 : STD_LOGIC; 
  signal sig00000139 : STD_LOGIC; 
  signal sig0000013a : STD_LOGIC; 
  signal sig0000013b : STD_LOGIC; 
  signal sig0000013c : STD_LOGIC; 
  signal sig0000013d : STD_LOGIC; 
  signal sig0000013e : STD_LOGIC; 
  signal sig0000013f : STD_LOGIC; 
  signal sig00000140 : STD_LOGIC; 
  signal sig00000141 : STD_LOGIC; 
  signal sig00000142 : STD_LOGIC; 
  signal sig00000143 : STD_LOGIC; 
  signal sig00000144 : STD_LOGIC; 
  signal sig00000145 : STD_LOGIC; 
  signal sig00000146 : STD_LOGIC; 
  signal sig00000147 : STD_LOGIC; 
  signal sig00000148 : STD_LOGIC; 
  signal sig00000149 : STD_LOGIC; 
  signal sig0000014a : STD_LOGIC; 
  signal sig0000014b : STD_LOGIC; 
  signal sig0000014c : STD_LOGIC; 
  signal sig0000014d : STD_LOGIC; 
  signal sig0000014e : STD_LOGIC; 
  signal sig0000014f : STD_LOGIC; 
  signal sig00000150 : STD_LOGIC; 
  signal sig00000151 : STD_LOGIC; 
  signal sig00000152 : STD_LOGIC; 
  signal sig00000153 : STD_LOGIC; 
  signal sig00000154 : STD_LOGIC; 
  signal sig00000155 : STD_LOGIC; 
  signal sig00000156 : STD_LOGIC; 
  signal sig00000157 : STD_LOGIC; 
  signal sig00000158 : STD_LOGIC; 
  signal sig00000159 : STD_LOGIC; 
  signal sig0000015a : STD_LOGIC; 
  signal sig0000015b : STD_LOGIC; 
  signal sig0000015c : STD_LOGIC; 
  signal sig0000015d : STD_LOGIC; 
  signal sig0000015e : STD_LOGIC; 
  signal sig0000015f : STD_LOGIC; 
  signal sig00000160 : STD_LOGIC; 
  signal sig00000161 : STD_LOGIC; 
  signal sig00000162 : STD_LOGIC; 
  signal sig00000163 : STD_LOGIC; 
  signal sig00000164 : STD_LOGIC; 
  signal sig00000165 : STD_LOGIC; 
  signal sig00000166 : STD_LOGIC; 
  signal sig00000167 : STD_LOGIC; 
  signal sig00000168 : STD_LOGIC; 
  signal sig00000169 : STD_LOGIC; 
  signal sig0000016a : STD_LOGIC; 
  signal sig0000016b : STD_LOGIC; 
  signal sig0000016c : STD_LOGIC; 
  signal sig0000016d : STD_LOGIC; 
  signal sig0000016e : STD_LOGIC; 
  signal sig0000016f : STD_LOGIC; 
  signal sig00000170 : STD_LOGIC; 
  signal sig00000171 : STD_LOGIC; 
  signal sig00000172 : STD_LOGIC; 
  signal sig00000173 : STD_LOGIC; 
  signal sig00000174 : STD_LOGIC; 
  signal sig00000175 : STD_LOGIC; 
  signal sig00000176 : STD_LOGIC; 
  signal sig00000177 : STD_LOGIC; 
  signal sig00000178 : STD_LOGIC; 
  signal sig00000179 : STD_LOGIC; 
  signal sig0000017a : STD_LOGIC; 
  signal sig0000017b : STD_LOGIC; 
  signal sig0000017c : STD_LOGIC; 
  signal sig0000017d : STD_LOGIC; 
  signal sig0000017e : STD_LOGIC; 
  signal sig0000017f : STD_LOGIC; 
  signal sig00000180 : STD_LOGIC; 
  signal sig00000181 : STD_LOGIC; 
  signal sig00000182 : STD_LOGIC; 
  signal sig00000183 : STD_LOGIC; 
  signal sig00000184 : STD_LOGIC; 
  signal sig00000185 : STD_LOGIC; 
  signal sig00000186 : STD_LOGIC; 
  signal sig00000187 : STD_LOGIC; 
  signal sig00000188 : STD_LOGIC; 
  signal sig00000189 : STD_LOGIC; 
  signal sig0000018a : STD_LOGIC; 
  signal sig0000018b : STD_LOGIC; 
  signal sig0000018c : STD_LOGIC; 
  signal sig0000018d : STD_LOGIC; 
  signal sig0000018e : STD_LOGIC; 
  signal sig0000018f : STD_LOGIC; 
  signal sig00000190 : STD_LOGIC; 
  signal sig00000191 : STD_LOGIC; 
  signal sig00000192 : STD_LOGIC; 
  signal sig00000193 : STD_LOGIC; 
  signal sig00000194 : STD_LOGIC; 
  signal sig00000195 : STD_LOGIC; 
  signal sig00000196 : STD_LOGIC; 
  signal sig00000197 : STD_LOGIC; 
  signal sig00000198 : STD_LOGIC; 
  signal sig00000199 : STD_LOGIC; 
  signal sig0000019a : STD_LOGIC; 
  signal sig0000019b : STD_LOGIC; 
  signal sig0000019c : STD_LOGIC; 
  signal sig0000019d : STD_LOGIC; 
  signal sig0000019e : STD_LOGIC; 
  signal sig0000019f : STD_LOGIC; 
  signal sig000001a0 : STD_LOGIC; 
  signal sig000001a1 : STD_LOGIC; 
  signal sig000001a2 : STD_LOGIC; 
  signal sig000001a3 : STD_LOGIC; 
  signal sig000001a4 : STD_LOGIC; 
  signal sig000001a5 : STD_LOGIC; 
  signal sig000001a6 : STD_LOGIC; 
  signal sig000001a7 : STD_LOGIC; 
  signal sig000001a8 : STD_LOGIC; 
  signal sig000001a9 : STD_LOGIC; 
  signal sig000001aa : STD_LOGIC; 
  signal sig000001ab : STD_LOGIC; 
  signal sig000001ac : STD_LOGIC; 
  signal sig000001ad : STD_LOGIC; 
  signal sig000001ae : STD_LOGIC; 
  signal sig000001af : STD_LOGIC; 
  signal sig000001b0 : STD_LOGIC; 
  signal sig000001b1 : STD_LOGIC; 
  signal sig000001b2 : STD_LOGIC; 
  signal sig000001b3 : STD_LOGIC; 
  signal sig000001b4 : STD_LOGIC; 
  signal sig000001b5 : STD_LOGIC; 
  signal sig000001b6 : STD_LOGIC; 
  signal sig000001b7 : STD_LOGIC; 
  signal sig000001b8 : STD_LOGIC; 
  signal sig000001b9 : STD_LOGIC; 
  signal sig000001ba : STD_LOGIC; 
  signal sig000001bb : STD_LOGIC; 
  signal sig000001bc : STD_LOGIC; 
  signal sig000001bd : STD_LOGIC; 
  signal sig000001be : STD_LOGIC; 
  signal sig000001bf : STD_LOGIC; 
  signal sig000001c0 : STD_LOGIC; 
  signal sig000001c1 : STD_LOGIC; 
  signal sig000001c2 : STD_LOGIC; 
  signal sig000001c3 : STD_LOGIC; 
  signal sig000001c4 : STD_LOGIC; 
  signal sig000001c5 : STD_LOGIC; 
  signal sig000001c6 : STD_LOGIC; 
  signal sig000001c7 : STD_LOGIC; 
  signal sig000001c8 : STD_LOGIC; 
  signal sig000001c9 : STD_LOGIC; 
  signal sig000001ca : STD_LOGIC; 
  signal sig000001cb : STD_LOGIC; 
  signal sig000001cc : STD_LOGIC; 
  signal sig000001cd : STD_LOGIC; 
  signal sig000001ce : STD_LOGIC; 
  signal sig000001cf : STD_LOGIC; 
  signal sig000001d0 : STD_LOGIC; 
  signal sig000001d1 : STD_LOGIC; 
  signal sig000001d2 : STD_LOGIC; 
  signal sig000001d3 : STD_LOGIC; 
  signal sig000001d4 : STD_LOGIC; 
  signal sig000001d5 : STD_LOGIC; 
  signal sig000001d6 : STD_LOGIC; 
  signal sig000001d7 : STD_LOGIC; 
  signal sig000001d8 : STD_LOGIC; 
  signal sig000001d9 : STD_LOGIC; 
  signal sig000001da : STD_LOGIC; 
  signal sig000001db : STD_LOGIC; 
  signal sig000001dc : STD_LOGIC; 
  signal sig000001dd : STD_LOGIC; 
  signal sig000001de : STD_LOGIC; 
  signal sig000001df : STD_LOGIC; 
  signal sig000001e0 : STD_LOGIC; 
  signal sig000001e1 : STD_LOGIC; 
  signal sig000001e2 : STD_LOGIC; 
  signal sig000001e3 : STD_LOGIC; 
  signal sig000001e4 : STD_LOGIC; 
  signal sig000001e5 : STD_LOGIC; 
  signal sig000001e6 : STD_LOGIC; 
  signal sig000001e7 : STD_LOGIC; 
  signal sig000001e8 : STD_LOGIC; 
  signal sig000001e9 : STD_LOGIC; 
  signal sig000001ea : STD_LOGIC; 
  signal sig000001eb : STD_LOGIC; 
  signal sig000001ec : STD_LOGIC; 
  signal sig000001ed : STD_LOGIC; 
  signal sig000001ee : STD_LOGIC; 
  signal sig000001ef : STD_LOGIC; 
  signal sig000001f0 : STD_LOGIC; 
  signal sig000001f1 : STD_LOGIC; 
  signal sig000001f2 : STD_LOGIC; 
  signal sig000001f3 : STD_LOGIC; 
  signal sig000001f4 : STD_LOGIC; 
  signal sig000001f5 : STD_LOGIC; 
  signal sig000001f6 : STD_LOGIC; 
  signal sig000001f7 : STD_LOGIC; 
  signal sig000001f8 : STD_LOGIC; 
  signal sig000001f9 : STD_LOGIC; 
  signal sig000001fa : STD_LOGIC; 
  signal sig000001fb : STD_LOGIC; 
  signal sig000001fc : STD_LOGIC; 
  signal sig000001fd : STD_LOGIC; 
  signal sig000001fe : STD_LOGIC; 
  signal sig000001ff : STD_LOGIC; 
  signal sig00000200 : STD_LOGIC; 
  signal sig00000201 : STD_LOGIC; 
  signal sig00000202 : STD_LOGIC; 
  signal sig00000203 : STD_LOGIC; 
  signal sig00000204 : STD_LOGIC; 
  signal sig00000205 : STD_LOGIC; 
  signal sig00000206 : STD_LOGIC; 
  signal sig00000207 : STD_LOGIC; 
  signal sig00000208 : STD_LOGIC; 
  signal sig00000209 : STD_LOGIC; 
  signal sig0000020a : STD_LOGIC; 
  signal sig0000020b : STD_LOGIC; 
  signal sig0000020c : STD_LOGIC; 
  signal sig0000020d : STD_LOGIC; 
  signal sig0000020e : STD_LOGIC; 
  signal sig0000020f : STD_LOGIC; 
  signal sig00000210 : STD_LOGIC; 
  signal sig00000211 : STD_LOGIC; 
  signal sig00000212 : STD_LOGIC; 
  signal sig00000213 : STD_LOGIC; 
  signal sig00000214 : STD_LOGIC; 
  signal sig00000215 : STD_LOGIC; 
  signal sig00000216 : STD_LOGIC; 
  signal sig00000217 : STD_LOGIC; 
  signal sig00000218 : STD_LOGIC; 
  signal sig00000219 : STD_LOGIC; 
  signal sig0000021a : STD_LOGIC; 
  signal sig0000021b : STD_LOGIC; 
  signal sig0000021c : STD_LOGIC; 
  signal sig0000021d : STD_LOGIC; 
  signal sig0000021e : STD_LOGIC; 
  signal sig0000021f : STD_LOGIC; 
  signal sig00000220 : STD_LOGIC; 
  signal sig00000221 : STD_LOGIC; 
  signal sig00000222 : STD_LOGIC; 
  signal sig00000223 : STD_LOGIC; 
  signal sig00000224 : STD_LOGIC; 
  signal sig00000225 : STD_LOGIC; 
  signal sig00000226 : STD_LOGIC; 
  signal sig00000227 : STD_LOGIC; 
  signal sig00000228 : STD_LOGIC; 
  signal sig00000229 : STD_LOGIC; 
  signal sig0000022a : STD_LOGIC; 
  signal sig0000022b : STD_LOGIC; 
  signal sig0000022c : STD_LOGIC; 
  signal sig0000022d : STD_LOGIC; 
  signal sig0000022e : STD_LOGIC; 
  signal sig0000022f : STD_LOGIC; 
  signal sig00000230 : STD_LOGIC; 
  signal sig00000231 : STD_LOGIC; 
  signal sig00000232 : STD_LOGIC; 
  signal sig00000233 : STD_LOGIC; 
  signal sig00000234 : STD_LOGIC; 
  signal sig00000235 : STD_LOGIC; 
  signal sig00000236 : STD_LOGIC; 
  signal sig00000237 : STD_LOGIC; 
  signal sig00000238 : STD_LOGIC; 
  signal sig00000239 : STD_LOGIC; 
  signal sig0000023a : STD_LOGIC; 
  signal sig0000023b : STD_LOGIC; 
  signal sig0000023c : STD_LOGIC; 
  signal sig0000023d : STD_LOGIC; 
  signal sig0000023e : STD_LOGIC; 
  signal sig0000023f : STD_LOGIC; 
  signal sig00000240 : STD_LOGIC; 
  signal sig00000241 : STD_LOGIC; 
  signal sig00000242 : STD_LOGIC; 
  signal sig00000243 : STD_LOGIC; 
  signal sig00000244 : STD_LOGIC; 
  signal sig00000245 : STD_LOGIC; 
  signal sig00000246 : STD_LOGIC; 
  signal sig00000247 : STD_LOGIC; 
  signal sig00000248 : STD_LOGIC; 
  signal sig00000249 : STD_LOGIC; 
  signal sig0000024a : STD_LOGIC; 
  signal sig0000024b : STD_LOGIC; 
  signal sig0000024c : STD_LOGIC; 
  signal sig0000024d : STD_LOGIC; 
  signal sig0000024e : STD_LOGIC; 
  signal sig0000024f : STD_LOGIC; 
  signal sig00000250 : STD_LOGIC; 
  signal sig00000251 : STD_LOGIC; 
  signal sig00000252 : STD_LOGIC; 
  signal sig00000253 : STD_LOGIC; 
  signal sig00000254 : STD_LOGIC; 
  signal sig00000255 : STD_LOGIC; 
  signal sig00000256 : STD_LOGIC; 
  signal sig00000257 : STD_LOGIC; 
  signal sig00000258 : STD_LOGIC; 
  signal sig00000259 : STD_LOGIC; 
  signal sig0000025a : STD_LOGIC; 
  signal sig0000025b : STD_LOGIC; 
  signal sig0000025c : STD_LOGIC; 
  signal sig0000025d : STD_LOGIC; 
  signal sig0000025e : STD_LOGIC; 
  signal sig0000025f : STD_LOGIC; 
  signal sig00000260 : STD_LOGIC; 
  signal sig00000261 : STD_LOGIC; 
  signal sig00000262 : STD_LOGIC; 
  signal sig00000263 : STD_LOGIC; 
  signal sig00000264 : STD_LOGIC; 
  signal sig00000265 : STD_LOGIC; 
  signal sig00000266 : STD_LOGIC; 
  signal sig00000267 : STD_LOGIC; 
  signal sig00000268 : STD_LOGIC; 
  signal sig00000269 : STD_LOGIC; 
  signal sig0000026a : STD_LOGIC; 
  signal sig0000026b : STD_LOGIC; 
  signal sig0000026c : STD_LOGIC; 
  signal sig0000026d : STD_LOGIC; 
  signal sig0000026e : STD_LOGIC; 
  signal sig0000026f : STD_LOGIC; 
  signal sig00000270 : STD_LOGIC; 
  signal sig00000271 : STD_LOGIC; 
  signal sig00000272 : STD_LOGIC; 
  signal sig00000273 : STD_LOGIC; 
  signal sig00000274 : STD_LOGIC; 
  signal sig00000275 : STD_LOGIC; 
  signal sig00000276 : STD_LOGIC; 
  signal sig00000277 : STD_LOGIC; 
  signal sig00000278 : STD_LOGIC; 
  signal sig00000279 : STD_LOGIC; 
  signal sig0000027a : STD_LOGIC; 
  signal sig0000027b : STD_LOGIC; 
  signal sig0000027c : STD_LOGIC; 
  signal sig0000027d : STD_LOGIC; 
  signal sig0000027e : STD_LOGIC; 
  signal sig0000027f : STD_LOGIC; 
  signal sig00000280 : STD_LOGIC; 
  signal sig00000281 : STD_LOGIC; 
  signal sig00000282 : STD_LOGIC; 
  signal sig00000283 : STD_LOGIC; 
  signal sig00000284 : STD_LOGIC; 
  signal sig00000285 : STD_LOGIC; 
  signal sig00000286 : STD_LOGIC; 
  signal sig00000287 : STD_LOGIC; 
  signal sig00000288 : STD_LOGIC; 
  signal sig00000289 : STD_LOGIC; 
  signal sig0000028a : STD_LOGIC; 
  signal sig0000028b : STD_LOGIC; 
  signal sig0000028c : STD_LOGIC; 
  signal sig0000028d : STD_LOGIC; 
  signal sig0000028e : STD_LOGIC; 
  signal sig0000028f : STD_LOGIC; 
  signal sig00000290 : STD_LOGIC; 
  signal sig00000291 : STD_LOGIC; 
  signal sig00000292 : STD_LOGIC; 
  signal sig00000293 : STD_LOGIC; 
  signal sig00000294 : STD_LOGIC; 
  signal sig00000295 : STD_LOGIC; 
  signal sig00000296 : STD_LOGIC; 
  signal sig00000297 : STD_LOGIC; 
  signal sig00000298 : STD_LOGIC; 
  signal sig00000299 : STD_LOGIC; 
  signal sig0000029a : STD_LOGIC; 
  signal sig0000029b : STD_LOGIC; 
  signal sig0000029c : STD_LOGIC; 
  signal sig0000029d : STD_LOGIC; 
  signal sig0000029e : STD_LOGIC; 
  signal sig0000029f : STD_LOGIC; 
  signal sig000002a0 : STD_LOGIC; 
  signal sig000002a1 : STD_LOGIC; 
  signal sig000002a2 : STD_LOGIC; 
  signal sig000002a3 : STD_LOGIC; 
  signal sig000002a4 : STD_LOGIC; 
  signal sig000002a5 : STD_LOGIC; 
  signal sig000002a6 : STD_LOGIC; 
  signal sig000002a7 : STD_LOGIC; 
  signal sig000002a8 : STD_LOGIC; 
  signal sig000002a9 : STD_LOGIC; 
  signal sig000002aa : STD_LOGIC; 
  signal sig000002ab : STD_LOGIC; 
  signal sig000002ac : STD_LOGIC; 
  signal sig000002ad : STD_LOGIC; 
  signal sig000002ae : STD_LOGIC; 
  signal sig000002af : STD_LOGIC; 
  signal sig000002b0 : STD_LOGIC; 
  signal sig000002b1 : STD_LOGIC; 
  signal sig000002b2 : STD_LOGIC; 
  signal sig000002b3 : STD_LOGIC; 
  signal sig000002b4 : STD_LOGIC; 
  signal sig000002b5 : STD_LOGIC; 
  signal sig000002b6 : STD_LOGIC; 
  signal sig000002b7 : STD_LOGIC; 
  signal sig000002b8 : STD_LOGIC; 
  signal sig000002b9 : STD_LOGIC; 
  signal sig000002ba : STD_LOGIC; 
  signal sig000002bb : STD_LOGIC; 
  signal sig000002bc : STD_LOGIC; 
  signal sig000002bd : STD_LOGIC; 
  signal sig000002be : STD_LOGIC; 
  signal sig000002bf : STD_LOGIC; 
  signal sig000002c0 : STD_LOGIC; 
  signal sig000002c1 : STD_LOGIC; 
  signal sig000002c2 : STD_LOGIC; 
  signal sig000002c3 : STD_LOGIC; 
  signal sig000002c4 : STD_LOGIC; 
  signal sig000002c5 : STD_LOGIC; 
  signal sig000002c6 : STD_LOGIC; 
  signal sig000002c7 : STD_LOGIC; 
  signal sig000002c8 : STD_LOGIC; 
  signal sig000002c9 : STD_LOGIC; 
  signal sig000002ca : STD_LOGIC; 
  signal sig000002cb : STD_LOGIC; 
  signal sig000002cc : STD_LOGIC; 
  signal sig000002cd : STD_LOGIC; 
  signal sig000002ce : STD_LOGIC; 
  signal sig000002cf : STD_LOGIC; 
  signal sig000002d0 : STD_LOGIC; 
  signal sig000002d1 : STD_LOGIC; 
  signal sig000002d2 : STD_LOGIC; 
  signal sig000002d3 : STD_LOGIC; 
  signal sig000002d4 : STD_LOGIC; 
  signal sig000002d5 : STD_LOGIC; 
  signal sig000002d6 : STD_LOGIC; 
  signal sig000002d7 : STD_LOGIC; 
  signal sig000002d8 : STD_LOGIC; 
  signal sig000002d9 : STD_LOGIC; 
  signal sig000002da : STD_LOGIC; 
  signal sig000002db : STD_LOGIC; 
  signal sig000002dc : STD_LOGIC; 
  signal sig000002dd : STD_LOGIC; 
  signal sig000002de : STD_LOGIC; 
  signal sig000002df : STD_LOGIC; 
  signal sig000002e0 : STD_LOGIC; 
  signal sig000002e1 : STD_LOGIC; 
  signal sig000002e2 : STD_LOGIC; 
  signal sig000002e3 : STD_LOGIC; 
  signal sig000002e4 : STD_LOGIC; 
  signal sig000002e5 : STD_LOGIC; 
  signal sig000002e6 : STD_LOGIC; 
  signal sig000002e7 : STD_LOGIC; 
  signal sig000002e8 : STD_LOGIC; 
  signal sig000002e9 : STD_LOGIC; 
  signal sig000002ea : STD_LOGIC; 
  signal sig000002eb : STD_LOGIC; 
  signal sig000002ec : STD_LOGIC; 
  signal sig000002ed : STD_LOGIC; 
  signal sig000002ee : STD_LOGIC; 
  signal sig000002ef : STD_LOGIC; 
  signal sig000002f0 : STD_LOGIC; 
  signal sig000002f1 : STD_LOGIC; 
  signal sig000002f2 : STD_LOGIC; 
  signal sig000002f3 : STD_LOGIC; 
  signal sig000002f4 : STD_LOGIC; 
  signal sig000002f5 : STD_LOGIC; 
  signal sig000002f6 : STD_LOGIC; 
  signal sig000002f7 : STD_LOGIC; 
  signal sig000002f8 : STD_LOGIC; 
  signal sig000002f9 : STD_LOGIC; 
  signal sig000002fa : STD_LOGIC; 
  signal sig000002fb : STD_LOGIC; 
  signal sig000002fc : STD_LOGIC; 
  signal sig000002fd : STD_LOGIC; 
  signal sig000002fe : STD_LOGIC; 
  signal sig000002ff : STD_LOGIC; 
  signal sig00000300 : STD_LOGIC; 
  signal sig00000301 : STD_LOGIC; 
  signal sig00000302 : STD_LOGIC; 
  signal sig00000303 : STD_LOGIC; 
  signal sig00000304 : STD_LOGIC; 
  signal sig00000305 : STD_LOGIC; 
  signal sig00000306 : STD_LOGIC; 
  signal sig00000307 : STD_LOGIC; 
  signal sig00000308 : STD_LOGIC; 
  signal sig00000309 : STD_LOGIC; 
  signal sig0000030a : STD_LOGIC; 
  signal sig0000030b : STD_LOGIC; 
  signal sig0000030c : STD_LOGIC; 
  signal sig0000030d : STD_LOGIC; 
  signal sig0000030e : STD_LOGIC; 
  signal sig0000030f : STD_LOGIC; 
  signal sig00000310 : STD_LOGIC; 
  signal sig00000311 : STD_LOGIC; 
  signal sig00000312 : STD_LOGIC; 
  signal sig00000313 : STD_LOGIC; 
  signal sig00000314 : STD_LOGIC; 
  signal sig00000315 : STD_LOGIC; 
  signal sig00000316 : STD_LOGIC; 
  signal sig00000317 : STD_LOGIC; 
  signal sig00000318 : STD_LOGIC; 
  signal sig00000319 : STD_LOGIC; 
  signal sig0000031a : STD_LOGIC; 
  signal sig0000031b : STD_LOGIC; 
  signal sig0000031c : STD_LOGIC; 
  signal sig0000031d : STD_LOGIC; 
  signal sig0000031e : STD_LOGIC; 
  signal sig0000031f : STD_LOGIC; 
  signal sig00000320 : STD_LOGIC; 
  signal sig00000321 : STD_LOGIC; 
  signal sig00000322 : STD_LOGIC; 
  signal sig00000323 : STD_LOGIC; 
  signal sig00000324 : STD_LOGIC; 
  signal sig00000325 : STD_LOGIC; 
  signal sig00000326 : STD_LOGIC; 
  signal sig00000327 : STD_LOGIC; 
  signal sig00000328 : STD_LOGIC; 
  signal sig00000329 : STD_LOGIC; 
  signal sig0000032a : STD_LOGIC; 
  signal sig0000032b : STD_LOGIC; 
  signal sig0000032c : STD_LOGIC; 
  signal sig0000032d : STD_LOGIC; 
  signal sig0000032e : STD_LOGIC; 
  signal sig0000032f : STD_LOGIC; 
  signal sig00000330 : STD_LOGIC; 
  signal sig00000331 : STD_LOGIC; 
  signal sig00000332 : STD_LOGIC; 
  signal sig00000333 : STD_LOGIC; 
  signal sig00000334 : STD_LOGIC; 
  signal sig00000335 : STD_LOGIC; 
  signal sig00000336 : STD_LOGIC; 
  signal sig00000337 : STD_LOGIC; 
  signal sig00000338 : STD_LOGIC; 
  signal sig00000339 : STD_LOGIC; 
  signal sig0000033a : STD_LOGIC; 
  signal sig0000033b : STD_LOGIC; 
  signal sig0000033c : STD_LOGIC; 
  signal sig0000033d : STD_LOGIC; 
  signal sig0000033e : STD_LOGIC; 
  signal sig0000033f : STD_LOGIC; 
  signal sig00000340 : STD_LOGIC; 
  signal sig00000341 : STD_LOGIC; 
  signal sig00000342 : STD_LOGIC; 
  signal sig00000343 : STD_LOGIC; 
  signal sig00000344 : STD_LOGIC; 
  signal sig00000345 : STD_LOGIC; 
  signal sig00000346 : STD_LOGIC; 
  signal sig00000347 : STD_LOGIC; 
  signal sig00000348 : STD_LOGIC; 
  signal sig00000349 : STD_LOGIC; 
  signal sig0000034a : STD_LOGIC; 
  signal sig0000034b : STD_LOGIC; 
  signal sig0000034c : STD_LOGIC; 
  signal sig0000034d : STD_LOGIC; 
  signal sig0000034e : STD_LOGIC; 
  signal sig0000034f : STD_LOGIC; 
  signal sig00000350 : STD_LOGIC; 
  signal sig00000351 : STD_LOGIC; 
  signal sig00000352 : STD_LOGIC; 
  signal sig00000353 : STD_LOGIC; 
  signal sig00000354 : STD_LOGIC; 
  signal sig00000355 : STD_LOGIC; 
  signal sig00000356 : STD_LOGIC; 
  signal sig00000357 : STD_LOGIC; 
  signal sig00000358 : STD_LOGIC; 
  signal sig00000359 : STD_LOGIC; 
  signal sig0000035a : STD_LOGIC; 
  signal sig0000035b : STD_LOGIC; 
  signal sig0000035c : STD_LOGIC; 
  signal sig0000035d : STD_LOGIC; 
  signal sig0000035e : STD_LOGIC; 
  signal sig0000035f : STD_LOGIC; 
  signal sig00000360 : STD_LOGIC; 
  signal sig00000361 : STD_LOGIC; 
  signal sig00000362 : STD_LOGIC; 
  signal sig00000363 : STD_LOGIC; 
  signal sig00000364 : STD_LOGIC; 
  signal sig00000365 : STD_LOGIC; 
  signal sig00000366 : STD_LOGIC; 
  signal sig00000367 : STD_LOGIC; 
  signal sig00000368 : STD_LOGIC; 
  signal sig00000369 : STD_LOGIC; 
  signal sig0000036a : STD_LOGIC; 
  signal sig0000036b : STD_LOGIC; 
  signal sig0000036c : STD_LOGIC; 
  signal sig0000036d : STD_LOGIC; 
  signal sig0000036e : STD_LOGIC; 
  signal sig0000036f : STD_LOGIC; 
  signal sig00000370 : STD_LOGIC; 
  signal sig00000371 : STD_LOGIC; 
  signal sig00000372 : STD_LOGIC; 
  signal sig00000373 : STD_LOGIC; 
  signal sig00000374 : STD_LOGIC; 
  signal sig00000375 : STD_LOGIC; 
  signal sig00000376 : STD_LOGIC; 
  signal sig00000377 : STD_LOGIC; 
  signal sig00000378 : STD_LOGIC; 
  signal sig00000379 : STD_LOGIC; 
  signal sig0000037a : STD_LOGIC; 
  signal sig0000037b : STD_LOGIC; 
  signal sig0000037c : STD_LOGIC; 
  signal sig0000037d : STD_LOGIC; 
  signal sig0000037e : STD_LOGIC; 
  signal sig0000037f : STD_LOGIC; 
  signal sig00000380 : STD_LOGIC; 
  signal sig00000381 : STD_LOGIC; 
  signal sig00000382 : STD_LOGIC; 
  signal sig00000383 : STD_LOGIC; 
  signal sig00000384 : STD_LOGIC; 
  signal sig00000385 : STD_LOGIC; 
  signal sig00000386 : STD_LOGIC; 
  signal sig00000387 : STD_LOGIC; 
  signal sig00000388 : STD_LOGIC; 
  signal sig00000389 : STD_LOGIC; 
  signal sig0000038a : STD_LOGIC; 
  signal sig0000038b : STD_LOGIC; 
  signal sig0000038c : STD_LOGIC; 
  signal sig0000038d : STD_LOGIC; 
  signal sig0000038e : STD_LOGIC; 
  signal sig0000038f : STD_LOGIC; 
  signal sig00000390 : STD_LOGIC; 
  signal sig00000391 : STD_LOGIC; 
  signal sig00000392 : STD_LOGIC; 
  signal sig00000393 : STD_LOGIC; 
  signal sig00000394 : STD_LOGIC; 
  signal sig00000395 : STD_LOGIC; 
  signal sig00000396 : STD_LOGIC; 
  signal sig00000397 : STD_LOGIC; 
  signal sig00000398 : STD_LOGIC; 
  signal blk000000e8_sig000003dd : STD_LOGIC; 
  signal blk000000e8_sig000003cc : STD_LOGIC; 
  signal blk000000e8_sig000003cb : STD_LOGIC; 
  signal blk000000e8_sig000003ca : STD_LOGIC; 
  signal blk000000e8_sig000003c9 : STD_LOGIC; 
  signal blk000000e8_sig000003c8 : STD_LOGIC; 
  signal blk000000e8_sig000003c7 : STD_LOGIC; 
  signal blk000000e8_sig000003c6 : STD_LOGIC; 
  signal blk000000e8_sig000003c5 : STD_LOGIC; 
  signal blk000000e8_sig000003c4 : STD_LOGIC; 
  signal blk000000e8_sig000003c3 : STD_LOGIC; 
  signal blk000000e8_sig000003c2 : STD_LOGIC; 
  signal blk000000e8_sig000003c1 : STD_LOGIC; 
  signal blk000000e8_sig000003c0 : STD_LOGIC; 
  signal blk000000e8_sig000003bf : STD_LOGIC; 
  signal blk000000e8_sig000003be : STD_LOGIC; 
  signal blk000000e8_sig000003bd : STD_LOGIC; 
  signal blk0000011b_blk0000011c_sig000003e9 : STD_LOGIC; 
  signal blk0000011b_blk0000011c_sig000003e8 : STD_LOGIC; 
  signal blk0000011b_blk0000011c_sig000003e7 : STD_LOGIC; 
  signal blk00000141_blk00000142_sig000003f4 : STD_LOGIC; 
  signal blk00000141_blk00000142_sig000003f3 : STD_LOGIC; 
  signal blk00000141_blk00000142_sig000003f2 : STD_LOGIC; 
  signal blk000001f1_blk000001f2_sig00000400 : STD_LOGIC; 
  signal blk000001f1_blk000001f2_sig000003ff : STD_LOGIC; 
  signal blk000001f1_blk000001f2_sig000003fe : STD_LOGIC; 
  signal blk00000224_blk00000225_sig0000040a : STD_LOGIC; 
  signal blk00000228_sig0000042b : STD_LOGIC; 
  signal blk00000228_sig0000042a : STD_LOGIC; 
  signal blk00000228_sig00000429 : STD_LOGIC; 
  signal blk00000228_sig00000428 : STD_LOGIC; 
  signal blk00000228_sig00000427 : STD_LOGIC; 
  signal blk00000228_sig00000426 : STD_LOGIC; 
  signal blk00000228_sig00000425 : STD_LOGIC; 
  signal blk00000228_sig00000424 : STD_LOGIC; 
  signal blk00000228_sig00000423 : STD_LOGIC; 
  signal blk00000228_sig00000422 : STD_LOGIC; 
  signal blk00000228_sig00000421 : STD_LOGIC; 
  signal blk00000228_sig00000420 : STD_LOGIC; 
  signal blk00000228_sig0000041f : STD_LOGIC; 
  signal blk00000228_sig0000041e : STD_LOGIC; 
  signal blk00000228_sig0000041d : STD_LOGIC; 
  signal blk00000228_sig0000041c : STD_LOGIC; 
  signal blk00000279_blk0000027a_sig00000436 : STD_LOGIC; 
  signal blk00000279_blk0000027a_sig00000435 : STD_LOGIC; 
  signal blk00000279_blk0000027a_sig00000434 : STD_LOGIC; 
  signal blk0000027f_blk00000280_sig00000441 : STD_LOGIC; 
  signal blk0000027f_blk00000280_sig00000440 : STD_LOGIC; 
  signal blk0000027f_blk00000280_sig0000043f : STD_LOGIC; 
  signal blk00000285_sig00000451 : STD_LOGIC; 
  signal blk00000285_sig00000450 : STD_LOGIC; 
  signal blk00000285_sig0000044f : STD_LOGIC; 
  signal blk00000285_sig0000044e : STD_LOGIC; 
  signal blk00000285_sig0000044d : STD_LOGIC; 
  signal blk00000285_sig0000044c : STD_LOGIC; 
  signal blk00000285_sig0000044b : STD_LOGIC; 
  signal blk00000285_sig0000044a : STD_LOGIC; 
  signal blk00000292_blk00000293_sig0000045d : STD_LOGIC; 
  signal blk00000292_blk00000293_sig0000045c : STD_LOGIC; 
  signal blk00000292_blk00000293_sig0000045b : STD_LOGIC; 
  signal blk00000298_blk00000299_sig00000469 : STD_LOGIC; 
  signal blk00000298_blk00000299_sig00000468 : STD_LOGIC; 
  signal blk00000298_blk00000299_sig00000467 : STD_LOGIC; 
  signal blk0000029e_blk0000029f_sig00000475 : STD_LOGIC; 
  signal blk0000029e_blk0000029f_sig00000474 : STD_LOGIC; 
  signal blk0000029e_blk0000029f_sig00000473 : STD_LOGIC; 
  signal blk000002be_sig000004a0 : STD_LOGIC; 
  signal blk000002be_sig0000049f : STD_LOGIC; 
  signal blk000002be_sig0000049e : STD_LOGIC; 
  signal blk000002be_sig0000049d : STD_LOGIC; 
  signal blk000002be_sig0000049c : STD_LOGIC; 
  signal blk000002be_sig0000049b : STD_LOGIC; 
  signal blk000002be_sig0000049a : STD_LOGIC; 
  signal blk000002be_sig00000499 : STD_LOGIC; 
  signal blk000002be_sig00000498 : STD_LOGIC; 
  signal blk000002be_sig00000497 : STD_LOGIC; 
  signal blk000002be_sig00000496 : STD_LOGIC; 
  signal blk000002be_sig00000495 : STD_LOGIC; 
  signal blk000002be_sig00000494 : STD_LOGIC; 
  signal blk000002be_sig00000493 : STD_LOGIC; 
  signal blk000002be_sig00000492 : STD_LOGIC; 
  signal blk000002be_sig00000491 : STD_LOGIC; 
  signal blk000002be_sig00000490 : STD_LOGIC; 
  signal blk000002be_sig0000048f : STD_LOGIC; 
  signal blk000002be_sig0000048e : STD_LOGIC; 
  signal blk000002be_sig0000048d : STD_LOGIC; 
  signal blk000002be_sig0000048c : STD_LOGIC; 
  signal blk000002be_sig0000048b : STD_LOGIC; 
  signal blk000002be_sig0000048a : STD_LOGIC; 
  signal blk000002be_sig00000489 : STD_LOGIC; 
  signal NLW_blk00000003_CARRYOUTF_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_CARRYOUT_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_BCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_P_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_PCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000003_M_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_CARRYOUTF_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_CARRYOUT_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_BCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_P_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000008f_M_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_CARRYOUTF_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_CARRYOUT_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_BCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_P_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_47_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_46_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_45_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_44_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_43_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_42_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_41_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_40_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_39_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_38_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_37_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_36_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_PCOUT_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_35_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_34_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_33_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_32_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_31_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_30_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_29_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_28_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_27_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_26_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_25_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_24_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_23_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_22_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_21_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_20_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_19_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_18_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_17_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_16_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000090_M_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000157_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000158_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000159_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000015a_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000015b_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000015c_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000165_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000166_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000177_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000178_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000179_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000017a_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000017b_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000017c_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000185_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000186_Q_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOADO_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOADO_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOADO_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOADO_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOADO_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOADO_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOADO_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOADO_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOPADOP_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOPBDOP_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_ADDRAWRADDR_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_ADDRAWRADDR_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_ADDRAWRADDR_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIPBDIP_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIPBDIP_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIBDI_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIADI_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIADI_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIADI_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIADI_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIADI_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIADI_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIADI_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIADI_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_ADDRBRDADDR_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_ADDRBRDADDR_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_ADDRBRDADDR_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOBDO_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOBDO_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOBDO_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOBDO_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOBDO_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOBDO_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOBDO_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DOBDO_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000038d_DIPADIP_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003a2_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003a4_Q31_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003a6_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003a8_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003aa_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003ac_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003ae_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003b0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003b2_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003b4_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003b6_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000003b8_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOADO_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOPADOP_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOPBDOP_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOPBDOP_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000000e8_blk000000fa_DOBDO_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000011b_blk0000011c_blk0000011f_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000141_blk00000142_blk00000145_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk000001f1_blk000001f2_blk000001f5_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000279_blk0000027a_blk0000027d_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000027f_blk00000280_blk00000283_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000292_blk00000293_blk00000296_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk00000298_blk00000299_blk0000029c_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_blk0000029e_blk0000029f_blk000002a2_Q15_UNCONNECTED : STD_LOGIC; 
  signal NlwRenamedSig_OI_xn_index : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP : STD_LOGIC_VECTOR ( 4 downto 0 ); 
begin
  xn_index(7) <= NlwRenamedSig_OI_xn_index(7);
  xn_index(6) <= NlwRenamedSig_OI_xn_index(6);
  xn_index(5) <= NlwRenamedSig_OI_xn_index(5);
  xn_index(4) <= NlwRenamedSig_OI_xn_index(4);
  xn_index(3) <= NlwRenamedSig_OI_xn_index(3);
  xn_index(2) <= NlwRenamedSig_OI_xn_index(2);
  xn_index(1) <= NlwRenamedSig_OI_xn_index(1);
  xn_index(0) <= NlwRenamedSig_OI_xn_index(0);
  xk_index(7) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(7);
  xk_index(6) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(6);
  xk_index(5) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(5);
  xk_index(4) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(4);
  xk_index(3) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(3);
  xk_index(2) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(2);
  xk_index(1) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(1);
  xk_index(0) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(0);
  xk_re(7) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(7);
  xk_re(6) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(6);
  xk_re(5) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(5);
  xk_re(4) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(4);
  xk_re(3) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(3);
  xk_re(2) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(2);
  xk_re(1) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(1);
  xk_re(0) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(0);
  xk_im(7) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(7);
  xk_im(6) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(6);
  xk_im(5) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(5);
  xk_im(4) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(4);
  xk_im(3) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(3);
  xk_im(2) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(2);
  xk_im(1) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(1);
  xk_im(0) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(0);
  blk_exp(4) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(4);
  blk_exp(3) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(3);
  blk_exp(2) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(2);
  blk_exp(1) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(1);
  blk_exp(0) <= U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(0);
  rfd <= NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i;
  busy <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_busy_i_reg2;
  edone <= NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_run_addr_gen_done_int2;
  done <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_done_i_reg;
  dv <= U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_dv_d;
  blk00000001 : VCC
    port map (
      P => sig00000001
    );
  blk00000002 : GND
    port map (
      G => sig00000002
    );
  blk00000003 : DSP48A1
    generic map(
      A0REG => 0,
      A1REG => 1,
      B0REG => 0,
      B1REG => 1,
      CARRYINREG => 0,
      CARRYINSEL => "OPMODE5",
      CREG => 1,
      DREG => 1,
      MREG => 1,
      OPMODEREG => 1,
      PREG => 1,
      RSTTYPE => "SYNC",
      CARRYOUTREG => 0
    )
    port map (
      CECARRYIN => sig00000002,
      RSTC => sig00000002,
      RSTCARRYIN => sig00000002,
      CED => ce,
      RSTD => sig00000002,
      CEOPMODE => ce,
      CEC => ce,
      CARRYOUTF => NLW_blk00000003_CARRYOUTF_UNCONNECTED,
      RSTOPMODE => sig00000002,
      RSTM => sig00000002,
      CLK => clk,
      RSTB => sig00000002,
      CEM => sig00000002,
      CEB => ce,
      CARRYIN => sig00000002,
      CEP => ce,
      CEA => ce,
      CARRYOUT => NLW_blk00000003_CARRYOUT_UNCONNECTED,
      RSTA => sig00000002,
      RSTP => sig00000002,
      B(17) => sig0000010d,
      B(16) => sig0000010d,
      B(15) => sig0000010d,
      B(14) => sig0000010d,
      B(13) => sig0000010d,
      B(12) => sig0000010d,
      B(11) => sig0000010d,
      B(10) => sig0000010c,
      B(9) => sig0000010b,
      B(8) => sig0000010a,
      B(7) => sig00000109,
      B(6) => sig00000108,
      B(5) => sig00000107,
      B(4) => sig00000106,
      B(3) => sig00000105,
      B(2) => sig00000104,
      B(1) => sig00000103,
      B(0) => sig00000102,
      BCOUT(17) => NLW_blk00000003_BCOUT_17_UNCONNECTED,
      BCOUT(16) => NLW_blk00000003_BCOUT_16_UNCONNECTED,
      BCOUT(15) => NLW_blk00000003_BCOUT_15_UNCONNECTED,
      BCOUT(14) => NLW_blk00000003_BCOUT_14_UNCONNECTED,
      BCOUT(13) => NLW_blk00000003_BCOUT_13_UNCONNECTED,
      BCOUT(12) => NLW_blk00000003_BCOUT_12_UNCONNECTED,
      BCOUT(11) => NLW_blk00000003_BCOUT_11_UNCONNECTED,
      BCOUT(10) => NLW_blk00000003_BCOUT_10_UNCONNECTED,
      BCOUT(9) => NLW_blk00000003_BCOUT_9_UNCONNECTED,
      BCOUT(8) => NLW_blk00000003_BCOUT_8_UNCONNECTED,
      BCOUT(7) => NLW_blk00000003_BCOUT_7_UNCONNECTED,
      BCOUT(6) => NLW_blk00000003_BCOUT_6_UNCONNECTED,
      BCOUT(5) => NLW_blk00000003_BCOUT_5_UNCONNECTED,
      BCOUT(4) => NLW_blk00000003_BCOUT_4_UNCONNECTED,
      BCOUT(3) => NLW_blk00000003_BCOUT_3_UNCONNECTED,
      BCOUT(2) => NLW_blk00000003_BCOUT_2_UNCONNECTED,
      BCOUT(1) => NLW_blk00000003_BCOUT_1_UNCONNECTED,
      BCOUT(0) => NLW_blk00000003_BCOUT_0_UNCONNECTED,
      PCIN(47) => sig00000002,
      PCIN(46) => sig00000002,
      PCIN(45) => sig00000002,
      PCIN(44) => sig00000002,
      PCIN(43) => sig00000002,
      PCIN(42) => sig00000002,
      PCIN(41) => sig00000002,
      PCIN(40) => sig00000002,
      PCIN(39) => sig00000002,
      PCIN(38) => sig00000002,
      PCIN(37) => sig00000002,
      PCIN(36) => sig00000002,
      PCIN(35) => sig00000002,
      PCIN(34) => sig00000002,
      PCIN(33) => sig00000002,
      PCIN(32) => sig00000002,
      PCIN(31) => sig00000002,
      PCIN(30) => sig00000002,
      PCIN(29) => sig00000002,
      PCIN(28) => sig00000002,
      PCIN(27) => sig00000002,
      PCIN(26) => sig00000002,
      PCIN(25) => sig00000002,
      PCIN(24) => sig00000002,
      PCIN(23) => sig00000002,
      PCIN(22) => sig00000002,
      PCIN(21) => sig00000002,
      PCIN(20) => sig00000002,
      PCIN(19) => sig00000002,
      PCIN(18) => sig00000002,
      PCIN(17) => sig00000002,
      PCIN(16) => sig00000002,
      PCIN(15) => sig00000002,
      PCIN(14) => sig00000002,
      PCIN(13) => sig00000002,
      PCIN(12) => sig00000002,
      PCIN(11) => sig00000002,
      PCIN(10) => sig00000002,
      PCIN(9) => sig00000002,
      PCIN(8) => sig00000002,
      PCIN(7) => sig00000002,
      PCIN(6) => sig00000002,
      PCIN(5) => sig00000002,
      PCIN(4) => sig00000002,
      PCIN(3) => sig00000002,
      PCIN(2) => sig00000002,
      PCIN(1) => sig00000002,
      PCIN(0) => sig00000002,
      C(47) => sig000000c4,
      C(46) => sig000000cc,
      C(45) => sig000000cc,
      C(44) => sig000000cc,
      C(43) => sig000000cc,
      C(42) => sig000000cc,
      C(41) => sig000000cc,
      C(40) => sig000000cc,
      C(39) => sig000000cc,
      C(38) => sig000000cc,
      C(37) => sig000000cc,
      C(36) => sig000000cc,
      C(35) => sig000000cc,
      C(34) => sig000000cc,
      C(33) => sig000000cb,
      C(32) => sig000000ca,
      C(31) => sig000000c9,
      C(30) => sig000000c8,
      C(29) => sig000000c7,
      C(28) => sig000000c6,
      C(27) => sig000000c5,
      C(26) => sig00000002,
      C(25) => sig00000002,
      C(24) => sig00000002,
      C(23) => sig000000c4,
      C(22) => sig000000d4,
      C(21) => sig000000d4,
      C(20) => sig000000d4,
      C(19) => sig000000d4,
      C(18) => sig000000d4,
      C(17) => sig000000d4,
      C(16) => sig000000d4,
      C(15) => sig000000d4,
      C(14) => sig000000d4,
      C(13) => sig000000d4,
      C(12) => sig000000d4,
      C(11) => sig000000d4,
      C(10) => sig000000d4,
      C(9) => sig000000d3,
      C(8) => sig000000d2,
      C(7) => sig000000d1,
      C(6) => sig000000d0,
      C(5) => sig000000cf,
      C(4) => sig000000ce,
      C(3) => sig000000cd,
      C(2) => sig00000002,
      C(1) => sig00000002,
      C(0) => sig00000002,
      P(47) => NLW_blk00000003_P_47_UNCONNECTED,
      P(46) => NLW_blk00000003_P_46_UNCONNECTED,
      P(45) => NLW_blk00000003_P_45_UNCONNECTED,
      P(44) => NLW_blk00000003_P_44_UNCONNECTED,
      P(43) => NLW_blk00000003_P_43_UNCONNECTED,
      P(42) => NLW_blk00000003_P_42_UNCONNECTED,
      P(41) => NLW_blk00000003_P_41_UNCONNECTED,
      P(40) => NLW_blk00000003_P_40_UNCONNECTED,
      P(39) => NLW_blk00000003_P_39_UNCONNECTED,
      P(38) => NLW_blk00000003_P_38_UNCONNECTED,
      P(37) => NLW_blk00000003_P_37_UNCONNECTED,
      P(36) => sig000000b6,
      P(35) => sig000000b5,
      P(34) => sig000000b4,
      P(33) => sig000000b3,
      P(32) => sig000000b2,
      P(31) => sig000000b1,
      P(30) => sig000000b0,
      P(29) => sig000000af,
      P(28) => sig000000ae,
      P(27) => sig000000ad,
      P(26) => sig000000ac,
      P(25) => sig000000ab,
      P(24) => sig000000aa,
      P(23) => NLW_blk00000003_P_23_UNCONNECTED,
      P(22) => NLW_blk00000003_P_22_UNCONNECTED,
      P(21) => NLW_blk00000003_P_21_UNCONNECTED,
      P(20) => NLW_blk00000003_P_20_UNCONNECTED,
      P(19) => NLW_blk00000003_P_19_UNCONNECTED,
      P(18) => NLW_blk00000003_P_18_UNCONNECTED,
      P(17) => NLW_blk00000003_P_17_UNCONNECTED,
      P(16) => NLW_blk00000003_P_16_UNCONNECTED,
      P(15) => NLW_blk00000003_P_15_UNCONNECTED,
      P(14) => NLW_blk00000003_P_14_UNCONNECTED,
      P(13) => NLW_blk00000003_P_13_UNCONNECTED,
      P(12) => sig000000c3,
      P(11) => sig000000c2,
      P(10) => sig000000c1,
      P(9) => sig000000c0,
      P(8) => sig000000bf,
      P(7) => sig000000be,
      P(6) => sig000000bd,
      P(5) => sig000000bc,
      P(4) => sig000000bb,
      P(3) => sig000000ba,
      P(2) => sig000000b9,
      P(1) => sig000000b8,
      P(0) => sig000000b7,
      OPMODE(7) => sig000000c4,
      OPMODE(6) => sig00000002,
      OPMODE(5) => sig00000002,
      OPMODE(4) => sig00000002,
      OPMODE(3) => sig00000001,
      OPMODE(2) => sig00000001,
      OPMODE(1) => sig00000001,
      OPMODE(0) => sig00000001,
      D(17) => sig00000002,
      D(16) => sig00000002,
      D(15) => sig00000002,
      D(14) => sig00000002,
      D(13) => sig00000002,
      D(12) => sig00000002,
      D(11) => sig00000002,
      D(10) => sig00000101,
      D(9) => sig00000101,
      D(8) => sig00000101,
      D(7) => sig00000101,
      D(6) => sig00000101,
      D(5) => sig00000101,
      D(4) => sig00000101,
      D(3) => sig00000101,
      D(2) => sig00000101,
      D(1) => sig00000101,
      D(0) => sig00000101,
      PCOUT(47) => NLW_blk00000003_PCOUT_47_UNCONNECTED,
      PCOUT(46) => NLW_blk00000003_PCOUT_46_UNCONNECTED,
      PCOUT(45) => NLW_blk00000003_PCOUT_45_UNCONNECTED,
      PCOUT(44) => NLW_blk00000003_PCOUT_44_UNCONNECTED,
      PCOUT(43) => NLW_blk00000003_PCOUT_43_UNCONNECTED,
      PCOUT(42) => NLW_blk00000003_PCOUT_42_UNCONNECTED,
      PCOUT(41) => NLW_blk00000003_PCOUT_41_UNCONNECTED,
      PCOUT(40) => NLW_blk00000003_PCOUT_40_UNCONNECTED,
      PCOUT(39) => NLW_blk00000003_PCOUT_39_UNCONNECTED,
      PCOUT(38) => NLW_blk00000003_PCOUT_38_UNCONNECTED,
      PCOUT(37) => NLW_blk00000003_PCOUT_37_UNCONNECTED,
      PCOUT(36) => NLW_blk00000003_PCOUT_36_UNCONNECTED,
      PCOUT(35) => NLW_blk00000003_PCOUT_35_UNCONNECTED,
      PCOUT(34) => NLW_blk00000003_PCOUT_34_UNCONNECTED,
      PCOUT(33) => NLW_blk00000003_PCOUT_33_UNCONNECTED,
      PCOUT(32) => NLW_blk00000003_PCOUT_32_UNCONNECTED,
      PCOUT(31) => NLW_blk00000003_PCOUT_31_UNCONNECTED,
      PCOUT(30) => NLW_blk00000003_PCOUT_30_UNCONNECTED,
      PCOUT(29) => NLW_blk00000003_PCOUT_29_UNCONNECTED,
      PCOUT(28) => NLW_blk00000003_PCOUT_28_UNCONNECTED,
      PCOUT(27) => NLW_blk00000003_PCOUT_27_UNCONNECTED,
      PCOUT(26) => NLW_blk00000003_PCOUT_26_UNCONNECTED,
      PCOUT(25) => NLW_blk00000003_PCOUT_25_UNCONNECTED,
      PCOUT(24) => NLW_blk00000003_PCOUT_24_UNCONNECTED,
      PCOUT(23) => NLW_blk00000003_PCOUT_23_UNCONNECTED,
      PCOUT(22) => NLW_blk00000003_PCOUT_22_UNCONNECTED,
      PCOUT(21) => NLW_blk00000003_PCOUT_21_UNCONNECTED,
      PCOUT(20) => NLW_blk00000003_PCOUT_20_UNCONNECTED,
      PCOUT(19) => NLW_blk00000003_PCOUT_19_UNCONNECTED,
      PCOUT(18) => NLW_blk00000003_PCOUT_18_UNCONNECTED,
      PCOUT(17) => NLW_blk00000003_PCOUT_17_UNCONNECTED,
      PCOUT(16) => NLW_blk00000003_PCOUT_16_UNCONNECTED,
      PCOUT(15) => NLW_blk00000003_PCOUT_15_UNCONNECTED,
      PCOUT(14) => NLW_blk00000003_PCOUT_14_UNCONNECTED,
      PCOUT(13) => NLW_blk00000003_PCOUT_13_UNCONNECTED,
      PCOUT(12) => NLW_blk00000003_PCOUT_12_UNCONNECTED,
      PCOUT(11) => NLW_blk00000003_PCOUT_11_UNCONNECTED,
      PCOUT(10) => NLW_blk00000003_PCOUT_10_UNCONNECTED,
      PCOUT(9) => NLW_blk00000003_PCOUT_9_UNCONNECTED,
      PCOUT(8) => NLW_blk00000003_PCOUT_8_UNCONNECTED,
      PCOUT(7) => NLW_blk00000003_PCOUT_7_UNCONNECTED,
      PCOUT(6) => NLW_blk00000003_PCOUT_6_UNCONNECTED,
      PCOUT(5) => NLW_blk00000003_PCOUT_5_UNCONNECTED,
      PCOUT(4) => NLW_blk00000003_PCOUT_4_UNCONNECTED,
      PCOUT(3) => NLW_blk00000003_PCOUT_3_UNCONNECTED,
      PCOUT(2) => NLW_blk00000003_PCOUT_2_UNCONNECTED,
      PCOUT(1) => NLW_blk00000003_PCOUT_1_UNCONNECTED,
      PCOUT(0) => NLW_blk00000003_PCOUT_0_UNCONNECTED,
      A(17) => sig00000101,
      A(16) => sig00000100,
      A(15) => sig000000ff,
      A(14) => sig000000fe,
      A(13) => sig000000fd,
      A(12) => sig000000fc,
      A(11) => sig000000fb,
      A(10) => sig000000fa,
      A(9) => sig000000f9,
      A(8) => sig000000f8,
      A(7) => sig000000f7,
      A(6) => sig000000f6,
      A(5) => sig00000002,
      A(4) => sig0000010d,
      A(3) => sig0000010d,
      A(2) => sig0000010d,
      A(1) => sig0000010d,
      A(0) => sig0000010d,
      M(35) => NLW_blk00000003_M_35_UNCONNECTED,
      M(34) => NLW_blk00000003_M_34_UNCONNECTED,
      M(33) => NLW_blk00000003_M_33_UNCONNECTED,
      M(32) => NLW_blk00000003_M_32_UNCONNECTED,
      M(31) => NLW_blk00000003_M_31_UNCONNECTED,
      M(30) => NLW_blk00000003_M_30_UNCONNECTED,
      M(29) => NLW_blk00000003_M_29_UNCONNECTED,
      M(28) => NLW_blk00000003_M_28_UNCONNECTED,
      M(27) => NLW_blk00000003_M_27_UNCONNECTED,
      M(26) => NLW_blk00000003_M_26_UNCONNECTED,
      M(25) => NLW_blk00000003_M_25_UNCONNECTED,
      M(24) => NLW_blk00000003_M_24_UNCONNECTED,
      M(23) => NLW_blk00000003_M_23_UNCONNECTED,
      M(22) => NLW_blk00000003_M_22_UNCONNECTED,
      M(21) => NLW_blk00000003_M_21_UNCONNECTED,
      M(20) => NLW_blk00000003_M_20_UNCONNECTED,
      M(19) => NLW_blk00000003_M_19_UNCONNECTED,
      M(18) => NLW_blk00000003_M_18_UNCONNECTED,
      M(17) => NLW_blk00000003_M_17_UNCONNECTED,
      M(16) => NLW_blk00000003_M_16_UNCONNECTED,
      M(15) => NLW_blk00000003_M_15_UNCONNECTED,
      M(14) => NLW_blk00000003_M_14_UNCONNECTED,
      M(13) => NLW_blk00000003_M_13_UNCONNECTED,
      M(12) => NLW_blk00000003_M_12_UNCONNECTED,
      M(11) => NLW_blk00000003_M_11_UNCONNECTED,
      M(10) => NLW_blk00000003_M_10_UNCONNECTED,
      M(9) => NLW_blk00000003_M_9_UNCONNECTED,
      M(8) => NLW_blk00000003_M_8_UNCONNECTED,
      M(7) => NLW_blk00000003_M_7_UNCONNECTED,
      M(6) => NLW_blk00000003_M_6_UNCONNECTED,
      M(5) => NLW_blk00000003_M_5_UNCONNECTED,
      M(4) => NLW_blk00000003_M_4_UNCONNECTED,
      M(3) => NLW_blk00000003_M_3_UNCONNECTED,
      M(2) => NLW_blk00000003_M_2_UNCONNECTED,
      M(1) => NLW_blk00000003_M_1_UNCONNECTED,
      M(0) => NLW_blk00000003_M_0_UNCONNECTED
    );
  blk00000004 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003e,
      D => sig00000031,
      R => sig00000041,
      Q => sig0000002d
    );
  blk00000005 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003e,
      D => sig00000032,
      R => sig00000041,
      Q => sig0000002e
    );
  blk00000006 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003e,
      D => sig00000033,
      R => sig00000041,
      Q => sig0000002f
    );
  blk00000007 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003e,
      D => sig00000034,
      R => sig00000041,
      Q => sig00000045
    );
  blk00000008 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003e,
      D => sig00000030,
      R => sig00000041,
      Q => sig00000044
    );
  blk00000009 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000003a,
      Q => sig00000098
    );
  blk0000000a : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000039,
      Q => sig00000099
    );
  blk0000000b : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000003c,
      R => sclr,
      Q => sig0000003b
    );
  blk0000000c : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000e5,
      Q => sig00000085
    );
  blk0000000d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000e4,
      Q => sig00000084
    );
  blk0000000e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000e3,
      Q => sig00000083
    );
  blk0000000f : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000e2,
      Q => sig00000082
    );
  blk00000010 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000e1,
      Q => sig00000081
    );
  blk00000011 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000e0,
      Q => sig00000080
    );
  blk00000012 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000df,
      Q => sig0000007f
    );
  blk00000013 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000de,
      Q => sig0000007e
    );
  blk00000014 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000f5,
      Q => sig00000095
    );
  blk00000015 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000f4,
      Q => sig00000094
    );
  blk00000016 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000f3,
      Q => sig00000093
    );
  blk00000017 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000f2,
      Q => sig00000092
    );
  blk00000018 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000f1,
      Q => sig00000091
    );
  blk00000019 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000f0,
      Q => sig00000090
    );
  blk0000001a : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ef,
      Q => sig0000008f
    );
  blk0000001b : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ee,
      Q => sig0000008e
    );
  blk0000001c : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ed,
      Q => sig0000008d
    );
  blk0000001d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ec,
      Q => sig0000008c
    );
  blk0000001e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000eb,
      Q => sig0000008b
    );
  blk0000001f : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ea,
      Q => sig0000008a
    );
  blk00000020 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000e9,
      Q => sig00000089
    );
  blk00000021 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000e8,
      Q => sig00000088
    );
  blk00000022 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000e7,
      Q => sig00000087
    );
  blk00000023 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000e6,
      Q => sig00000086
    );
  blk00000024 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000002d,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(4)
    );
  blk00000025 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000002e,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(3)
    );
  blk00000026 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000002f,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(2)
    );
  blk00000027 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000045,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(1)
    );
  blk00000028 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000044,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_BLK_EXP(0)
    );
  blk00000029 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b6,
      Q => sig00000057
    );
  blk0000002a : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b5,
      Q => sig00000056
    );
  blk0000002b : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b4,
      Q => sig00000055
    );
  blk0000002c : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b3,
      Q => sig00000054
    );
  blk0000002d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b2,
      Q => sig00000053
    );
  blk0000002e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b1,
      Q => sig00000052
    );
  blk0000002f : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b0,
      Q => sig00000051
    );
  blk00000030 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000af,
      Q => sig00000050
    );
  blk00000031 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ae,
      Q => sig0000004f
    );
  blk00000032 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ad,
      Q => sig0000004e
    );
  blk00000033 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ac,
      Q => sig0000004d
    );
  blk00000034 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ab,
      Q => sig0000004c
    );
  blk00000035 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000aa,
      Q => sig0000004b
    );
  blk00000036 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000c3,
      Q => sig00000064
    );
  blk00000037 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000c2,
      Q => sig00000063
    );
  blk00000038 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000c1,
      Q => sig00000062
    );
  blk00000039 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000c0,
      Q => sig00000061
    );
  blk0000003a : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000bf,
      Q => sig00000060
    );
  blk0000003b : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000be,
      Q => sig0000005f
    );
  blk0000003c : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000bd,
      Q => sig0000005e
    );
  blk0000003d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000bc,
      Q => sig0000005d
    );
  blk0000003e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000bb,
      Q => sig0000005c
    );
  blk0000003f : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000ba,
      Q => sig0000005b
    );
  blk00000040 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b9,
      Q => sig0000005a
    );
  blk00000041 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b8,
      Q => sig00000059
    );
  blk00000042 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000b7,
      Q => sig00000058
    );
  blk00000043 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000048,
      R => sclr,
      Q => sig00000046
    );
  blk00000044 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000dd,
      Q => sig0000006d
    );
  blk00000045 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000dc,
      Q => sig0000006c
    );
  blk00000046 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000db,
      Q => sig0000006b
    );
  blk00000047 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000da,
      Q => sig0000006a
    );
  blk00000048 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000d9,
      Q => sig00000069
    );
  blk00000049 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000d8,
      Q => sig00000068
    );
  blk0000004a : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000d7,
      Q => sig00000067
    );
  blk0000004b : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000d6,
      Q => sig00000066
    );
  blk0000004c : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000000d5,
      Q => sig00000065
    );
  blk0000004d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000dd,
      Q => sig0000007d
    );
  blk0000004e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000dc,
      Q => sig0000007c
    );
  blk0000004f : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000db,
      Q => sig0000007b
    );
  blk00000050 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000da,
      Q => sig0000007a
    );
  blk00000051 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000d9,
      Q => sig00000079
    );
  blk00000052 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000d8,
      Q => sig00000078
    );
  blk00000053 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000d7,
      Q => sig00000077
    );
  blk00000054 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000040,
      D => sig000000d6,
      Q => sig00000076
    );
  blk00000055 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000005,
      Q => sig00000049
    );
  blk00000056 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000003d,
      Q => sig0000004a
    );
  blk00000057 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000e5,
      Q => sig00000075
    );
  blk00000058 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000e4,
      Q => sig00000074
    );
  blk00000059 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000e3,
      Q => sig00000073
    );
  blk0000005a : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000e2,
      Q => sig00000072
    );
  blk0000005b : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000e1,
      Q => sig00000071
    );
  blk0000005c : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000e0,
      Q => sig00000070
    );
  blk0000005d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000df,
      Q => sig0000006f
    );
  blk0000005e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000003f,
      D => sig000000de,
      Q => sig0000006e
    );
  blk0000005f : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000024,
      Q => sig00000115
    );
  blk00000060 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000023,
      Q => sig00000114
    );
  blk00000061 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000022,
      Q => sig00000113
    );
  blk00000062 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000021,
      Q => sig00000112
    );
  blk00000063 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000020,
      Q => sig00000111
    );
  blk00000064 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000001f,
      Q => sig00000110
    );
  blk00000065 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000001e,
      Q => sig0000010f
    );
  blk00000066 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000001d,
      Q => sig0000010e
    );
  blk00000067 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000002c,
      Q => sig0000011d
    );
  blk00000068 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000002b,
      Q => sig0000011c
    );
  blk00000069 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000002a,
      Q => sig0000011b
    );
  blk0000006a : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000029,
      Q => sig0000011a
    );
  blk0000006b : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000028,
      Q => sig00000119
    );
  blk0000006c : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000027,
      Q => sig00000118
    );
  blk0000006d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000026,
      Q => sig00000117
    );
  blk0000006e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000025,
      Q => sig00000116
    );
  blk0000006f : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_im(7),
      Q => sig0000012e
    );
  blk00000070 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_im(6),
      Q => sig0000012f
    );
  blk00000071 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_im(5),
      Q => sig00000130
    );
  blk00000072 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_im(4),
      Q => sig00000131
    );
  blk00000073 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_im(3),
      Q => sig00000132
    );
  blk00000074 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_im(2),
      Q => sig00000133
    );
  blk00000075 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_im(1),
      Q => sig00000134
    );
  blk00000076 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_im(0),
      Q => sig00000135
    );
  blk00000077 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000012e,
      R => sig00000002,
      Q => sig00000125
    );
  blk00000078 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000012f,
      R => sig00000002,
      Q => sig00000124
    );
  blk00000079 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000130,
      R => sig00000002,
      Q => sig00000123
    );
  blk0000007a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000131,
      R => sig00000002,
      Q => sig00000122
    );
  blk0000007b : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000132,
      R => sig00000002,
      Q => sig00000121
    );
  blk0000007c : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000133,
      R => sig00000002,
      Q => sig00000120
    );
  blk0000007d : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000134,
      R => sig00000002,
      Q => sig0000011f
    );
  blk0000007e : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000135,
      R => sig00000002,
      Q => sig0000011e
    );
  blk0000007f : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_re(7),
      Q => sig00000136
    );
  blk00000080 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_re(6),
      Q => sig00000137
    );
  blk00000081 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_re(5),
      Q => sig00000138
    );
  blk00000082 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_re(4),
      Q => sig00000139
    );
  blk00000083 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_re(3),
      Q => sig0000013a
    );
  blk00000084 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_re(2),
      Q => sig0000013b
    );
  blk00000085 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_re(1),
      Q => sig0000013c
    );
  blk00000086 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => xn_re(0),
      Q => sig0000013d
    );
  blk00000087 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000136,
      R => sig00000002,
      Q => sig0000012d
    );
  blk00000088 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000137,
      R => sig00000002,
      Q => sig0000012c
    );
  blk00000089 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000138,
      R => sig00000002,
      Q => sig0000012b
    );
  blk0000008a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000139,
      R => sig00000002,
      Q => sig0000012a
    );
  blk0000008b : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000013a,
      R => sig00000002,
      Q => sig00000129
    );
  blk0000008c : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000013b,
      R => sig00000002,
      Q => sig00000128
    );
  blk0000008d : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000013c,
      R => sig00000002,
      Q => sig00000127
    );
  blk0000008e : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000013d,
      R => sig00000002,
      Q => sig00000126
    );
  blk0000008f : DSP48A1
    generic map(
      A0REG => 0,
      A1REG => 1,
      B0REG => 0,
      B1REG => 1,
      CARRYINREG => 1,
      CARRYINSEL => "OPMODE5",
      CREG => 0,
      DREG => 0,
      MREG => 1,
      OPMODEREG => 1,
      PREG => 1,
      RSTTYPE => "SYNC",
      CARRYOUTREG => 0
    )
    port map (
      CECARRYIN => sig00000002,
      RSTC => sig00000002,
      RSTCARRYIN => sig00000002,
      CED => sig00000002,
      RSTD => sig00000002,
      CEOPMODE => ce,
      CEC => sig00000002,
      CARRYOUTF => NLW_blk0000008f_CARRYOUTF_UNCONNECTED,
      RSTOPMODE => sig00000002,
      RSTM => sig00000002,
      CLK => clk,
      RSTB => sig00000002,
      CEM => ce,
      CEB => ce,
      CARRYIN => sig00000002,
      CEP => ce,
      CEA => ce,
      CARRYOUT => NLW_blk0000008f_CARRYOUT_UNCONNECTED,
      RSTA => sig00000002,
      RSTP => sig00000002,
      B(17) => sig00000180,
      B(16) => sig00000180,
      B(15) => sig00000180,
      B(14) => sig00000180,
      B(13) => sig00000180,
      B(12) => sig00000180,
      B(11) => sig00000180,
      B(10) => sig00000180,
      B(9) => sig00000180,
      B(8) => sig00000180,
      B(7) => sig00000180,
      B(6) => sig0000017f,
      B(5) => sig0000017e,
      B(4) => sig0000017d,
      B(3) => sig0000017c,
      B(2) => sig0000017b,
      B(1) => sig0000017a,
      B(0) => sig00000179,
      BCOUT(17) => NLW_blk0000008f_BCOUT_17_UNCONNECTED,
      BCOUT(16) => NLW_blk0000008f_BCOUT_16_UNCONNECTED,
      BCOUT(15) => NLW_blk0000008f_BCOUT_15_UNCONNECTED,
      BCOUT(14) => NLW_blk0000008f_BCOUT_14_UNCONNECTED,
      BCOUT(13) => NLW_blk0000008f_BCOUT_13_UNCONNECTED,
      BCOUT(12) => NLW_blk0000008f_BCOUT_12_UNCONNECTED,
      BCOUT(11) => NLW_blk0000008f_BCOUT_11_UNCONNECTED,
      BCOUT(10) => NLW_blk0000008f_BCOUT_10_UNCONNECTED,
      BCOUT(9) => NLW_blk0000008f_BCOUT_9_UNCONNECTED,
      BCOUT(8) => NLW_blk0000008f_BCOUT_8_UNCONNECTED,
      BCOUT(7) => NLW_blk0000008f_BCOUT_7_UNCONNECTED,
      BCOUT(6) => NLW_blk0000008f_BCOUT_6_UNCONNECTED,
      BCOUT(5) => NLW_blk0000008f_BCOUT_5_UNCONNECTED,
      BCOUT(4) => NLW_blk0000008f_BCOUT_4_UNCONNECTED,
      BCOUT(3) => NLW_blk0000008f_BCOUT_3_UNCONNECTED,
      BCOUT(2) => NLW_blk0000008f_BCOUT_2_UNCONNECTED,
      BCOUT(1) => NLW_blk0000008f_BCOUT_1_UNCONNECTED,
      BCOUT(0) => NLW_blk0000008f_BCOUT_0_UNCONNECTED,
      PCIN(47) => sig00000002,
      PCIN(46) => sig00000002,
      PCIN(45) => sig00000002,
      PCIN(44) => sig00000002,
      PCIN(43) => sig00000002,
      PCIN(42) => sig00000002,
      PCIN(41) => sig00000002,
      PCIN(40) => sig00000002,
      PCIN(39) => sig00000002,
      PCIN(38) => sig00000002,
      PCIN(37) => sig00000002,
      PCIN(36) => sig00000002,
      PCIN(35) => sig00000002,
      PCIN(34) => sig00000002,
      PCIN(33) => sig00000002,
      PCIN(32) => sig00000002,
      PCIN(31) => sig00000002,
      PCIN(30) => sig00000002,
      PCIN(29) => sig00000002,
      PCIN(28) => sig00000002,
      PCIN(27) => sig00000002,
      PCIN(26) => sig00000002,
      PCIN(25) => sig00000002,
      PCIN(24) => sig00000002,
      PCIN(23) => sig00000002,
      PCIN(22) => sig00000002,
      PCIN(21) => sig00000002,
      PCIN(20) => sig00000002,
      PCIN(19) => sig00000002,
      PCIN(18) => sig00000002,
      PCIN(17) => sig00000002,
      PCIN(16) => sig00000002,
      PCIN(15) => sig00000002,
      PCIN(14) => sig00000002,
      PCIN(13) => sig00000002,
      PCIN(12) => sig00000002,
      PCIN(11) => sig00000002,
      PCIN(10) => sig00000002,
      PCIN(9) => sig00000002,
      PCIN(8) => sig00000002,
      PCIN(7) => sig00000002,
      PCIN(6) => sig00000002,
      PCIN(5) => sig00000002,
      PCIN(4) => sig00000002,
      PCIN(3) => sig00000002,
      PCIN(2) => sig00000002,
      PCIN(1) => sig00000002,
      PCIN(0) => sig00000002,
      C(47) => sig00000002,
      C(46) => sig00000002,
      C(45) => sig00000002,
      C(44) => sig00000002,
      C(43) => sig00000002,
      C(42) => sig00000002,
      C(41) => sig00000002,
      C(40) => sig00000002,
      C(39) => sig00000002,
      C(38) => sig00000002,
      C(37) => sig00000002,
      C(36) => sig00000002,
      C(35) => sig00000002,
      C(34) => sig00000002,
      C(33) => sig00000002,
      C(32) => sig00000002,
      C(31) => sig00000002,
      C(30) => sig00000002,
      C(29) => sig00000002,
      C(28) => sig00000002,
      C(27) => sig00000002,
      C(26) => sig00000002,
      C(25) => sig00000002,
      C(24) => sig00000002,
      C(23) => sig00000002,
      C(22) => sig00000002,
      C(21) => sig00000002,
      C(20) => sig00000002,
      C(19) => sig00000002,
      C(18) => sig00000002,
      C(17) => sig00000002,
      C(16) => sig00000002,
      C(15) => sig00000002,
      C(14) => sig00000002,
      C(13) => sig00000002,
      C(12) => sig00000002,
      C(11) => sig00000002,
      C(10) => sig00000002,
      C(9) => sig00000002,
      C(8) => sig00000002,
      C(7) => sig00000002,
      C(6) => sig00000002,
      C(5) => sig00000002,
      C(4) => sig00000002,
      C(3) => sig00000002,
      C(2) => sig00000001,
      C(1) => sig00000001,
      C(0) => sig00000001,
      P(47) => NLW_blk0000008f_P_47_UNCONNECTED,
      P(46) => NLW_blk0000008f_P_46_UNCONNECTED,
      P(45) => NLW_blk0000008f_P_45_UNCONNECTED,
      P(44) => NLW_blk0000008f_P_44_UNCONNECTED,
      P(43) => NLW_blk0000008f_P_43_UNCONNECTED,
      P(42) => NLW_blk0000008f_P_42_UNCONNECTED,
      P(41) => NLW_blk0000008f_P_41_UNCONNECTED,
      P(40) => NLW_blk0000008f_P_40_UNCONNECTED,
      P(39) => NLW_blk0000008f_P_39_UNCONNECTED,
      P(38) => NLW_blk0000008f_P_38_UNCONNECTED,
      P(37) => NLW_blk0000008f_P_37_UNCONNECTED,
      P(36) => NLW_blk0000008f_P_36_UNCONNECTED,
      P(35) => NLW_blk0000008f_P_35_UNCONNECTED,
      P(34) => NLW_blk0000008f_P_34_UNCONNECTED,
      P(33) => NLW_blk0000008f_P_33_UNCONNECTED,
      P(32) => NLW_blk0000008f_P_32_UNCONNECTED,
      P(31) => NLW_blk0000008f_P_31_UNCONNECTED,
      P(30) => NLW_blk0000008f_P_30_UNCONNECTED,
      P(29) => NLW_blk0000008f_P_29_UNCONNECTED,
      P(28) => NLW_blk0000008f_P_28_UNCONNECTED,
      P(27) => NLW_blk0000008f_P_27_UNCONNECTED,
      P(26) => NLW_blk0000008f_P_26_UNCONNECTED,
      P(25) => NLW_blk0000008f_P_25_UNCONNECTED,
      P(24) => NLW_blk0000008f_P_24_UNCONNECTED,
      P(23) => NLW_blk0000008f_P_23_UNCONNECTED,
      P(22) => NLW_blk0000008f_P_22_UNCONNECTED,
      P(21) => NLW_blk0000008f_P_21_UNCONNECTED,
      P(20) => NLW_blk0000008f_P_20_UNCONNECTED,
      P(19) => NLW_blk0000008f_P_19_UNCONNECTED,
      P(18) => NLW_blk0000008f_P_18_UNCONNECTED,
      P(17) => NLW_blk0000008f_P_17_UNCONNECTED,
      P(16) => NLW_blk0000008f_P_16_UNCONNECTED,
      P(15) => NLW_blk0000008f_P_15_UNCONNECTED,
      P(14) => NLW_blk0000008f_P_14_UNCONNECTED,
      P(13) => NLW_blk0000008f_P_13_UNCONNECTED,
      P(12) => NLW_blk0000008f_P_12_UNCONNECTED,
      P(11) => NLW_blk0000008f_P_11_UNCONNECTED,
      P(10) => NLW_blk0000008f_P_10_UNCONNECTED,
      P(9) => NLW_blk0000008f_P_9_UNCONNECTED,
      P(8) => NLW_blk0000008f_P_8_UNCONNECTED,
      P(7) => NLW_blk0000008f_P_7_UNCONNECTED,
      P(6) => NLW_blk0000008f_P_6_UNCONNECTED,
      P(5) => NLW_blk0000008f_P_5_UNCONNECTED,
      P(4) => NLW_blk0000008f_P_4_UNCONNECTED,
      P(3) => NLW_blk0000008f_P_3_UNCONNECTED,
      P(2) => NLW_blk0000008f_P_2_UNCONNECTED,
      P(1) => NLW_blk0000008f_P_1_UNCONNECTED,
      P(0) => NLW_blk0000008f_P_0_UNCONNECTED,
      OPMODE(7) => sig00000002,
      OPMODE(6) => sig00000002,
      OPMODE(5) => sig00000002,
      OPMODE(4) => sig00000002,
      OPMODE(3) => sig00000001,
      OPMODE(2) => sig00000001,
      OPMODE(1) => sig00000002,
      OPMODE(0) => sig00000001,
      D(17) => sig00000002,
      D(16) => sig00000002,
      D(15) => sig00000002,
      D(14) => sig00000002,
      D(13) => sig00000002,
      D(12) => sig00000002,
      D(11) => sig00000002,
      D(10) => sig00000002,
      D(9) => sig00000002,
      D(8) => sig00000002,
      D(7) => sig00000002,
      D(6) => sig00000002,
      D(5) => sig00000002,
      D(4) => sig00000002,
      D(3) => sig00000002,
      D(2) => sig00000002,
      D(1) => sig00000002,
      D(0) => sig00000002,
      PCOUT(47) => sig0000013f,
      PCOUT(46) => sig00000140,
      PCOUT(45) => sig00000141,
      PCOUT(44) => sig00000142,
      PCOUT(43) => sig00000143,
      PCOUT(42) => sig00000144,
      PCOUT(41) => sig00000145,
      PCOUT(40) => sig00000146,
      PCOUT(39) => sig00000147,
      PCOUT(38) => sig00000148,
      PCOUT(37) => sig00000149,
      PCOUT(36) => sig0000014a,
      PCOUT(35) => sig0000014b,
      PCOUT(34) => sig0000014c,
      PCOUT(33) => sig0000014d,
      PCOUT(32) => sig0000014e,
      PCOUT(31) => sig0000014f,
      PCOUT(30) => sig00000150,
      PCOUT(29) => sig00000151,
      PCOUT(28) => sig00000152,
      PCOUT(27) => sig00000153,
      PCOUT(26) => sig00000154,
      PCOUT(25) => sig00000155,
      PCOUT(24) => sig00000156,
      PCOUT(23) => sig00000157,
      PCOUT(22) => sig00000158,
      PCOUT(21) => sig00000159,
      PCOUT(20) => sig0000015a,
      PCOUT(19) => sig0000015b,
      PCOUT(18) => sig0000015c,
      PCOUT(17) => sig0000015d,
      PCOUT(16) => sig0000015e,
      PCOUT(15) => sig0000015f,
      PCOUT(14) => sig00000160,
      PCOUT(13) => sig00000161,
      PCOUT(12) => sig00000162,
      PCOUT(11) => sig00000163,
      PCOUT(10) => sig00000164,
      PCOUT(9) => sig00000165,
      PCOUT(8) => sig00000166,
      PCOUT(7) => sig00000167,
      PCOUT(6) => sig00000168,
      PCOUT(5) => sig00000169,
      PCOUT(4) => sig0000016a,
      PCOUT(3) => sig0000016b,
      PCOUT(2) => sig0000016c,
      PCOUT(1) => sig0000016d,
      PCOUT(0) => sig0000016e,
      A(17) => sig0000019e,
      A(16) => sig0000019e,
      A(15) => sig0000019e,
      A(14) => sig0000019e,
      A(13) => sig0000019e,
      A(12) => sig0000019e,
      A(11) => sig0000019e,
      A(10) => sig0000019e,
      A(9) => sig0000019e,
      A(8) => sig0000019e,
      A(7) => sig0000019d,
      A(6) => sig0000019c,
      A(5) => sig0000019b,
      A(4) => sig0000019a,
      A(3) => sig00000199,
      A(2) => sig00000198,
      A(1) => sig00000197,
      A(0) => sig00000196,
      M(35) => NLW_blk0000008f_M_35_UNCONNECTED,
      M(34) => NLW_blk0000008f_M_34_UNCONNECTED,
      M(33) => NLW_blk0000008f_M_33_UNCONNECTED,
      M(32) => NLW_blk0000008f_M_32_UNCONNECTED,
      M(31) => NLW_blk0000008f_M_31_UNCONNECTED,
      M(30) => NLW_blk0000008f_M_30_UNCONNECTED,
      M(29) => NLW_blk0000008f_M_29_UNCONNECTED,
      M(28) => NLW_blk0000008f_M_28_UNCONNECTED,
      M(27) => NLW_blk0000008f_M_27_UNCONNECTED,
      M(26) => NLW_blk0000008f_M_26_UNCONNECTED,
      M(25) => NLW_blk0000008f_M_25_UNCONNECTED,
      M(24) => NLW_blk0000008f_M_24_UNCONNECTED,
      M(23) => NLW_blk0000008f_M_23_UNCONNECTED,
      M(22) => NLW_blk0000008f_M_22_UNCONNECTED,
      M(21) => NLW_blk0000008f_M_21_UNCONNECTED,
      M(20) => NLW_blk0000008f_M_20_UNCONNECTED,
      M(19) => NLW_blk0000008f_M_19_UNCONNECTED,
      M(18) => NLW_blk0000008f_M_18_UNCONNECTED,
      M(17) => NLW_blk0000008f_M_17_UNCONNECTED,
      M(16) => NLW_blk0000008f_M_16_UNCONNECTED,
      M(15) => NLW_blk0000008f_M_15_UNCONNECTED,
      M(14) => NLW_blk0000008f_M_14_UNCONNECTED,
      M(13) => NLW_blk0000008f_M_13_UNCONNECTED,
      M(12) => NLW_blk0000008f_M_12_UNCONNECTED,
      M(11) => NLW_blk0000008f_M_11_UNCONNECTED,
      M(10) => NLW_blk0000008f_M_10_UNCONNECTED,
      M(9) => NLW_blk0000008f_M_9_UNCONNECTED,
      M(8) => NLW_blk0000008f_M_8_UNCONNECTED,
      M(7) => NLW_blk0000008f_M_7_UNCONNECTED,
      M(6) => NLW_blk0000008f_M_6_UNCONNECTED,
      M(5) => NLW_blk0000008f_M_5_UNCONNECTED,
      M(4) => NLW_blk0000008f_M_4_UNCONNECTED,
      M(3) => NLW_blk0000008f_M_3_UNCONNECTED,
      M(2) => NLW_blk0000008f_M_2_UNCONNECTED,
      M(1) => NLW_blk0000008f_M_1_UNCONNECTED,
      M(0) => NLW_blk0000008f_M_0_UNCONNECTED
    );
  blk00000090 : DSP48A1
    generic map(
      A0REG => 1,
      A1REG => 1,
      B0REG => 1,
      B1REG => 1,
      CARRYINREG => 0,
      CARRYINSEL => "OPMODE5",
      CREG => 0,
      DREG => 0,
      MREG => 1,
      OPMODEREG => 1,
      PREG => 1,
      RSTTYPE => "SYNC",
      CARRYOUTREG => 0
    )
    port map (
      CECARRYIN => sig00000002,
      RSTC => sig00000002,
      RSTCARRYIN => sig00000002,
      CED => sig00000002,
      RSTD => sig00000002,
      CEOPMODE => ce,
      CEC => sig00000002,
      CARRYOUTF => NLW_blk00000090_CARRYOUTF_UNCONNECTED,
      RSTOPMODE => sig00000002,
      RSTM => sig00000002,
      CLK => clk,
      RSTB => sig00000002,
      CEM => ce,
      CEB => ce,
      CARRYIN => sig00000002,
      CEP => ce,
      CEA => ce,
      CARRYOUT => NLW_blk00000090_CARRYOUT_UNCONNECTED,
      RSTA => sig00000002,
      RSTP => sig00000002,
      B(17) => sig00000178,
      B(16) => sig00000178,
      B(15) => sig00000178,
      B(14) => sig00000178,
      B(13) => sig00000178,
      B(12) => sig00000178,
      B(11) => sig00000178,
      B(10) => sig00000178,
      B(9) => sig00000178,
      B(8) => sig00000178,
      B(7) => sig00000178,
      B(6) => sig00000177,
      B(5) => sig00000176,
      B(4) => sig00000175,
      B(3) => sig00000174,
      B(2) => sig00000173,
      B(1) => sig00000172,
      B(0) => sig00000171,
      BCOUT(17) => NLW_blk00000090_BCOUT_17_UNCONNECTED,
      BCOUT(16) => NLW_blk00000090_BCOUT_16_UNCONNECTED,
      BCOUT(15) => NLW_blk00000090_BCOUT_15_UNCONNECTED,
      BCOUT(14) => NLW_blk00000090_BCOUT_14_UNCONNECTED,
      BCOUT(13) => NLW_blk00000090_BCOUT_13_UNCONNECTED,
      BCOUT(12) => NLW_blk00000090_BCOUT_12_UNCONNECTED,
      BCOUT(11) => NLW_blk00000090_BCOUT_11_UNCONNECTED,
      BCOUT(10) => NLW_blk00000090_BCOUT_10_UNCONNECTED,
      BCOUT(9) => NLW_blk00000090_BCOUT_9_UNCONNECTED,
      BCOUT(8) => NLW_blk00000090_BCOUT_8_UNCONNECTED,
      BCOUT(7) => NLW_blk00000090_BCOUT_7_UNCONNECTED,
      BCOUT(6) => NLW_blk00000090_BCOUT_6_UNCONNECTED,
      BCOUT(5) => NLW_blk00000090_BCOUT_5_UNCONNECTED,
      BCOUT(4) => NLW_blk00000090_BCOUT_4_UNCONNECTED,
      BCOUT(3) => NLW_blk00000090_BCOUT_3_UNCONNECTED,
      BCOUT(2) => NLW_blk00000090_BCOUT_2_UNCONNECTED,
      BCOUT(1) => NLW_blk00000090_BCOUT_1_UNCONNECTED,
      BCOUT(0) => NLW_blk00000090_BCOUT_0_UNCONNECTED,
      PCIN(47) => sig0000013f,
      PCIN(46) => sig00000140,
      PCIN(45) => sig00000141,
      PCIN(44) => sig00000142,
      PCIN(43) => sig00000143,
      PCIN(42) => sig00000144,
      PCIN(41) => sig00000145,
      PCIN(40) => sig00000146,
      PCIN(39) => sig00000147,
      PCIN(38) => sig00000148,
      PCIN(37) => sig00000149,
      PCIN(36) => sig0000014a,
      PCIN(35) => sig0000014b,
      PCIN(34) => sig0000014c,
      PCIN(33) => sig0000014d,
      PCIN(32) => sig0000014e,
      PCIN(31) => sig0000014f,
      PCIN(30) => sig00000150,
      PCIN(29) => sig00000151,
      PCIN(28) => sig00000152,
      PCIN(27) => sig00000153,
      PCIN(26) => sig00000154,
      PCIN(25) => sig00000155,
      PCIN(24) => sig00000156,
      PCIN(23) => sig00000157,
      PCIN(22) => sig00000158,
      PCIN(21) => sig00000159,
      PCIN(20) => sig0000015a,
      PCIN(19) => sig0000015b,
      PCIN(18) => sig0000015c,
      PCIN(17) => sig0000015d,
      PCIN(16) => sig0000015e,
      PCIN(15) => sig0000015f,
      PCIN(14) => sig00000160,
      PCIN(13) => sig00000161,
      PCIN(12) => sig00000162,
      PCIN(11) => sig00000163,
      PCIN(10) => sig00000164,
      PCIN(9) => sig00000165,
      PCIN(8) => sig00000166,
      PCIN(7) => sig00000167,
      PCIN(6) => sig00000168,
      PCIN(5) => sig00000169,
      PCIN(4) => sig0000016a,
      PCIN(3) => sig0000016b,
      PCIN(2) => sig0000016c,
      PCIN(1) => sig0000016d,
      PCIN(0) => sig0000016e,
      C(47) => sig00000001,
      C(46) => sig00000001,
      C(45) => sig00000001,
      C(44) => sig00000001,
      C(43) => sig00000001,
      C(42) => sig00000001,
      C(41) => sig00000001,
      C(40) => sig00000001,
      C(39) => sig00000001,
      C(38) => sig00000001,
      C(37) => sig00000001,
      C(36) => sig00000001,
      C(35) => sig00000001,
      C(34) => sig00000001,
      C(33) => sig00000001,
      C(32) => sig00000001,
      C(31) => sig00000001,
      C(30) => sig00000001,
      C(29) => sig00000001,
      C(28) => sig00000001,
      C(27) => sig00000001,
      C(26) => sig00000001,
      C(25) => sig00000001,
      C(24) => sig00000001,
      C(23) => sig00000001,
      C(22) => sig00000001,
      C(21) => sig00000001,
      C(20) => sig00000001,
      C(19) => sig00000001,
      C(18) => sig00000001,
      C(17) => sig00000001,
      C(16) => sig00000001,
      C(15) => sig00000001,
      C(14) => sig00000001,
      C(13) => sig00000001,
      C(12) => sig00000001,
      C(11) => sig00000001,
      C(10) => sig00000001,
      C(9) => sig00000001,
      C(8) => sig00000001,
      C(7) => sig00000001,
      C(6) => sig00000001,
      C(5) => sig00000001,
      C(4) => sig00000001,
      C(3) => sig00000001,
      C(2) => sig00000001,
      C(1) => sig00000001,
      C(0) => sig00000001,
      P(47) => NLW_blk00000090_P_47_UNCONNECTED,
      P(46) => NLW_blk00000090_P_46_UNCONNECTED,
      P(45) => NLW_blk00000090_P_45_UNCONNECTED,
      P(44) => NLW_blk00000090_P_44_UNCONNECTED,
      P(43) => NLW_blk00000090_P_43_UNCONNECTED,
      P(42) => NLW_blk00000090_P_42_UNCONNECTED,
      P(41) => NLW_blk00000090_P_41_UNCONNECTED,
      P(40) => NLW_blk00000090_P_40_UNCONNECTED,
      P(39) => NLW_blk00000090_P_39_UNCONNECTED,
      P(38) => NLW_blk00000090_P_38_UNCONNECTED,
      P(37) => NLW_blk00000090_P_37_UNCONNECTED,
      P(36) => NLW_blk00000090_P_36_UNCONNECTED,
      P(35) => NLW_blk00000090_P_35_UNCONNECTED,
      P(34) => NLW_blk00000090_P_34_UNCONNECTED,
      P(33) => NLW_blk00000090_P_33_UNCONNECTED,
      P(32) => NLW_blk00000090_P_32_UNCONNECTED,
      P(31) => NLW_blk00000090_P_31_UNCONNECTED,
      P(30) => NLW_blk00000090_P_30_UNCONNECTED,
      P(29) => NLW_blk00000090_P_29_UNCONNECTED,
      P(28) => NLW_blk00000090_P_28_UNCONNECTED,
      P(27) => NLW_blk00000090_P_27_UNCONNECTED,
      P(26) => NLW_blk00000090_P_26_UNCONNECTED,
      P(25) => NLW_blk00000090_P_25_UNCONNECTED,
      P(24) => NLW_blk00000090_P_24_UNCONNECTED,
      P(23) => NLW_blk00000090_P_23_UNCONNECTED,
      P(22) => NLW_blk00000090_P_22_UNCONNECTED,
      P(21) => NLW_blk00000090_P_21_UNCONNECTED,
      P(20) => NLW_blk00000090_P_20_UNCONNECTED,
      P(19) => NLW_blk00000090_P_19_UNCONNECTED,
      P(18) => NLW_blk00000090_P_18_UNCONNECTED,
      P(17) => NLW_blk00000090_P_17_UNCONNECTED,
      P(16) => NLW_blk00000090_P_16_UNCONNECTED,
      P(15) => sig0000018c,
      P(14) => sig0000018b,
      P(13) => sig0000018a,
      P(12) => sig00000189,
      P(11) => sig00000188,
      P(10) => sig00000187,
      P(9) => sig00000186,
      P(8) => sig00000185,
      P(7) => sig00000184,
      P(6) => sig00000183,
      P(5) => sig00000182,
      P(4) => sig00000181,
      P(3) => NLW_blk00000090_P_3_UNCONNECTED,
      P(2) => NLW_blk00000090_P_2_UNCONNECTED,
      P(1) => NLW_blk00000090_P_1_UNCONNECTED,
      P(0) => NLW_blk00000090_P_0_UNCONNECTED,
      OPMODE(7) => sig0000013e,
      OPMODE(6) => sig00000002,
      OPMODE(5) => sig00000002,
      OPMODE(4) => sig00000002,
      OPMODE(3) => sig00000002,
      OPMODE(2) => sig00000001,
      OPMODE(1) => sig00000002,
      OPMODE(0) => sig00000001,
      D(17) => sig00000002,
      D(16) => sig00000002,
      D(15) => sig00000002,
      D(14) => sig00000002,
      D(13) => sig00000002,
      D(12) => sig00000002,
      D(11) => sig00000002,
      D(10) => sig00000002,
      D(9) => sig00000002,
      D(8) => sig00000002,
      D(7) => sig00000002,
      D(6) => sig00000002,
      D(5) => sig00000002,
      D(4) => sig00000002,
      D(3) => sig00000002,
      D(2) => sig00000002,
      D(1) => sig00000002,
      D(0) => sig00000002,
      PCOUT(47) => NLW_blk00000090_PCOUT_47_UNCONNECTED,
      PCOUT(46) => NLW_blk00000090_PCOUT_46_UNCONNECTED,
      PCOUT(45) => NLW_blk00000090_PCOUT_45_UNCONNECTED,
      PCOUT(44) => NLW_blk00000090_PCOUT_44_UNCONNECTED,
      PCOUT(43) => NLW_blk00000090_PCOUT_43_UNCONNECTED,
      PCOUT(42) => NLW_blk00000090_PCOUT_42_UNCONNECTED,
      PCOUT(41) => NLW_blk00000090_PCOUT_41_UNCONNECTED,
      PCOUT(40) => NLW_blk00000090_PCOUT_40_UNCONNECTED,
      PCOUT(39) => NLW_blk00000090_PCOUT_39_UNCONNECTED,
      PCOUT(38) => NLW_blk00000090_PCOUT_38_UNCONNECTED,
      PCOUT(37) => NLW_blk00000090_PCOUT_37_UNCONNECTED,
      PCOUT(36) => NLW_blk00000090_PCOUT_36_UNCONNECTED,
      PCOUT(35) => NLW_blk00000090_PCOUT_35_UNCONNECTED,
      PCOUT(34) => NLW_blk00000090_PCOUT_34_UNCONNECTED,
      PCOUT(33) => NLW_blk00000090_PCOUT_33_UNCONNECTED,
      PCOUT(32) => NLW_blk00000090_PCOUT_32_UNCONNECTED,
      PCOUT(31) => NLW_blk00000090_PCOUT_31_UNCONNECTED,
      PCOUT(30) => NLW_blk00000090_PCOUT_30_UNCONNECTED,
      PCOUT(29) => NLW_blk00000090_PCOUT_29_UNCONNECTED,
      PCOUT(28) => NLW_blk00000090_PCOUT_28_UNCONNECTED,
      PCOUT(27) => NLW_blk00000090_PCOUT_27_UNCONNECTED,
      PCOUT(26) => NLW_blk00000090_PCOUT_26_UNCONNECTED,
      PCOUT(25) => NLW_blk00000090_PCOUT_25_UNCONNECTED,
      PCOUT(24) => NLW_blk00000090_PCOUT_24_UNCONNECTED,
      PCOUT(23) => NLW_blk00000090_PCOUT_23_UNCONNECTED,
      PCOUT(22) => NLW_blk00000090_PCOUT_22_UNCONNECTED,
      PCOUT(21) => NLW_blk00000090_PCOUT_21_UNCONNECTED,
      PCOUT(20) => NLW_blk00000090_PCOUT_20_UNCONNECTED,
      PCOUT(19) => NLW_blk00000090_PCOUT_19_UNCONNECTED,
      PCOUT(18) => NLW_blk00000090_PCOUT_18_UNCONNECTED,
      PCOUT(17) => NLW_blk00000090_PCOUT_17_UNCONNECTED,
      PCOUT(16) => NLW_blk00000090_PCOUT_16_UNCONNECTED,
      PCOUT(15) => NLW_blk00000090_PCOUT_15_UNCONNECTED,
      PCOUT(14) => NLW_blk00000090_PCOUT_14_UNCONNECTED,
      PCOUT(13) => NLW_blk00000090_PCOUT_13_UNCONNECTED,
      PCOUT(12) => NLW_blk00000090_PCOUT_12_UNCONNECTED,
      PCOUT(11) => NLW_blk00000090_PCOUT_11_UNCONNECTED,
      PCOUT(10) => NLW_blk00000090_PCOUT_10_UNCONNECTED,
      PCOUT(9) => NLW_blk00000090_PCOUT_9_UNCONNECTED,
      PCOUT(8) => NLW_blk00000090_PCOUT_8_UNCONNECTED,
      PCOUT(7) => NLW_blk00000090_PCOUT_7_UNCONNECTED,
      PCOUT(6) => NLW_blk00000090_PCOUT_6_UNCONNECTED,
      PCOUT(5) => NLW_blk00000090_PCOUT_5_UNCONNECTED,
      PCOUT(4) => NLW_blk00000090_PCOUT_4_UNCONNECTED,
      PCOUT(3) => NLW_blk00000090_PCOUT_3_UNCONNECTED,
      PCOUT(2) => NLW_blk00000090_PCOUT_2_UNCONNECTED,
      PCOUT(1) => NLW_blk00000090_PCOUT_1_UNCONNECTED,
      PCOUT(0) => NLW_blk00000090_PCOUT_0_UNCONNECTED,
      A(17) => sig00000195,
      A(16) => sig00000195,
      A(15) => sig00000195,
      A(14) => sig00000195,
      A(13) => sig00000195,
      A(12) => sig00000195,
      A(11) => sig00000195,
      A(10) => sig00000195,
      A(9) => sig00000195,
      A(8) => sig00000195,
      A(7) => sig00000194,
      A(6) => sig00000193,
      A(5) => sig00000192,
      A(4) => sig00000191,
      A(3) => sig00000190,
      A(2) => sig0000018f,
      A(1) => sig0000018e,
      A(0) => sig0000018d,
      M(35) => NLW_blk00000090_M_35_UNCONNECTED,
      M(34) => NLW_blk00000090_M_34_UNCONNECTED,
      M(33) => NLW_blk00000090_M_33_UNCONNECTED,
      M(32) => NLW_blk00000090_M_32_UNCONNECTED,
      M(31) => NLW_blk00000090_M_31_UNCONNECTED,
      M(30) => NLW_blk00000090_M_30_UNCONNECTED,
      M(29) => NLW_blk00000090_M_29_UNCONNECTED,
      M(28) => NLW_blk00000090_M_28_UNCONNECTED,
      M(27) => NLW_blk00000090_M_27_UNCONNECTED,
      M(26) => NLW_blk00000090_M_26_UNCONNECTED,
      M(25) => NLW_blk00000090_M_25_UNCONNECTED,
      M(24) => NLW_blk00000090_M_24_UNCONNECTED,
      M(23) => NLW_blk00000090_M_23_UNCONNECTED,
      M(22) => NLW_blk00000090_M_22_UNCONNECTED,
      M(21) => NLW_blk00000090_M_21_UNCONNECTED,
      M(20) => NLW_blk00000090_M_20_UNCONNECTED,
      M(19) => NLW_blk00000090_M_19_UNCONNECTED,
      M(18) => NLW_blk00000090_M_18_UNCONNECTED,
      M(17) => NLW_blk00000090_M_17_UNCONNECTED,
      M(16) => NLW_blk00000090_M_16_UNCONNECTED,
      M(15) => NLW_blk00000090_M_15_UNCONNECTED,
      M(14) => NLW_blk00000090_M_14_UNCONNECTED,
      M(13) => NLW_blk00000090_M_13_UNCONNECTED,
      M(12) => NLW_blk00000090_M_12_UNCONNECTED,
      M(11) => NLW_blk00000090_M_11_UNCONNECTED,
      M(10) => NLW_blk00000090_M_10_UNCONNECTED,
      M(9) => NLW_blk00000090_M_9_UNCONNECTED,
      M(8) => NLW_blk00000090_M_8_UNCONNECTED,
      M(7) => NLW_blk00000090_M_7_UNCONNECTED,
      M(6) => NLW_blk00000090_M_6_UNCONNECTED,
      M(5) => NLW_blk00000090_M_5_UNCONNECTED,
      M(4) => NLW_blk00000090_M_4_UNCONNECTED,
      M(3) => NLW_blk00000090_M_3_UNCONNECTED,
      M(2) => NLW_blk00000090_M_2_UNCONNECTED,
      M(1) => NLW_blk00000090_M_1_UNCONNECTED,
      M(0) => NLW_blk00000090_M_0_UNCONNECTED
    );
  blk00000091 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ae,
      Q => sig00000178
    );
  blk00000092 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ad,
      Q => sig00000177
    );
  blk00000093 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ac,
      Q => sig00000176
    );
  blk00000094 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ab,
      Q => sig00000175
    );
  blk00000095 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001aa,
      Q => sig00000174
    );
  blk00000096 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a9,
      Q => sig00000173
    );
  blk00000097 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a8,
      Q => sig00000172
    );
  blk00000098 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a7,
      Q => sig00000171
    );
  blk00000099 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a6,
      Q => sig00000180
    );
  blk0000009a : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a5,
      Q => sig0000017f
    );
  blk0000009b : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a4,
      Q => sig0000017e
    );
  blk0000009c : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a3,
      Q => sig0000017d
    );
  blk0000009d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a2,
      Q => sig0000017c
    );
  blk0000009e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a1,
      Q => sig0000017b
    );
  blk0000009f : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001a0,
      Q => sig0000017a
    );
  blk000000a0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000019f,
      Q => sig00000179
    );
  blk000000a1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000016f,
      Q => sig00000170
    );
  blk000000a2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000013,
      Q => sig00000195
    );
  blk000000a3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000012,
      Q => sig00000194
    );
  blk000000a4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000011,
      Q => sig00000193
    );
  blk000000a5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000010,
      Q => sig00000192
    );
  blk000000a6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000000f,
      Q => sig00000191
    );
  blk000000a7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000000e,
      Q => sig00000190
    );
  blk000000a8 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000000d,
      Q => sig0000018f
    );
  blk000000a9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000000c,
      Q => sig0000018e
    );
  blk000000aa : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000000b,
      Q => sig0000018d
    );
  blk000000ab : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000001c,
      Q => sig0000019e
    );
  blk000000ac : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000001b,
      Q => sig0000019d
    );
  blk000000ad : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000001a,
      Q => sig0000019c
    );
  blk000000ae : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000019,
      Q => sig0000019b
    );
  blk000000af : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000018,
      Q => sig0000019a
    );
  blk000000b0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000017,
      Q => sig00000199
    );
  blk000000b1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000016,
      Q => sig00000198
    );
  blk000000b2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000015,
      Q => sig00000197
    );
  blk000000b3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000014,
      Q => sig00000196
    );
  blk000000b4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001bc,
      Q => sig0000010d
    );
  blk000000b5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001bb,
      Q => sig0000010c
    );
  blk000000b6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001ba,
      Q => sig0000010b
    );
  blk000000b7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b9,
      Q => sig0000010a
    );
  blk000000b8 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b8,
      Q => sig00000109
    );
  blk000000b9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b7,
      Q => sig00000108
    );
  blk000000ba : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b6,
      Q => sig00000107
    );
  blk000000bb : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b5,
      Q => sig00000106
    );
  blk000000bc : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b4,
      Q => sig00000105
    );
  blk000000bd : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b3,
      Q => sig00000104
    );
  blk000000be : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b2,
      Q => sig00000103
    );
  blk000000bf : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig000001b1,
      Q => sig00000102
    );
  blk000000c0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000018c,
      Q => sig000001bc
    );
  blk000000c1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000018b,
      Q => sig000001bb
    );
  blk000000c2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000018a,
      Q => sig000001ba
    );
  blk000000c3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000189,
      Q => sig000001b9
    );
  blk000000c4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000188,
      Q => sig000001b8
    );
  blk000000c5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000187,
      Q => sig000001b7
    );
  blk000000c6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000186,
      Q => sig000001b6
    );
  blk000000c7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000185,
      Q => sig000001b5
    );
  blk000000c8 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000184,
      Q => sig000001b4
    );
  blk000000c9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000183,
      Q => sig000001b3
    );
  blk000000ca : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000182,
      Q => sig000001b2
    );
  blk000000cb : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000181,
      Q => sig000001b1
    );
  blk000000cc : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig0000018c,
      Q => sig00000101
    );
  blk000000cd : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig0000018b,
      Q => sig00000100
    );
  blk000000ce : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig0000018a,
      Q => sig000000ff
    );
  blk000000cf : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000189,
      Q => sig000000fe
    );
  blk000000d0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000188,
      Q => sig000000fd
    );
  blk000000d1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000187,
      Q => sig000000fc
    );
  blk000000d2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000186,
      Q => sig000000fb
    );
  blk000000d3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000185,
      Q => sig000000fa
    );
  blk000000d4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000184,
      Q => sig000000f9
    );
  blk000000d5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000183,
      Q => sig000000f8
    );
  blk000000d6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000182,
      Q => sig000000f7
    );
  blk000000d7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000001af,
      D => sig00000181,
      Q => sig000000f6
    );
  blk000000d8 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a1,
      I1 => sig00000125,
      I2 => sig00000005,
      O => sig000000ed
    );
  blk000000d9 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a0,
      I1 => sig00000124,
      I2 => sig00000005,
      O => sig000000ec
    );
  blk000000da : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig0000009f,
      I1 => sig00000123,
      I2 => sig00000005,
      O => sig000000eb
    );
  blk000000db : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig0000009e,
      I1 => sig00000122,
      I2 => sig00000005,
      O => sig000000ea
    );
  blk000000dc : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig0000009d,
      I1 => sig00000121,
      I2 => sig00000005,
      O => sig000000e9
    );
  blk000000dd : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig0000009c,
      I1 => sig00000120,
      I2 => sig00000005,
      O => sig000000e8
    );
  blk000000de : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig0000009b,
      I1 => sig0000011f,
      I2 => sig00000005,
      O => sig000000e7
    );
  blk000000df : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig0000009a,
      I1 => sig0000011e,
      I2 => sig00000005,
      O => sig000000e6
    );
  blk000000e0 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a9,
      I1 => sig0000012d,
      I2 => sig00000005,
      O => sig000000f5
    );
  blk000000e1 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a8,
      I1 => sig0000012c,
      I2 => sig00000005,
      O => sig000000f4
    );
  blk000000e2 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a7,
      I1 => sig0000012b,
      I2 => sig00000005,
      O => sig000000f3
    );
  blk000000e3 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a6,
      I1 => sig0000012a,
      I2 => sig00000005,
      O => sig000000f2
    );
  blk000000e4 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a5,
      I1 => sig00000129,
      I2 => sig00000005,
      O => sig000000f1
    );
  blk000000e5 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a4,
      I1 => sig00000128,
      I2 => sig00000005,
      O => sig000000f0
    );
  blk000000e6 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a3,
      I1 => sig00000127,
      I2 => sig00000005,
      O => sig000000ef
    );
  blk000000e7 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig000000a2,
      I1 => sig00000126,
      I2 => sig00000005,
      O => sig000000ee
    );
  blk000000fb : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000dd,
      I2 => sig00000007,
      O => sig000001bd
    );
  blk000000fc : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000dc,
      I2 => sig00000007,
      O => sig000001be
    );
  blk000000fd : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000db,
      I2 => sig00000007,
      O => sig000001bf
    );
  blk000000fe : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000da,
      I2 => sig00000007,
      O => sig000001c0
    );
  blk000000ff : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000d9,
      I2 => sig00000007,
      O => sig000001c1
    );
  blk00000100 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000d8,
      I2 => sig00000007,
      O => sig000001c2
    );
  blk00000101 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000d7,
      I2 => sig00000007,
      O => sig000001c3
    );
  blk00000102 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000d6,
      I2 => sig00000007,
      O => sig000001c4
    );
  blk00000103 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001bd,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(7)
    );
  blk00000104 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001be,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(6)
    );
  blk00000105 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001bf,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(5)
    );
  blk00000106 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c0,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(4)
    );
  blk00000107 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c1,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(3)
    );
  blk00000108 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c2,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(2)
    );
  blk00000109 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c3,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(1)
    );
  blk0000010a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c4,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_im_mux_Q(0)
    );
  blk0000010b : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000e5,
      I2 => sig00000007,
      O => sig000001c5
    );
  blk0000010c : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000e4,
      I2 => sig00000007,
      O => sig000001c6
    );
  blk0000010d : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000e3,
      I2 => sig00000007,
      O => sig000001c7
    );
  blk0000010e : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000e2,
      I2 => sig00000007,
      O => sig000001c8
    );
  blk0000010f : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000e1,
      I2 => sig00000007,
      O => sig000001c9
    );
  blk00000110 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000e0,
      I2 => sig00000007,
      O => sig000001ca
    );
  blk00000111 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000df,
      I2 => sig00000007,
      O => sig000001cb
    );
  blk00000112 : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig000000de,
      I2 => sig00000007,
      O => sig000001cc
    );
  blk00000113 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c5,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(7)
    );
  blk00000114 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c6,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(6)
    );
  blk00000115 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c7,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(5)
    );
  blk00000116 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c8,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(4)
    );
  blk00000117 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001c9,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(3)
    );
  blk00000118 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ca,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(2)
    );
  blk00000119 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001cb,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(1)
    );
  blk0000011a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001cc,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_single_channel_datapath_xk_re_mux_Q(0)
    );
  blk00000121 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000006d,
      Q => sig000001cd
    );
  blk00000122 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000006c,
      Q => sig000001ce
    );
  blk00000123 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000006b,
      Q => sig000001cf
    );
  blk00000124 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000006a,
      Q => sig000001d0
    );
  blk00000125 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000069,
      Q => sig000001d1
    );
  blk00000126 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000068,
      Q => sig000001d2
    );
  blk00000127 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000067,
      Q => sig000001d3
    );
  blk00000128 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000066,
      Q => sig000001d4
    );
  blk00000129 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001cd,
      R => sig00000002,
      Q => sig000000cc
    );
  blk0000012a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ce,
      R => sig00000002,
      Q => sig000000cb
    );
  blk0000012b : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001cf,
      R => sig00000002,
      Q => sig000000ca
    );
  blk0000012c : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d0,
      R => sig00000002,
      Q => sig000000c9
    );
  blk0000012d : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d1,
      R => sig00000002,
      Q => sig000000c8
    );
  blk0000012e : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d2,
      R => sig00000002,
      Q => sig000000c7
    );
  blk0000012f : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d3,
      R => sig00000002,
      Q => sig000000c6
    );
  blk00000130 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d4,
      R => sig00000002,
      Q => sig000000c5
    );
  blk00000131 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000075,
      Q => sig000001d5
    );
  blk00000132 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000074,
      Q => sig000001d6
    );
  blk00000133 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000073,
      Q => sig000001d7
    );
  blk00000134 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000072,
      Q => sig000001d8
    );
  blk00000135 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000071,
      Q => sig000001d9
    );
  blk00000136 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000070,
      Q => sig000001da
    );
  blk00000137 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000006f,
      Q => sig000001db
    );
  blk00000138 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000006e,
      Q => sig000001dc
    );
  blk00000139 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d5,
      R => sig00000002,
      Q => sig000000d4
    );
  blk0000013a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d6,
      R => sig00000002,
      Q => sig000000d3
    );
  blk0000013b : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d7,
      R => sig00000002,
      Q => sig000000d2
    );
  blk0000013c : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d8,
      R => sig00000002,
      Q => sig000000d1
    );
  blk0000013d : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001d9,
      R => sig00000002,
      Q => sig000000d0
    );
  blk0000013e : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001da,
      R => sig00000002,
      Q => sig000000cf
    );
  blk0000013f : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001db,
      R => sig00000002,
      Q => sig000000ce
    );
  blk00000140 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001dc,
      R => sig00000002,
      Q => sig000000cd
    );
  blk00000147 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig00000002,
      I2 => sig00000002,
      I3 => sig00000058,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001dd
    );
  blk00000148 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig00000002,
      I2 => sig00000058,
      I3 => sig00000059,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001de
    );
  blk00000149 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig00000058,
      I2 => sig00000059,
      I3 => sig0000005a,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001df
    );
  blk0000014a : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000058,
      I1 => sig00000059,
      I2 => sig0000005a,
      I3 => sig0000005b,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e0
    );
  blk0000014b : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000059,
      I1 => sig0000005a,
      I2 => sig0000005b,
      I3 => sig0000005c,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e1
    );
  blk0000014c : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000005a,
      I1 => sig0000005b,
      I2 => sig0000005c,
      I3 => sig0000005d,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e2
    );
  blk0000014d : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000005b,
      I1 => sig0000005c,
      I2 => sig0000005d,
      I3 => sig0000005e,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e3
    );
  blk0000014e : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000005c,
      I1 => sig0000005d,
      I2 => sig0000005e,
      I3 => sig0000005f,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e4
    );
  blk0000014f : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000005d,
      I1 => sig0000005e,
      I2 => sig0000005f,
      I3 => sig00000060,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e5
    );
  blk00000150 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000005e,
      I1 => sig0000005f,
      I2 => sig00000060,
      I3 => sig00000061,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e6
    );
  blk00000151 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000005f,
      I1 => sig00000060,
      I2 => sig00000061,
      I3 => sig00000062,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e7
    );
  blk00000152 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000060,
      I1 => sig00000061,
      I2 => sig00000062,
      I3 => sig00000063,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e8
    );
  blk00000153 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000061,
      I1 => sig00000062,
      I2 => sig00000063,
      I3 => sig00000064,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001e9
    );
  blk00000154 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000062,
      I1 => sig00000063,
      I2 => sig00000064,
      I3 => sig00000064,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001ea
    );
  blk00000155 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000063,
      I1 => sig00000064,
      I2 => sig00000064,
      I3 => sig00000064,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001eb
    );
  blk00000156 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000064,
      I1 => sig00000064,
      I2 => sig00000064,
      I3 => sig00000064,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001ec
    );
  blk00000157 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001dd,
      R => sig00000002,
      Q => NLW_blk00000157_Q_UNCONNECTED
    );
  blk00000158 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001de,
      R => sig00000002,
      Q => NLW_blk00000158_Q_UNCONNECTED
    );
  blk00000159 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001df,
      R => sig00000002,
      Q => NLW_blk00000159_Q_UNCONNECTED
    );
  blk0000015a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e0,
      R => sig00000002,
      Q => NLW_blk0000015a_Q_UNCONNECTED
    );
  blk0000015b : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e1,
      R => sig00000002,
      Q => NLW_blk0000015b_Q_UNCONNECTED
    );
  blk0000015c : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e2,
      R => sig00000002,
      Q => NLW_blk0000015c_Q_UNCONNECTED
    );
  blk0000015d : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e3,
      R => sig00000002,
      Q => sig000000a2
    );
  blk0000015e : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e4,
      R => sig00000002,
      Q => sig000000a3
    );
  blk0000015f : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e5,
      R => sig00000002,
      Q => sig000000a4
    );
  blk00000160 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e6,
      R => sig00000002,
      Q => sig000000a5
    );
  blk00000161 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e7,
      R => sig00000002,
      Q => sig000000a6
    );
  blk00000162 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e8,
      R => sig00000002,
      Q => sig000000a7
    );
  blk00000163 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001e9,
      R => sig00000002,
      Q => sig000000a8
    );
  blk00000164 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ea,
      R => sig00000002,
      Q => sig000000a9
    );
  blk00000165 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001eb,
      R => sig00000002,
      Q => NLW_blk00000165_Q_UNCONNECTED
    );
  blk00000166 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ec,
      R => sig00000002,
      Q => NLW_blk00000166_Q_UNCONNECTED
    );
  blk00000167 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig00000002,
      I2 => sig00000002,
      I3 => sig0000004b,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001ed
    );
  blk00000168 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig00000002,
      I2 => sig0000004b,
      I3 => sig0000004c,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001ee
    );
  blk00000169 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000002,
      I1 => sig0000004b,
      I2 => sig0000004c,
      I3 => sig0000004d,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001ef
    );
  blk0000016a : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000004b,
      I1 => sig0000004c,
      I2 => sig0000004d,
      I3 => sig0000004e,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f0
    );
  blk0000016b : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000004c,
      I1 => sig0000004d,
      I2 => sig0000004e,
      I3 => sig0000004f,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f1
    );
  blk0000016c : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000004d,
      I1 => sig0000004e,
      I2 => sig0000004f,
      I3 => sig00000050,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f2
    );
  blk0000016d : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000004e,
      I1 => sig0000004f,
      I2 => sig00000050,
      I3 => sig00000051,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f3
    );
  blk0000016e : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000004f,
      I1 => sig00000050,
      I2 => sig00000051,
      I3 => sig00000052,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f4
    );
  blk0000016f : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000050,
      I1 => sig00000051,
      I2 => sig00000052,
      I3 => sig00000053,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f5
    );
  blk00000170 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000051,
      I1 => sig00000052,
      I2 => sig00000053,
      I3 => sig00000054,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f6
    );
  blk00000171 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000052,
      I1 => sig00000053,
      I2 => sig00000054,
      I3 => sig00000055,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f7
    );
  blk00000172 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000053,
      I1 => sig00000054,
      I2 => sig00000055,
      I3 => sig00000056,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f8
    );
  blk00000173 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000054,
      I1 => sig00000055,
      I2 => sig00000056,
      I3 => sig00000057,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001f9
    );
  blk00000174 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000055,
      I1 => sig00000056,
      I2 => sig00000057,
      I3 => sig00000057,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001fa
    );
  blk00000175 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000056,
      I1 => sig00000057,
      I2 => sig00000057,
      I3 => sig00000057,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001fb
    );
  blk00000176 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000057,
      I1 => sig00000057,
      I2 => sig00000057,
      I3 => sig00000057,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig000001fc
    );
  blk00000177 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ed,
      R => sig00000002,
      Q => NLW_blk00000177_Q_UNCONNECTED
    );
  blk00000178 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ee,
      R => sig00000002,
      Q => NLW_blk00000178_Q_UNCONNECTED
    );
  blk00000179 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001ef,
      R => sig00000002,
      Q => NLW_blk00000179_Q_UNCONNECTED
    );
  blk0000017a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f0,
      R => sig00000002,
      Q => NLW_blk0000017a_Q_UNCONNECTED
    );
  blk0000017b : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f1,
      R => sig00000002,
      Q => NLW_blk0000017b_Q_UNCONNECTED
    );
  blk0000017c : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f2,
      R => sig00000002,
      Q => NLW_blk0000017c_Q_UNCONNECTED
    );
  blk0000017d : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f3,
      R => sig00000002,
      Q => sig0000009a
    );
  blk0000017e : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f4,
      R => sig00000002,
      Q => sig0000009b
    );
  blk0000017f : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f5,
      R => sig00000002,
      Q => sig0000009c
    );
  blk00000180 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f6,
      R => sig00000002,
      Q => sig0000009d
    );
  blk00000181 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f7,
      R => sig00000002,
      Q => sig0000009e
    );
  blk00000182 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f8,
      R => sig00000002,
      Q => sig0000009f
    );
  blk00000183 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001f9,
      R => sig00000002,
      Q => sig000000a0
    );
  blk00000184 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001fa,
      R => sig00000002,
      Q => sig000000a1
    );
  blk00000185 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001fb,
      R => sig00000002,
      Q => NLW_blk00000185_Q_UNCONNECTED
    );
  blk00000186 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000001fc,
      R => sig00000002,
      Q => NLW_blk00000186_Q_UNCONNECTED
    );
  blk00000187 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000200,
      D => sig000001ff,
      R => sig00000003,
      Q => sig00000097
    );
  blk00000188 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig00000200,
      D => sig000001fe,
      R => sig00000003,
      Q => sig00000096
    );
  blk00000189 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000202,
      R => sig000001fd,
      Q => sig000001ff
    );
  blk0000018a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000201,
      R => sig000001fd,
      Q => sig000001fe
    );
  blk0000018b : LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => sclr,
      O => sig0000025e
    );
  blk0000018c : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig0000028e,
      I1 => sig0000023b,
      O => sig0000025f
    );
  blk0000018d : LUT4
    generic map(
      INIT => X"2E22"
    )
    port map (
      I0 => sig000002c7,
      I1 => sig000002a1,
      I2 => sig00000254,
      I3 => sig00000234,
      O => sig00000268
    );
  blk0000018e : LUT4
    generic map(
      INIT => X"2E22"
    )
    port map (
      I0 => sig000002c6,
      I1 => sig000002a1,
      I2 => sig00000254,
      I3 => sig00000235,
      O => sig00000269
    );
  blk0000018f : LUT4
    generic map(
      INIT => X"2E22"
    )
    port map (
      I0 => sig000002c5,
      I1 => sig000002a1,
      I2 => sig00000254,
      I3 => sig00000236,
      O => sig0000026a
    );
  blk00000190 : LUT4
    generic map(
      INIT => X"2E22"
    )
    port map (
      I0 => sig000002c4,
      I1 => sig000002a1,
      I2 => sig00000254,
      I3 => sig00000237,
      O => sig0000026b
    );
  blk00000191 : LUT4
    generic map(
      INIT => X"2E22"
    )
    port map (
      I0 => sig000002c3,
      I1 => sig000002a1,
      I2 => sig00000254,
      I3 => sig00000238,
      O => sig0000026c
    );
  blk00000192 : LUT4
    generic map(
      INIT => X"2E22"
    )
    port map (
      I0 => sig000002c2,
      I1 => sig000002a1,
      I2 => sig00000254,
      I3 => sig00000239,
      O => sig0000026d
    );
  blk00000193 : LUT4
    generic map(
      INIT => X"2E22"
    )
    port map (
      I0 => sig000002c1,
      I1 => sig000002a1,
      I2 => sig00000254,
      I3 => sig0000023a,
      O => sig0000026e
    );
  blk00000194 : LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => sig000002a2,
      I1 => sig00000249,
      I2 => sig00000248,
      O => sig0000026f
    );
  blk00000195 : MUXCY
    port map (
      CI => sig00000001,
      DI => sig00000002,
      S => sig00000255,
      O => sig00000270
    );
  blk00000196 : MUXCY
    port map (
      CI => sig00000270,
      DI => sig00000002,
      S => sig00000256,
      O => sig00000271
    );
  blk00000197 : MUXCY
    port map (
      CI => sig00000271,
      DI => sig00000002,
      S => sig00000257,
      O => sig00000272
    );
  blk00000198 : MUXCY
    port map (
      CI => sig00000272,
      DI => sig00000002,
      S => sig00000258,
      O => sig00000273
    );
  blk00000199 : MUXCY
    port map (
      CI => sig00000273,
      DI => sig00000002,
      S => sig00000259,
      O => sig00000274
    );
  blk0000019a : MUXCY
    port map (
      CI => sig00000274,
      DI => sig00000002,
      S => sig0000025a,
      O => sig00000275
    );
  blk0000019b : MUXCY
    port map (
      CI => sig00000275,
      DI => sig00000002,
      S => sig0000025b,
      O => sig00000276
    );
  blk0000019c : MUXCY
    port map (
      CI => sig00000276,
      DI => sig00000002,
      S => sig0000025c,
      O => sig00000277
    );
  blk0000019d : MUXCY
    port map (
      CI => sig00000277,
      DI => sig00000002,
      S => sig0000025e,
      O => sig0000027c
    );
  blk0000019e : MUXCY
    port map (
      CI => sig0000027f,
      DI => sig00000002,
      S => sig00000266,
      O => sig0000027e
    );
  blk0000019f : MUXCY
    port map (
      CI => sig00000001,
      DI => sig00000002,
      S => sig00000267,
      O => sig0000027f
    );
  blk000001a0 : XORCY
    port map (
      CI => sig0000027c,
      LI => sig00000002,
      O => sig00000284
    );
  blk000001a1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000025d,
      D => sig00000280,
      Q => sig00000227
    );
  blk000001a2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000025d,
      D => sig00000281,
      Q => sig00000204
    );
  blk000001a3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000025d,
      D => sig00000282,
      Q => sig00000228
    );
  blk000001a4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig0000025d,
      D => sig00000283,
      Q => sig00000229
    );
  blk000001a5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000260,
      R => sclr,
      Q => sig0000022a
    );
  blk000001a6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000261,
      R => sclr,
      Q => sig0000022b
    );
  blk000001a7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000262,
      R => sclr,
      Q => sig0000022c
    );
  blk000001a8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000263,
      R => sclr,
      Q => sig0000022d
    );
  blk000001a9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000266,
      R => sclr,
      Q => sig0000022e
    );
  blk000001aa : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000264,
      R => sclr,
      Q => sig0000022f
    );
  blk000001ab : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000203,
      R => sclr,
      Q => sig00000230
    );
  blk000001ac : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000265,
      R => sclr,
      Q => sig00000231
    );
  blk000001ad : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000002,
      R => sclr,
      Q => sig00000232
    );
  blk000001ae : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000285,
      R => sclr,
      Q => sig00000240
    );
  blk000001af : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000286,
      R => sclr,
      Q => sig00000241
    );
  blk000001b0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000287,
      R => sclr,
      Q => sig00000242
    );
  blk000001b1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000288,
      R => sclr,
      Q => sig00000243
    );
  blk000001b2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000289,
      R => sclr,
      Q => sig00000244
    );
  blk000001b3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000028a,
      R => sclr,
      Q => sig00000245
    );
  blk000001b4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000028b,
      R => sclr,
      Q => sig00000246
    );
  blk000001b5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000028c,
      R => sclr,
      Q => sig00000233
    );
  blk000001b6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000284,
      Q => sig000002a1
    );
  blk000001b7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000240,
      R => sclr,
      Q => sig00000234
    );
  blk000001b8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000241,
      R => sclr,
      Q => sig00000235
    );
  blk000001b9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000242,
      R => sclr,
      Q => sig00000236
    );
  blk000001ba : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000243,
      R => sclr,
      Q => sig00000237
    );
  blk000001bb : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000244,
      R => sclr,
      Q => sig00000238
    );
  blk000001bc : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000245,
      R => sclr,
      Q => sig00000239
    );
  blk000001bd : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000246,
      R => sclr,
      Q => sig0000023a
    );
  blk000001be : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000027e,
      R => sclr,
      Q => sig0000023b
    );
  blk000001bf : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000025f,
      R => sclr,
      Q => sig0000023c
    );
  blk000001c0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig0000020d,
      Q => sig000002be
    );
  blk000001c1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig0000020e,
      Q => sig000002bd
    );
  blk000001c2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig0000020f,
      Q => sig000002bc
    );
  blk000001c3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000210,
      Q => sig000002bb
    );
  blk000001c4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000211,
      Q => sig000002ba
    );
  blk000001c5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000212,
      Q => sig000002b9
    );
  blk000001c6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000213,
      Q => sig000002b8
    );
  blk000001c7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000214,
      Q => sig000002b7
    );
  blk000001c8 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000215,
      Q => sig000002b6
    );
  blk000001c9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000216,
      Q => sig000002b5
    );
  blk000001ca : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000217,
      Q => sig000002b4
    );
  blk000001cb : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000218,
      Q => sig000002b3
    );
  blk000001cc : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig00000219,
      Q => sig000002b2
    );
  blk000001cd : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig0000021a,
      Q => sig000002b1
    );
  blk000001ce : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig0000021b,
      Q => sig000002b0
    );
  blk000001cf : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig0000021c,
      Q => sig000002af
    );
  blk000001d0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig0000021d,
      Q => sig000002ae
    );
  blk000001d1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002ab,
      D => sig0000021e,
      Q => sig000002ad
    );
  blk000001d2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000268,
      R => sclr,
      Q => sig000002c7
    );
  blk000001d3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000269,
      R => sclr,
      Q => sig000002c6
    );
  blk000001d4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000026a,
      R => sclr,
      Q => sig000002c5
    );
  blk000001d5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000026b,
      R => sclr,
      Q => sig000002c4
    );
  blk000001d6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000026c,
      R => sclr,
      Q => sig000002c3
    );
  blk000001d7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000026d,
      R => sclr,
      Q => sig000002c2
    );
  blk000001d8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000026e,
      R => sclr,
      Q => sig000002c1
    );
  blk000001d9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_run_addr_gen_done_int2,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_done_i_reg
    );
  blk000001da : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000253,
      R => sclr,
      Q => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_run_addr_gen_done_int2
    );
  blk000001db : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000024d,
      R => sclr,
      Q => sig00000253
    );
  blk000001dc : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000024c,
      R => sclr,
      Q => sig0000024d
    );
  blk000001dd : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000254,
      R => sclr,
      Q => sig00000251
    );
  blk000001de : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000021f,
      R => sclr,
      Q => sig00000291
    );
  blk000001df : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000220,
      R => sclr,
      Q => sig00000292
    );
  blk000001e0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000221,
      R => sclr,
      Q => sig00000293
    );
  blk000001e1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000222,
      R => sclr,
      Q => sig00000294
    );
  blk000001e2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000223,
      R => sclr,
      Q => sig00000295
    );
  blk000001e3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000224,
      R => sclr,
      Q => sig00000296
    );
  blk000001e4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000225,
      R => sclr,
      Q => sig00000297
    );
  blk000001e5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000226,
      R => sclr,
      Q => sig00000298
    );
  blk000001e6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000026f,
      R => sclr,
      Q => sig0000024c
    );
  blk000001e7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000249,
      R => sclr,
      Q => sig0000024a
    );
  blk000001e8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000248,
      R => sclr,
      Q => sig00000249
    );
  blk000001e9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002ac,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_busy_i_reg2
    );
  blk000001ea : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000024f,
      R => sclr,
      Q => sig00000006
    );
  blk000001eb : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000250,
      R => sclr,
      Q => sig00000008
    );
  blk000001ec : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002c0,
      R => sclr,
      Q => sig000002ac
    );
  blk000001ed : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000024e,
      R => sclr,
      Q => sig000002c0
    );
  blk000001ee : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000024b,
      R => sclr,
      Q => sig0000024f
    );
  blk000001ef : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000022a,
      R => sclr,
      Q => sig00000250
    );
  blk000001f0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000027d,
      R => sclr,
      Q => sig00000252
    );
  blk000001f7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002cc,
      R => sclr,
      Q => sig000002c8
    );
  blk000001f8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002ce,
      R => sclr,
      Q => sig00000009
    );
  blk000001f9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002cd,
      R => sclr,
      Q => sig000002c9
    );
  blk000001fa : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002cf,
      R => sclr,
      Q => sig000002ca
    );
  blk000001fb : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002cb,
      S => sclr,
      Q => sig00000003
    );
  blk000001fc : XORCY
    port map (
      CI => sig000002e9,
      LI => sig00000002,
      O => sig000002d8
    );
  blk000001fd : XORCY
    port map (
      CI => sig000002ea,
      LI => sig00000002,
      O => sig000002d9
    );
  blk000001fe : XORCY
    port map (
      CI => sig000002eb,
      LI => sig00000002,
      O => sig000002da
    );
  blk000001ff : MUXCY
    port map (
      CI => sig00000001,
      DI => sig00000002,
      S => sig000002f1,
      O => sig000002db
    );
  blk00000200 : MUXCY
    port map (
      CI => sig00000001,
      DI => sig00000002,
      S => sig000002f2,
      O => sig000002dc
    );
  blk00000201 : MUXCY
    port map (
      CI => sig00000001,
      DI => sig00000002,
      S => sig000002f3,
      O => sig000002dd
    );
  blk00000202 : MUXCY
    port map (
      CI => sig000002db,
      DI => sig00000002,
      S => sig000002f4,
      O => sig000002de
    );
  blk00000203 : MUXCY
    port map (
      CI => sig000002dc,
      DI => sig00000002,
      S => sig000002f5,
      O => sig000002df
    );
  blk00000204 : MUXCY
    port map (
      CI => sig000002dd,
      DI => sig00000002,
      S => sig000002f6,
      O => sig000002e0
    );
  blk00000205 : MUXCY
    port map (
      CI => sig000002ee,
      DI => sig00000002,
      S => sig000002f9,
      O => sig000002e9
    );
  blk00000206 : MUXCY
    port map (
      CI => sig000002ef,
      DI => sig00000002,
      S => sig000002fa,
      O => sig000002ea
    );
  blk00000207 : MUXCY
    port map (
      CI => sig000002f0,
      DI => sig00000002,
      S => sig000002fb,
      O => sig000002eb
    );
  blk00000208 : MUXF5
    port map (
      I0 => sig000002f8,
      I1 => sig00000002,
      S => sig00000300,
      O => sig000002ec
    );
  blk00000209 : MUXCY
    port map (
      CI => sig000002de,
      DI => sig0000028f,
      S => sig000002fd,
      O => sig000002ee
    );
  blk0000020a : MUXCY
    port map (
      CI => sig000002df,
      DI => sig0000028e,
      S => sig000002fe,
      O => sig000002ef
    );
  blk0000020b : MUXCY
    port map (
      CI => sig000002e0,
      DI => sig00000303,
      S => sig000002ff,
      O => sig000002f0
    );
  blk0000020c : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig00000286,
      I1 => sig00000285,
      O => sig000002f4
    );
  blk0000020d : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig00000286,
      I1 => sig00000285,
      O => sig000002f5
    );
  blk0000020e : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig00000286,
      I1 => sig00000285,
      O => sig000002f6
    );
  blk0000020f : LUT4
    generic map(
      INIT => X"EEE0"
    )
    port map (
      I0 => sig00000303,
      I1 => sig00000290,
      I2 => sig00000002,
      I3 => sig000002c8,
      O => sig000002f8
    );
  blk00000210 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => sig000002ca,
      I1 => sig00000009,
      I2 => sig000002ca,
      I3 => sig00000003,
      O => sig000002f9
    );
  blk00000211 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => sig000002ca,
      I1 => sig00000009,
      I2 => sig000002ca,
      I3 => sig00000003,
      O => sig000002fa
    );
  blk00000212 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => sig000002ca,
      I1 => sig00000009,
      I2 => sig000002ca,
      I3 => sig00000003,
      O => sig000002fb
    );
  blk00000213 : LUT3
    generic map(
      INIT => X"8A"
    )
    port map (
      I0 => ce,
      I1 => sig00000300,
      I2 => sig00000303,
      O => sig000002fd
    );
  blk00000214 : LUT3
    generic map(
      INIT => X"8A"
    )
    port map (
      I0 => ce,
      I1 => sig00000300,
      I2 => sig00000303,
      O => sig000002fe
    );
  blk00000215 : LUT3
    generic map(
      INIT => X"8A"
    )
    port map (
      I0 => ce,
      I1 => sig00000300,
      I2 => sig00000303,
      O => sig000002ff
    );
  blk00000216 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002ed,
      R => sclr,
      Q => sig00000300
    );
  blk00000217 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002f7,
      R => sclr,
      Q => sig00000302
    );
  blk00000218 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig000002ec,
      R => sclr,
      Q => sig00000290
    );
  blk00000219 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig000002d8,
      Q => sig0000028f
    );
  blk0000021a : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig000002d9,
      Q => sig0000028e
    );
  blk0000021b : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig000002da,
      Q => sig00000303
    );
  blk0000021c : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002fc,
      D => sig000002d0,
      R => sig00000003,
      Q => sig0000028c
    );
  blk0000021d : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002fc,
      D => sig000002d1,
      R => sig00000003,
      Q => sig0000028b
    );
  blk0000021e : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002fc,
      D => sig000002d2,
      R => sig00000003,
      Q => sig0000028a
    );
  blk0000021f : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002fc,
      D => sig000002d3,
      R => sig00000003,
      Q => sig00000289
    );
  blk00000220 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002fc,
      D => sig000002d4,
      R => sig00000003,
      Q => sig00000288
    );
  blk00000221 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002fc,
      D => sig000002d5,
      R => sig00000003,
      Q => sig00000287
    );
  blk00000222 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002fc,
      D => sig000002d6,
      R => sig00000003,
      Q => sig00000286
    );
  blk00000223 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => sig000002fc,
      D => sig000002d7,
      R => sig00000003,
      Q => sig00000285
    );
  blk00000241 : MUXF7
    port map (
      I0 => sig00000314,
      I1 => sig0000030c,
      S => sig00000204,
      O => sig00000304
    );
  blk00000242 : MUXF7
    port map (
      I0 => sig00000315,
      I1 => sig0000030d,
      S => sig00000204,
      O => sig00000305
    );
  blk00000243 : MUXF7
    port map (
      I0 => sig00000316,
      I1 => sig0000030e,
      S => sig00000204,
      O => sig00000306
    );
  blk00000244 : MUXF7
    port map (
      I0 => sig00000317,
      I1 => sig0000030f,
      S => sig00000204,
      O => sig00000307
    );
  blk00000245 : MUXF7
    port map (
      I0 => sig00000318,
      I1 => sig00000310,
      S => sig00000204,
      O => sig00000308
    );
  blk00000246 : MUXF7
    port map (
      I0 => sig00000319,
      I1 => sig00000311,
      S => sig00000204,
      O => sig00000309
    );
  blk00000247 : MUXF7
    port map (
      I0 => sig0000031a,
      I1 => sig00000312,
      S => sig00000204,
      O => sig0000030a
    );
  blk00000248 : MUXF7
    port map (
      I0 => sig0000031b,
      I1 => sig00000313,
      S => sig00000204,
      O => sig0000030b
    );
  blk00000249 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000288,
      I1 => sig00000289,
      I2 => sig0000028a,
      I3 => sig0000028b,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig0000030c
    );
  blk0000024a : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000287,
      I1 => sig00000288,
      I2 => sig00000289,
      I3 => sig0000028a,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig0000030d
    );
  blk0000024b : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000286,
      I1 => sig00000287,
      I2 => sig00000288,
      I3 => sig00000289,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig0000030e
    );
  blk0000024c : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000285,
      I1 => sig00000286,
      I2 => sig00000287,
      I3 => sig00000288,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig0000030f
    );
  blk0000024d : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000260,
      I1 => sig00000285,
      I2 => sig00000286,
      I3 => sig00000287,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000310
    );
  blk0000024e : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000028b,
      I1 => sig00000260,
      I2 => sig00000285,
      I3 => sig00000286,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000311
    );
  blk0000024f : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000028a,
      I1 => sig0000028b,
      I2 => sig00000260,
      I3 => sig00000285,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000312
    );
  blk00000250 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000289,
      I1 => sig0000028a,
      I2 => sig0000028b,
      I3 => sig00000260,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000313
    );
  blk00000251 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000260,
      I1 => sig00000285,
      I2 => sig00000286,
      I3 => sig00000287,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000314
    );
  blk00000252 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000028b,
      I1 => sig00000260,
      I2 => sig00000285,
      I3 => sig00000286,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000315
    );
  blk00000253 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig0000028a,
      I1 => sig0000028b,
      I2 => sig00000260,
      I3 => sig00000285,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000316
    );
  blk00000254 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000289,
      I1 => sig0000028a,
      I2 => sig0000028b,
      I3 => sig00000260,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000317
    );
  blk00000255 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000288,
      I1 => sig00000289,
      I2 => sig0000028a,
      I3 => sig0000028b,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000318
    );
  blk00000256 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000287,
      I1 => sig00000288,
      I2 => sig00000289,
      I3 => sig0000028a,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig00000319
    );
  blk00000257 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000286,
      I1 => sig00000287,
      I2 => sig00000288,
      I3 => sig00000289,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig0000031a
    );
  blk00000258 : LUT6
    generic map(
      INIT => X"FF00F0F0CCCCAAAA"
    )
    port map (
      I0 => sig00000285,
      I1 => sig00000286,
      I2 => sig00000287,
      I3 => sig00000288,
      I4 => sig00000229,
      I5 => sig00000228,
      O => sig0000031b
    );
  blk00000259 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000304,
      R => sig00000002,
      Q => sig0000020c
    );
  blk0000025a : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000305,
      R => sig00000002,
      Q => sig0000020b
    );
  blk0000025b : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000306,
      R => sig00000002,
      Q => sig0000020a
    );
  blk0000025c : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000307,
      R => sig00000002,
      Q => sig00000209
    );
  blk0000025d : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000308,
      R => sig00000002,
      Q => sig00000208
    );
  blk0000025e : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000309,
      R => sig00000002,
      Q => sig00000207
    );
  blk0000025f : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000030a,
      R => sig00000002,
      Q => sig00000206
    );
  blk00000260 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000030b,
      R => sig00000002,
      Q => sig00000205
    );
  blk00000261 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000205,
      Q => sig0000021f
    );
  blk00000262 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000206,
      Q => sig00000220
    );
  blk00000263 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000207,
      Q => sig00000221
    );
  blk00000264 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000208,
      Q => sig00000222
    );
  blk00000265 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000209,
      Q => sig00000223
    );
  blk00000266 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000020a,
      Q => sig00000224
    );
  blk00000267 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000020b,
      Q => sig00000225
    );
  blk00000268 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000020c,
      Q => sig00000226
    );
  blk00000269 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000001,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig0000021f,
      Q => sig0000031c
    );
  blk0000026a : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000001,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig00000220,
      Q => sig0000031d
    );
  blk0000026b : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000001,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig00000221,
      Q => sig0000031e
    );
  blk0000026c : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000001,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig00000222,
      Q => sig0000031f
    );
  blk0000026d : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000001,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig00000223,
      Q => sig00000320
    );
  blk0000026e : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000001,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig00000224,
      Q => sig00000321
    );
  blk0000026f : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000001,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig00000225,
      Q => sig00000322
    );
  blk00000270 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000001,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig00000226,
      Q => sig00000323
    );
  blk00000271 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000031c,
      R => sig00000002,
      Q => sig00000299
    );
  blk00000272 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000031d,
      R => sig00000002,
      Q => sig0000029a
    );
  blk00000273 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000031e,
      R => sig00000002,
      Q => sig0000029b
    );
  blk00000274 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000031f,
      R => sig00000002,
      Q => sig0000029c
    );
  blk00000275 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000320,
      R => sig00000002,
      Q => sig0000029d
    );
  blk00000276 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000321,
      R => sig00000002,
      Q => sig0000029e
    );
  blk00000277 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000322,
      R => sig00000002,
      Q => sig0000029f
    );
  blk00000278 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000323,
      R => sig00000002,
      Q => sig000002a0
    );
  blk000002a4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000338,
      R => sig00000324,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(7)
    );
  blk000002a5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000337,
      R => sig00000324,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(6)
    );
  blk000002a6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000336,
      R => sig00000324,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(5)
    );
  blk000002a7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000335,
      R => sig00000324,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(4)
    );
  blk000002a8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000334,
      R => sig00000324,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(3)
    );
  blk000002a9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000333,
      R => sig00000324,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(2)
    );
  blk000002aa : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000332,
      R => sig00000324,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(1)
    );
  blk000002ab : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000331,
      R => sig00000324,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_xk_index_i(0)
    );
  blk000002ac : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000007,
      R => sclr,
      Q => U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_dv_d
    );
  blk000002ad : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000032d,
      R => sclr,
      Q => sig0000032f
    );
  blk000002ae : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000001,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000028c,
      Q => sig0000033a
    );
  blk000002af : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000001,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000028b,
      Q => sig0000033b
    );
  blk000002b0 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000001,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000028a,
      Q => sig0000033c
    );
  blk000002b1 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000001,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000289,
      Q => sig0000033d
    );
  blk000002b2 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000001,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000288,
      Q => sig0000033e
    );
  blk000002b3 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000001,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000287,
      Q => sig0000033f
    );
  blk000002b4 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000001,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000286,
      Q => sig00000340
    );
  blk000002b5 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000001,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000285,
      Q => sig00000341
    );
  blk000002b6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000033a,
      R => sig00000002,
      Q => sig00000338
    );
  blk000002b7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000033b,
      R => sig00000002,
      Q => sig00000337
    );
  blk000002b8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000033c,
      R => sig00000002,
      Q => sig00000336
    );
  blk000002b9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000033d,
      R => sig00000002,
      Q => sig00000335
    );
  blk000002ba : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000033e,
      R => sig00000002,
      Q => sig00000334
    );
  blk000002bb : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000033f,
      R => sig00000002,
      Q => sig00000333
    );
  blk000002bc : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000340,
      R => sig00000002,
      Q => sig00000332
    );
  blk000002bd : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000341,
      R => sig00000002,
      Q => sig00000331
    );
  blk000002df : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002be,
      Q => sig00000342
    );
  blk000002e0 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002bd,
      Q => sig00000343
    );
  blk000002e1 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002bc,
      Q => sig00000344
    );
  blk000002e2 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002bb,
      Q => sig00000345
    );
  blk000002e3 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002ba,
      Q => sig00000346
    );
  blk000002e4 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b9,
      Q => sig00000347
    );
  blk000002e5 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b8,
      Q => sig00000348
    );
  blk000002e6 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b7,
      Q => sig00000349
    );
  blk000002e7 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b6,
      Q => sig0000034a
    );
  blk000002e8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000342,
      R => sig00000002,
      Q => sig00000013
    );
  blk000002e9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000343,
      R => sig00000002,
      Q => sig00000012
    );
  blk000002ea : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000344,
      R => sig00000002,
      Q => sig00000011
    );
  blk000002eb : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000345,
      R => sig00000002,
      Q => sig00000010
    );
  blk000002ec : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000346,
      R => sig00000002,
      Q => sig0000000f
    );
  blk000002ed : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000347,
      R => sig00000002,
      Q => sig0000000e
    );
  blk000002ee : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000348,
      R => sig00000002,
      Q => sig0000000d
    );
  blk000002ef : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000349,
      R => sig00000002,
      Q => sig0000000c
    );
  blk000002f0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000034a,
      R => sig00000002,
      Q => sig0000000b
    );
  blk000002f1 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b5,
      Q => sig0000034b
    );
  blk000002f2 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b4,
      Q => sig0000034c
    );
  blk000002f3 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b3,
      Q => sig0000034d
    );
  blk000002f4 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b2,
      Q => sig0000034e
    );
  blk000002f5 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b1,
      Q => sig0000034f
    );
  blk000002f6 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002b0,
      Q => sig00000350
    );
  blk000002f7 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002af,
      Q => sig00000351
    );
  blk000002f8 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002ae,
      Q => sig00000352
    );
  blk000002f9 : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig000002ad,
      Q => sig00000353
    );
  blk000002fa : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000034b,
      R => sig00000002,
      Q => sig0000001c
    );
  blk000002fb : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000034c,
      R => sig00000002,
      Q => sig0000001b
    );
  blk000002fc : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000034d,
      R => sig00000002,
      Q => sig0000001a
    );
  blk000002fd : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000034e,
      R => sig00000002,
      Q => sig00000019
    );
  blk000002fe : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000034f,
      R => sig00000002,
      Q => sig00000018
    );
  blk000002ff : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000350,
      R => sig00000002,
      Q => sig00000017
    );
  blk00000300 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000351,
      R => sig00000002,
      Q => sig00000016
    );
  blk00000301 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000352,
      R => sig00000002,
      Q => sig00000015
    );
  blk00000302 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000353,
      R => sig00000002,
      Q => sig00000014
    );
  blk00000303 : LUT4
    generic map(
      INIT => X"FDB0"
    )
    port map (
      I0 => sig00000037,
      I1 => sig00000035,
      I2 => sig00000038,
      I3 => sig00000036,
      O => sig0000003a
    );
  blk00000304 : LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => xn_re(6),
      I1 => xn_re(7),
      I2 => xn_im(6),
      I3 => xn_im(7),
      O => sig0000003d
    );
  blk00000305 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => sig00000037,
      I1 => sig00000035,
      O => sig00000039
    );
  blk00000306 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => sig00000005,
      I1 => sig00000006,
      O => sig0000003c
    );
  blk00000307 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => ce,
      I1 => sig00000046,
      O => sig0000003e
    );
  blk00000308 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => ce,
      I1 => sig000000d5,
      O => sig0000003f
    );
  blk00000309 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => ce,
      I1 => sig000000d5,
      O => sig00000040
    );
  blk0000030a : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => sclr,
      I1 => sig00000009,
      O => sig00000041
    );
  blk0000030b : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => sig00000044,
      I1 => sig00000096,
      O => sig00000030
    );
  blk0000030c : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => sig00000043,
      I1 => sig00000065,
      O => sig0000016f
    );
  blk0000030d : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000076,
      I2 => sig0000007e,
      O => sig0000019f
    );
  blk0000030e : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000077,
      I2 => sig0000007f,
      O => sig000001a0
    );
  blk0000030f : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000078,
      I2 => sig00000080,
      O => sig000001a1
    );
  blk00000310 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000079,
      I2 => sig00000081,
      O => sig000001a2
    );
  blk00000311 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig0000007a,
      I2 => sig00000082,
      O => sig000001a3
    );
  blk00000312 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig0000007b,
      I2 => sig00000083,
      O => sig000001a4
    );
  blk00000313 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig0000007c,
      I2 => sig00000084,
      O => sig000001a5
    );
  blk00000314 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig0000007d,
      I2 => sig00000085,
      O => sig000001a6
    );
  blk00000315 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig0000007e,
      I2 => sig00000076,
      O => sig000001a7
    );
  blk00000316 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig0000007f,
      I2 => sig00000077,
      O => sig000001a8
    );
  blk00000317 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000080,
      I2 => sig00000078,
      O => sig000001a9
    );
  blk00000318 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000081,
      I2 => sig00000079,
      O => sig000001aa
    );
  blk00000319 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000082,
      I2 => sig0000007a,
      O => sig000001ab
    );
  blk0000031a : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000083,
      I2 => sig0000007b,
      O => sig000001ac
    );
  blk0000031b : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000084,
      I2 => sig0000007c,
      O => sig000001ad
    );
  blk0000031c : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => sig00000065,
      I1 => sig00000085,
      I2 => sig0000007d,
      O => sig000001ae
    );
  blk0000031d : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => ce,
      I1 => sig000001b0,
      O => sig000001af
    );
  blk0000031e : LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => ce,
      I1 => sig00000048,
      I2 => sig00000003,
      O => sig000001fd
    );
  blk0000031f : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => ce,
      I1 => sig00000048,
      O => sig00000200
    );
  blk00000320 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sclr,
      I1 => sig00000229,
      I2 => sig00000009,
      O => sig0000027b
    );
  blk00000321 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sclr,
      I1 => sig00000009,
      I2 => sig00000228,
      O => sig0000027a
    );
  blk00000322 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sclr,
      I1 => sig00000204,
      I2 => sig00000009,
      O => sig00000279
    );
  blk00000323 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig00000009,
      I1 => sclr,
      I2 => sig00000227,
      O => sig00000278
    );
  blk00000324 : LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => sig00000227,
      I1 => sig00000204,
      I2 => sig00000228,
      O => sig00000203
    );
  blk00000325 : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => ce,
      I1 => sig00000233,
      I2 => sig00000232,
      O => sig00000255
    );
  blk00000326 : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => ce,
      I1 => sig00000246,
      I2 => sig00000231,
      O => sig00000256
    );
  blk00000327 : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => ce,
      I1 => sig00000245,
      I2 => sig00000230,
      O => sig00000257
    );
  blk00000328 : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => ce,
      I1 => sig00000244,
      I2 => sig0000022f,
      O => sig00000258
    );
  blk00000329 : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => ce,
      I1 => sig00000243,
      I2 => sig0000022e,
      O => sig00000259
    );
  blk0000032a : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => ce,
      I1 => sig00000242,
      I2 => sig0000022d,
      O => sig0000025a
    );
  blk0000032b : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => ce,
      I1 => sig00000241,
      I2 => sig0000022c,
      O => sig0000025b
    );
  blk0000032c : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => ce,
      I1 => sig00000240,
      I2 => sig0000022b,
      O => sig0000025c
    );
  blk0000032d : LUT3
    generic map(
      INIT => X"54"
    )
    port map (
      I0 => sig00000227,
      I1 => sig00000204,
      I2 => sig00000228,
      O => sig00000262
    );
  blk0000032e : LUT4
    generic map(
      INIT => X"5540"
    )
    port map (
      I0 => sig00000227,
      I1 => sig00000229,
      I2 => sig00000228,
      I3 => sig00000204,
      O => sig00000263
    );
  blk0000032f : LUT4
    generic map(
      INIT => X"2220"
    )
    port map (
      I0 => sig00000204,
      I1 => sig00000227,
      I2 => sig00000229,
      I3 => sig00000228,
      O => sig00000264
    );
  blk00000330 : LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      I0 => sig00000227,
      I1 => sig00000204,
      I2 => sig00000229,
      I3 => sig00000228,
      O => sig00000261
    );
  blk00000331 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig00000204,
      I1 => sig00000227,
      O => sig00000266
    );
  blk00000332 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig00000228,
      I1 => sig00000229,
      O => sig00000267
    );
  blk00000333 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => sig00000227,
      I1 => sig00000204,
      I2 => sig00000228,
      I3 => sig00000229,
      O => sig0000027d
    );
  blk00000334 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => ce,
      I1 => sig000002c0,
      O => sig000002ab
    );
  blk00000335 : LUT4
    generic map(
      INIT => X"22F2"
    )
    port map (
      I0 => sig00000003,
      I1 => start,
      I2 => sig000002c8,
      I3 => sig000002c0,
      O => sig000002cb
    );
  blk00000336 : LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => sig000002c8,
      I1 => sig000002c0,
      I2 => sig00000009,
      O => sig000002cc
    );
  blk00000337 : LUT3
    generic map(
      INIT => X"F2"
    )
    port map (
      I0 => sig000002c9,
      I1 => sig000002bf,
      I2 => sig000002ca,
      O => sig000002cd
    );
  blk00000338 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig000002c9,
      I1 => sig000002bf,
      O => sig000002ce
    );
  blk00000339 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig00000003,
      I1 => start,
      O => sig000002cf
    );
  blk0000033a : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig0000028c,
      I1 => sig00000009,
      I2 => sig000002ca,
      O => sig000002e1
    );
  blk0000033b : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig0000028b,
      I1 => sig00000009,
      I2 => sig000002ca,
      O => sig000002e2
    );
  blk0000033c : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig0000028a,
      I1 => sig00000009,
      I2 => sig000002ca,
      O => sig000002e3
    );
  blk0000033d : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig00000289,
      I1 => sig00000009,
      I2 => sig000002ca,
      O => sig000002e4
    );
  blk0000033e : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig00000288,
      I1 => sig00000009,
      I2 => sig000002ca,
      O => sig000002e5
    );
  blk0000033f : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig00000287,
      I1 => sig00000009,
      I2 => sig000002ca,
      O => sig000002e6
    );
  blk00000340 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig00000286,
      I1 => sig00000009,
      I2 => sig000002ca,
      O => sig000002e7
    );
  blk00000341 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => sig00000009,
      I1 => sig000002ca,
      I2 => sig00000285,
      O => sig000002e8
    );
  blk00000342 : LUT6
    generic map(
      INIT => X"1000000000000000"
    )
    port map (
      I0 => sig0000028a,
      I1 => sig0000028c,
      I2 => sig0000028b,
      I3 => sig00000287,
      I4 => sig00000288,
      I5 => sig00000289,
      O => sig000002f1
    );
  blk00000343 : LUT6
    generic map(
      INIT => X"2000000000000000"
    )
    port map (
      I0 => sig0000028a,
      I1 => sig0000028c,
      I2 => sig0000028b,
      I3 => sig00000287,
      I4 => sig00000288,
      I5 => sig00000289,
      O => sig000002f3
    );
  blk00000344 : LUT6
    generic map(
      INIT => X"2000000000000000"
    )
    port map (
      I0 => sig0000028c,
      I1 => sig0000028b,
      I2 => sig0000028a,
      I3 => sig00000287,
      I4 => sig00000288,
      I5 => sig00000289,
      O => sig000002f2
    );
  blk00000345 : LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => sig00000290,
      I1 => sig00000303,
      I2 => sig000002c8,
      O => sig000002f7
    );
  blk00000346 : LUT6
    generic map(
      INIT => X"000000008A008A8A"
    )
    port map (
      I0 => ce,
      I1 => sig000002a2,
      I2 => sig000002c8,
      I3 => sig00000300,
      I4 => sig00000303,
      I5 => sig00000003,
      O => sig000002fc
    );
  blk00000347 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig00000303,
      I1 => sig00000300,
      O => sig0000028d
    );
  blk00000348 : LUT4
    generic map(
      INIT => X"8880"
    )
    port map (
      I0 => sig0000032f,
      I1 => sig00000339,
      I2 => sig000002c9,
      I3 => sig000002ca,
      O => sig00000007
    );
  blk00000349 : LUT6
    generic map(
      INIT => X"AEEEAEEEAEEEEEEE"
    )
    port map (
      I0 => sclr,
      I1 => ce,
      I2 => sig0000032f,
      I3 => sig00000339,
      I4 => sig000002c9,
      I5 => sig000002ca,
      O => sig00000324
    );
  blk0000034a : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => NlwRenamedSig_OI_xn_index(0),
      I1 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      I2 => sig0000028e,
      I3 => sig00000003,
      O => sig00000325
    );
  blk0000034b : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => NlwRenamedSig_OI_xn_index(1),
      I1 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      I2 => sig0000028e,
      I3 => sig00000003,
      O => sig00000326
    );
  blk0000034c : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => NlwRenamedSig_OI_xn_index(2),
      I1 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      I2 => sig0000028e,
      I3 => sig00000003,
      O => sig00000327
    );
  blk0000034d : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => NlwRenamedSig_OI_xn_index(3),
      I1 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      I2 => sig0000028e,
      I3 => sig00000003,
      O => sig00000328
    );
  blk0000034e : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => NlwRenamedSig_OI_xn_index(4),
      I1 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      I2 => sig0000028e,
      I3 => sig00000003,
      O => sig00000329
    );
  blk0000034f : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => NlwRenamedSig_OI_xn_index(5),
      I1 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      I2 => sig0000028e,
      I3 => sig00000003,
      O => sig0000032a
    );
  blk00000350 : LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      I0 => NlwRenamedSig_OI_xn_index(6),
      I1 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      I2 => sig0000028e,
      I3 => sig00000003,
      O => sig0000032b
    );
  blk00000351 : LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      I0 => sig0000028e,
      I1 => NlwRenamedSig_OI_xn_index(7),
      I2 => sig00000003,
      I3 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      O => sig0000032c
    );
  blk00000352 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => sig00000009,
      I1 => sig0000032f,
      O => sig0000032d
    );
  blk00000353 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig00000354,
      Q => sig0000023f
    );
  blk00000354 : FDS
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      D => sig00000355,
      S => sclr,
      Q => sig00000043
    );
  blk00000355 : FDS
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      D => sig00000356,
      S => sclr,
      Q => sig00000042
    );
  blk00000356 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig00000357,
      Q => sig00000254
    );
  blk00000357 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig00000358,
      Q => sig00000248
    );
  blk00000358 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig00000359,
      Q => sig000002a2
    );
  blk00000359 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig0000035a,
      Q => sig00000247
    );
  blk0000035a : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig0000035b,
      Q => sig0000024b
    );
  blk0000035b : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig0000035c,
      Q => sig0000024e
    );
  blk0000035c : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig0000035d,
      Q => sig000002bf
    );
  blk0000035d : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig0000035e,
      Q => sig0000032e
    );
  blk0000035e : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig0000035f,
      Q => sig00000004
    );
  blk0000035f : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => sig00000360,
      Q => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i
    );
  blk00000360 : LUT5
    generic map(
      INIT => X"EEEEEAAA"
    )
    port map (
      I0 => sclr,
      I1 => ce,
      I2 => sig00000300,
      I3 => sig00000303,
      I4 => sig00000009,
      O => sig0000025d
    );
  blk00000361 : LUT6
    generic map(
      INIT => X"5404544444044444"
    )
    port map (
      I0 => sclr,
      I1 => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      I2 => ce,
      I3 => sig00000003,
      I4 => sig0000028e,
      I5 => start,
      O => sig00000360
    );
  blk00000362 : LUT6
    generic map(
      INIT => X"0454044404440444"
    )
    port map (
      I0 => sclr,
      I1 => sig0000024e,
      I2 => ce,
      I3 => sig0000024c,
      I4 => sig0000028f,
      I5 => sig000002c9,
      O => sig0000035c
    );
  blk00000363 : LUT5
    generic map(
      INIT => X"15051000"
    )
    port map (
      I0 => sclr,
      I1 => sig00000290,
      I2 => ce,
      I3 => sig000002a2,
      I4 => sig00000247,
      O => sig0000035a
    );
  blk00000364 : LUT5
    generic map(
      INIT => X"15051000"
    )
    port map (
      I0 => sclr,
      I1 => sig0000023f,
      I2 => ce,
      I3 => sig0000024a,
      I4 => sig0000024b,
      O => sig0000035b
    );
  blk00000365 : LUT6
    generic map(
      INIT => X"4545450540404000"
    )
    port map (
      I0 => sclr,
      I1 => sig00000339,
      I2 => ce,
      I3 => sig000002ca,
      I4 => sig000002c9,
      I5 => sig0000032e,
      O => sig0000035e
    );
  blk00000366 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => sig0000032e,
      I1 => ce,
      I2 => sig000002bf,
      I3 => sig00000330,
      O => sig0000035d
    );
  blk00000367 : LUT5
    generic map(
      INIT => X"15151000"
    )
    port map (
      I0 => sclr,
      I1 => sig0000023c,
      I2 => ce,
      I3 => sig00000009,
      I4 => sig000002a2,
      O => sig00000359
    );
  blk00000368 : LUT6
    generic map(
      INIT => X"0544554404444444"
    )
    port map (
      I0 => sclr,
      I1 => sig00000004,
      I2 => sig00000303,
      I3 => ce,
      I4 => sig00000300,
      I5 => sig000002ca,
      O => sig0000035f
    );
  blk00000369 : LUT3
    generic map(
      INIT => X"F2"
    )
    port map (
      I0 => sig0000023f,
      I1 => sig0000023e,
      I2 => sclr,
      O => sig00000354
    );
  blk0000036a : LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      I0 => sig00000043,
      I1 => ce,
      I2 => sig0000000a,
      I3 => sig00000042,
      O => sig00000355
    );
  blk0000036b : LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      I0 => sig00000042,
      I1 => ce,
      I2 => fwd_inv_we,
      I3 => fwd_inv,
      O => sig00000356
    );
  blk0000036c : LUT6
    generic map(
      INIT => X"566A66AAAAAAAAAA"
    )
    port map (
      I0 => sig0000002e,
      I1 => sig00000045,
      I2 => sig00000044,
      I3 => sig00000097,
      I4 => sig00000096,
      I5 => sig0000002f,
      O => sig00000032
    );
  blk0000036d : LUT5
    generic map(
      INIT => X"566A66AA"
    )
    port map (
      I0 => sig0000002f,
      I1 => sig00000045,
      I2 => sig00000044,
      I3 => sig00000097,
      I4 => sig00000096,
      O => sig00000033
    );
  blk0000036e : LUT4
    generic map(
      INIT => X"936C"
    )
    port map (
      I0 => sig00000044,
      I1 => sig00000045,
      I2 => sig00000096,
      I3 => sig00000097,
      O => sig00000034
    );
  blk0000036f : LUT4
    generic map(
      INIT => X"AAEA"
    )
    port map (
      I0 => sig000001ff,
      I1 => sig00000099,
      I2 => sig00000047,
      I3 => sig00000049,
      O => sig00000202
    );
  blk00000370 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => sig00000229,
      I1 => sig00000227,
      I2 => sig00000204,
      I3 => sig00000228,
      O => sig00000265
    );
  blk00000371 : LUT6
    generic map(
      INIT => X"5551515144404040"
    )
    port map (
      I0 => sig0000023c,
      I1 => ce,
      I2 => sig00000009,
      I3 => sig000002a2,
      I4 => sig0000028d,
      I5 => sig00000254,
      O => sig00000357
    );
  blk00000372 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig000002aa,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig000002a0,
      O => sig00000025
    );
  blk00000373 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig000002a9,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig0000029f,
      O => sig00000026
    );
  blk00000374 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig000002a8,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig0000029e,
      O => sig00000027
    );
  blk00000375 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig000002a7,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig0000029d,
      O => sig00000028
    );
  blk00000376 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig000002a6,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig0000029c,
      O => sig00000029
    );
  blk00000377 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig000002a5,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig0000029b,
      O => sig0000002a
    );
  blk00000378 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig000002a4,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig0000029a,
      O => sig0000002b
    );
  blk00000379 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig000002a3,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000299,
      O => sig0000002c
    );
  blk0000037a : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig00000285,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000298,
      O => sig0000001d
    );
  blk0000037b : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig00000286,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000297,
      O => sig0000001e
    );
  blk0000037c : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig00000287,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000296,
      O => sig0000001f
    );
  blk0000037d : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig00000288,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000295,
      O => sig00000020
    );
  blk0000037e : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig00000289,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000294,
      O => sig00000021
    );
  blk0000037f : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig0000028a,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000293,
      O => sig00000022
    );
  blk00000380 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig0000028b,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000292,
      O => sig00000023
    );
  blk00000381 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => sig0000028c,
      I1 => sig000002c9,
      I2 => sig000002ca,
      I3 => sig00000291,
      O => sig00000024
    );
  blk00000382 : LUT5
    generic map(
      INIT => X"FFFFFFF1"
    )
    port map (
      I0 => sig00000009,
      I1 => sig000002c8,
      I2 => sig000002ca,
      I3 => sig000002c9,
      I4 => sig00000301,
      O => sig000002ed
    );
  blk00000383 : MUXF7
    port map (
      I0 => sig00000361,
      I1 => sig00000362,
      S => sig00000049,
      O => sig00000201
    );
  blk00000384 : LUT5
    generic map(
      INIT => X"FABA8AAA"
    )
    port map (
      I0 => sig000001fe,
      I1 => sig000001ff,
      I2 => sig00000047,
      I3 => sig00000099,
      I4 => sig00000098,
      O => sig00000361
    );
  blk00000385 : LUT3
    generic map(
      INIT => X"F2"
    )
    port map (
      I0 => sig0000004a,
      I1 => sig000001ff,
      I2 => sig000001fe,
      O => sig00000362
    );
  blk00000386 : MUXF7
    port map (
      I0 => sig00000363,
      I1 => sig00000364,
      S => sig0000002d,
      O => sig00000031
    );
  blk00000387 : LUT6
    generic map(
      INIT => X"8880808080000000"
    )
    port map (
      I0 => sig0000002e,
      I1 => sig0000002f,
      I2 => sig00000045,
      I3 => sig00000044,
      I4 => sig00000096,
      I5 => sig00000097,
      O => sig00000363
    );
  blk00000388 : LUT6
    generic map(
      INIT => X"175FFFFFFFFFFFFF"
    )
    port map (
      I0 => sig00000045,
      I1 => sig00000044,
      I2 => sig00000097,
      I3 => sig00000096,
      I4 => sig0000002e,
      I5 => sig0000002f,
      O => sig00000364
    );
  blk00000389 : MUXF7
    port map (
      I0 => sig00000365,
      I1 => sig00000366,
      S => ce,
      O => sig00000358
    );
  blk0000038a : LUT6
    generic map(
      INIT => X"0100010001000000"
    )
    port map (
      I0 => sig000002ca,
      I1 => sig000002c9,
      I2 => sclr,
      I3 => sig00000248,
      I4 => sig000002c8,
      I5 => sig00000009,
      O => sig00000365
    );
  blk0000038b : LUT6
    generic map(
      INIT => X"0100010001000000"
    )
    port map (
      I0 => sig000002ca,
      I1 => sig000002c9,
      I2 => sclr,
      I3 => sig0000023d,
      I4 => sig000002c8,
      I5 => sig00000009,
      O => sig00000366
    );
  blk0000038c : INV
    port map (
      I => sig0000028c,
      O => sig00000260
    );
  blk0000038d : RAMB8BWER
    generic map(
      INITP_00 => X"FFFFFFFFFFFFFFFE000000000000000000000000000000000000000000000000",
      INIT_00 => X"585654514F4C4A4744423F3C3A3734312E2B2825221F1C191613100D09060300",
      INIT_01 => X"8080807F7F7F7E7E7D7C7B7A7A797776757472716F6E6C6A69676563615F5D5B",
      INIT_02 => X"5D5F61636567696A6C6E6F717274757677797A7A7B7C7D7E7E7F7F7F80808080",
      INIT_03 => X"0306090D101316191C1F2225282B2E3134373A3C3F4244474A4C4F515456585B",
      INIT_04 => X"5D5F61636567696A6C6E6F717274757677797A7A7B7C7D7E7E7F7F7F80808080",
      INIT_05 => X"0306090D101316191C1F2225282B2E3134373A3C3F4244474A4C4F515456585B",
      INIT_06 => X"A8AAACAFB1B4B6B9BCBEC1C4C6C9CCCFD2D5D8DBDEE1E4E7EAEDF0F3F7FAFD00",
      INIT_07 => X"8080808181818282838485868687898A8B8C8E8F9192949697999B9D9FA1A3A5",
      INIT_A => X"00000",
      INIT_B => X"00000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      DATA_WIDTH_A => 9,
      DATA_WIDTH_B => 9,
      DOA_REG => 1,
      DOB_REG => 1,
      EN_RSTRAM_A => TRUE,
      EN_RSTRAM_B => TRUE,
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      RAM_MODE => "TDP",
      RST_PRIORITY_A => "CE",
      RST_PRIORITY_B => "CE",
      RSTTYPE => "SYNC",
      SRVAL_A => X"00000",
      SRVAL_B => X"00000",
      INIT_FILE => "NONE",
      SIM_COLLISION_CHECK => "ALL"
    )
    port map (
      RSTBRST => sig00000002,
      ENBRDEN => sig000002ab,
      REGCEA => sig000002ab,
      ENAWREN => sig000002ab,
      CLKAWRCLK => clk,
      CLKBRDCLK => clk,
      REGCEBREGCE => sig000002ab,
      RSTA => sig00000002,
      WEAWEL(1) => sig00000002,
      WEAWEL(0) => sig00000002,
      DOADO(15) => NLW_blk0000038d_DOADO_15_UNCONNECTED,
      DOADO(14) => NLW_blk0000038d_DOADO_14_UNCONNECTED,
      DOADO(13) => NLW_blk0000038d_DOADO_13_UNCONNECTED,
      DOADO(12) => NLW_blk0000038d_DOADO_12_UNCONNECTED,
      DOADO(11) => NLW_blk0000038d_DOADO_11_UNCONNECTED,
      DOADO(10) => NLW_blk0000038d_DOADO_10_UNCONNECTED,
      DOADO(9) => NLW_blk0000038d_DOADO_9_UNCONNECTED,
      DOADO(8) => NLW_blk0000038d_DOADO_8_UNCONNECTED,
      DOADO(7) => sig0000020e,
      DOADO(6) => sig0000020f,
      DOADO(5) => sig00000210,
      DOADO(4) => sig00000211,
      DOADO(3) => sig00000212,
      DOADO(2) => sig00000213,
      DOADO(1) => sig00000214,
      DOADO(0) => sig00000215,
      DOPADOP(1) => NLW_blk0000038d_DOPADOP_1_UNCONNECTED,
      DOPADOP(0) => sig0000020d,
      DOPBDOP(1) => NLW_blk0000038d_DOPBDOP_1_UNCONNECTED,
      DOPBDOP(0) => sig00000216,
      WEBWEU(1) => sig00000002,
      WEBWEU(0) => sig00000002,
      ADDRAWRADDR(12) => sig00000002,
      ADDRAWRADDR(11) => sig00000002,
      ADDRAWRADDR(10) => sig00000002,
      ADDRAWRADDR(9) => sig000002c7,
      ADDRAWRADDR(8) => sig000002c6,
      ADDRAWRADDR(7) => sig000002c5,
      ADDRAWRADDR(6) => sig000002c4,
      ADDRAWRADDR(5) => sig000002c3,
      ADDRAWRADDR(4) => sig000002c2,
      ADDRAWRADDR(3) => sig000002c1,
      ADDRAWRADDR(2) => NLW_blk0000038d_ADDRAWRADDR_2_UNCONNECTED,
      ADDRAWRADDR(1) => NLW_blk0000038d_ADDRAWRADDR_1_UNCONNECTED,
      ADDRAWRADDR(0) => NLW_blk0000038d_ADDRAWRADDR_0_UNCONNECTED,
      DIPBDIP(1) => NLW_blk0000038d_DIPBDIP_1_UNCONNECTED,
      DIPBDIP(0) => NLW_blk0000038d_DIPBDIP_0_UNCONNECTED,
      DIBDI(15) => NLW_blk0000038d_DIBDI_15_UNCONNECTED,
      DIBDI(14) => NLW_blk0000038d_DIBDI_14_UNCONNECTED,
      DIBDI(13) => NLW_blk0000038d_DIBDI_13_UNCONNECTED,
      DIBDI(12) => NLW_blk0000038d_DIBDI_12_UNCONNECTED,
      DIBDI(11) => NLW_blk0000038d_DIBDI_11_UNCONNECTED,
      DIBDI(10) => NLW_blk0000038d_DIBDI_10_UNCONNECTED,
      DIBDI(9) => NLW_blk0000038d_DIBDI_9_UNCONNECTED,
      DIBDI(8) => NLW_blk0000038d_DIBDI_8_UNCONNECTED,
      DIBDI(7) => NLW_blk0000038d_DIBDI_7_UNCONNECTED,
      DIBDI(6) => NLW_blk0000038d_DIBDI_6_UNCONNECTED,
      DIBDI(5) => NLW_blk0000038d_DIBDI_5_UNCONNECTED,
      DIBDI(4) => NLW_blk0000038d_DIBDI_4_UNCONNECTED,
      DIBDI(3) => NLW_blk0000038d_DIBDI_3_UNCONNECTED,
      DIBDI(2) => NLW_blk0000038d_DIBDI_2_UNCONNECTED,
      DIBDI(1) => NLW_blk0000038d_DIBDI_1_UNCONNECTED,
      DIBDI(0) => NLW_blk0000038d_DIBDI_0_UNCONNECTED,
      DIADI(15) => NLW_blk0000038d_DIADI_15_UNCONNECTED,
      DIADI(14) => NLW_blk0000038d_DIADI_14_UNCONNECTED,
      DIADI(13) => NLW_blk0000038d_DIADI_13_UNCONNECTED,
      DIADI(12) => NLW_blk0000038d_DIADI_12_UNCONNECTED,
      DIADI(11) => NLW_blk0000038d_DIADI_11_UNCONNECTED,
      DIADI(10) => NLW_blk0000038d_DIADI_10_UNCONNECTED,
      DIADI(9) => NLW_blk0000038d_DIADI_9_UNCONNECTED,
      DIADI(8) => NLW_blk0000038d_DIADI_8_UNCONNECTED,
      DIADI(7) => sig00000002,
      DIADI(6) => sig00000002,
      DIADI(5) => sig00000002,
      DIADI(4) => sig00000002,
      DIADI(3) => sig00000002,
      DIADI(2) => sig00000002,
      DIADI(1) => sig00000002,
      DIADI(0) => sig00000002,
      ADDRBRDADDR(12) => sig00000002,
      ADDRBRDADDR(11) => sig00000002,
      ADDRBRDADDR(10) => sig00000001,
      ADDRBRDADDR(9) => sig000002c7,
      ADDRBRDADDR(8) => sig000002c6,
      ADDRBRDADDR(7) => sig000002c5,
      ADDRBRDADDR(6) => sig000002c4,
      ADDRBRDADDR(5) => sig000002c3,
      ADDRBRDADDR(4) => sig000002c2,
      ADDRBRDADDR(3) => sig000002c1,
      ADDRBRDADDR(2) => NLW_blk0000038d_ADDRBRDADDR_2_UNCONNECTED,
      ADDRBRDADDR(1) => NLW_blk0000038d_ADDRBRDADDR_1_UNCONNECTED,
      ADDRBRDADDR(0) => NLW_blk0000038d_ADDRBRDADDR_0_UNCONNECTED,
      DOBDO(15) => NLW_blk0000038d_DOBDO_15_UNCONNECTED,
      DOBDO(14) => NLW_blk0000038d_DOBDO_14_UNCONNECTED,
      DOBDO(13) => NLW_blk0000038d_DOBDO_13_UNCONNECTED,
      DOBDO(12) => NLW_blk0000038d_DOBDO_12_UNCONNECTED,
      DOBDO(11) => NLW_blk0000038d_DOBDO_11_UNCONNECTED,
      DOBDO(10) => NLW_blk0000038d_DOBDO_10_UNCONNECTED,
      DOBDO(9) => NLW_blk0000038d_DOBDO_9_UNCONNECTED,
      DOBDO(8) => NLW_blk0000038d_DOBDO_8_UNCONNECTED,
      DOBDO(7) => sig00000217,
      DOBDO(6) => sig00000218,
      DOBDO(5) => sig00000219,
      DOBDO(4) => sig0000021a,
      DOBDO(3) => sig0000021b,
      DOBDO(2) => sig0000021c,
      DOBDO(1) => sig0000021d,
      DOBDO(0) => sig0000021e,
      DIPADIP(1) => NLW_blk0000038d_DIPADIP_1_UNCONNECTED,
      DIPADIP(0) => sig00000002
    );
  blk0000038e : LUT6
    generic map(
      INIT => X"4040424240404202"
    )
    port map (
      I0 => sig000000a1,
      I1 => sig0000009f,
      I2 => sig000000a0,
      I3 => sig0000009c,
      I4 => sig0000009e,
      I5 => sig0000009b,
      O => sig00000367
    );
  blk0000038f : LUT6
    generic map(
      INIT => X"4042020242420202"
    )
    port map (
      I0 => sig000000a1,
      I1 => sig000000a0,
      I2 => sig0000009f,
      I3 => sig0000009c,
      I4 => sig0000009e,
      I5 => sig0000009b,
      O => sig00000368
    );
  blk00000390 : MUXF7
    port map (
      I0 => sig00000368,
      I1 => sig00000367,
      S => sig0000009d,
      O => sig00000037
    );
  blk00000391 : LUT6
    generic map(
      INIT => X"4040424240404202"
    )
    port map (
      I0 => sig000000a9,
      I1 => sig000000a7,
      I2 => sig000000a8,
      I3 => sig000000a4,
      I4 => sig000000a6,
      I5 => sig000000a3,
      O => sig00000369
    );
  blk00000392 : LUT6
    generic map(
      INIT => X"4042020242420202"
    )
    port map (
      I0 => sig000000a9,
      I1 => sig000000a8,
      I2 => sig000000a7,
      I3 => sig000000a4,
      I4 => sig000000a6,
      I5 => sig000000a3,
      O => sig0000036a
    );
  blk00000393 : MUXF7
    port map (
      I0 => sig0000036a,
      I1 => sig00000369,
      S => sig000000a5,
      O => sig00000035
    );
  blk00000394 : MUXF8
    port map (
      I0 => sig0000036b,
      I1 => sig0000036e,
      S => sig000000a5,
      O => sig00000036
    );
  blk00000395 : MUXF8
    port map (
      I0 => sig00000371,
      I1 => sig00000374,
      S => sig0000009d,
      O => sig00000038
    );
  blk00000396 : MUXF7
    port map (
      I0 => sig0000036f,
      I1 => sig00000370,
      S => sig000000a4,
      O => sig0000036e
    );
  blk00000397 : MUXF7
    port map (
      I0 => sig0000036c,
      I1 => sig0000036d,
      S => sig000000a4,
      O => sig0000036b
    );
  blk00000398 : MUXF7
    port map (
      I0 => sig00000375,
      I1 => sig00000376,
      S => sig0000009c,
      O => sig00000374
    );
  blk00000399 : MUXF7
    port map (
      I0 => sig00000372,
      I1 => sig00000373,
      S => sig0000009c,
      O => sig00000371
    );
  blk0000039a : LUT4
    generic map(
      INIT => X"522A"
    )
    port map (
      I0 => sig000000a8,
      I1 => sig000000a6,
      I2 => sig000000a7,
      I3 => sig000000a9,
      O => sig0000036c
    );
  blk0000039b : LUT6
    generic map(
      INIT => X"000F0FFFFEC0F000"
    )
    port map (
      I0 => sig000000a2,
      I1 => sig000000a3,
      I2 => sig000000a9,
      I3 => sig000000a7,
      I4 => sig000000a6,
      I5 => sig000000a8,
      O => sig0000036d
    );
  blk0000039c : LUT6
    generic map(
      INIT => X"000F037FFFF0F000"
    )
    port map (
      I0 => sig000000a2,
      I1 => sig000000a3,
      I2 => sig000000a9,
      I3 => sig000000a7,
      I4 => sig000000a6,
      I5 => sig000000a8,
      O => sig0000036f
    );
  blk0000039d : LUT4
    generic map(
      INIT => X"544A"
    )
    port map (
      I0 => sig000000a8,
      I1 => sig000000a6,
      I2 => sig000000a9,
      I3 => sig000000a7,
      O => sig00000370
    );
  blk0000039e : LUT4
    generic map(
      INIT => X"522A"
    )
    port map (
      I0 => sig000000a0,
      I1 => sig0000009e,
      I2 => sig0000009f,
      I3 => sig000000a1,
      O => sig00000372
    );
  blk0000039f : LUT6
    generic map(
      INIT => X"000F0FFFFEC0F000"
    )
    port map (
      I0 => sig0000009a,
      I1 => sig0000009b,
      I2 => sig000000a1,
      I3 => sig0000009f,
      I4 => sig0000009e,
      I5 => sig000000a0,
      O => sig00000373
    );
  blk000003a0 : LUT6
    generic map(
      INIT => X"000F037FFFF0F000"
    )
    port map (
      I0 => sig0000009a,
      I1 => sig0000009b,
      I2 => sig000000a1,
      I3 => sig0000009f,
      I4 => sig0000009e,
      I5 => sig000000a0,
      O => sig00000375
    );
  blk000003a1 : LUT4
    generic map(
      INIT => X"544A"
    )
    port map (
      I0 => sig000000a0,
      I1 => sig0000009e,
      I2 => sig000000a1,
      I3 => sig0000009f,
      O => sig00000376
    );
  blk000003a2 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000170,
      Q => sig00000377,
      Q15 => NLW_blk000003a2_Q15_UNCONNECTED
    );
  blk000003a3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000377,
      Q => sig0000013e
    );
  blk000003a4 : SRLC32E
    generic map(
      INIT => X"00000000"
    )
    port map (
      CLK => clk,
      D => sig00000247,
      CE => ce,
      Q => sig00000378,
      Q31 => NLW_blk000003a4_Q31_UNCONNECTED,
      A(4) => sig00000001,
      A(3) => sig00000002,
      A(2) => sig00000002,
      A(1) => sig00000002,
      A(0) => sig00000002
    );
  blk000003a5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000378,
      Q => sig00000379
    );
  blk000003a6 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000001,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000001,
      CE => ce,
      CLK => clk,
      D => sig00000251,
      Q => sig0000037a,
      Q15 => NLW_blk000003a6_Q15_UNCONNECTED
    );
  blk000003a7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000037a,
      Q => sig0000037b
    );
  blk000003a8 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000028b,
      Q => sig0000037c,
      Q15 => NLW_blk000003a8_Q15_UNCONNECTED
    );
  blk000003a9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000037c,
      Q => sig000002a4
    );
  blk000003aa : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000001,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000065,
      Q => sig0000037d,
      Q15 => NLW_blk000003aa_Q15_UNCONNECTED
    );
  blk000003ab : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000037d,
      Q => sig000001b0
    );
  blk000003ac : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000028c,
      Q => sig0000037e,
      Q15 => NLW_blk000003ac_Q15_UNCONNECTED
    );
  blk000003ad : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000037e,
      Q => sig000002a3
    );
  blk000003ae : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000288,
      Q => sig0000037f,
      Q15 => NLW_blk000003ae_Q15_UNCONNECTED
    );
  blk000003af : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig0000037f,
      Q => sig000002a7
    );
  blk000003b0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig0000028a,
      Q => sig00000380,
      Q15 => NLW_blk000003b0_Q15_UNCONNECTED
    );
  blk000003b1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000380,
      Q => sig000002a5
    );
  blk000003b2 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000289,
      Q => sig00000381,
      Q15 => NLW_blk000003b2_Q15_UNCONNECTED
    );
  blk000003b3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000381,
      Q => sig000002a6
    );
  blk000003b4 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000285,
      Q => sig00000382,
      Q15 => NLW_blk000003b4_Q15_UNCONNECTED
    );
  blk000003b5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000382,
      Q => sig000002aa
    );
  blk000003b6 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000287,
      Q => sig00000383,
      Q15 => NLW_blk000003b6_Q15_UNCONNECTED
    );
  blk000003b7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000383,
      Q => sig000002a8
    );
  blk000003b8 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => sig00000002,
      A1 => sig00000002,
      A2 => sig00000002,
      A3 => sig00000002,
      CE => ce,
      CLK => clk,
      D => sig00000286,
      Q => sig00000384,
      Q15 => NLW_blk000003b8_Q15_UNCONNECTED
    );
  blk000003b9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000384,
      Q => sig000002a9
    );
  blk000003ba : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000001,
      R => sclr,
      Q => sig00000385
    );
  blk000003bb : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000385,
      R => sclr,
      Q => sig00000386
    );
  blk000003bc : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000386,
      R => sclr,
      Q => sig00000387
    );
  blk000003bd : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000387,
      R => sclr,
      Q => sig00000388
    );
  blk000003be : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000388,
      R => sclr,
      Q => sig00000389
    );
  blk000003bf : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000389,
      R => sclr,
      Q => sig0000038a
    );
  blk000003c0 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig0000038a,
      R => sclr,
      Q => sig0000038b
    );
  blk000003c1 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig0000038b,
      R => sclr,
      Q => sig0000038c
    );
  blk000003c2 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig0000038c,
      R => sclr,
      Q => sig0000038d
    );
  blk000003c3 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig0000038d,
      R => sclr,
      Q => sig0000038e
    );
  blk000003c4 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig0000038e,
      R => sclr,
      Q => sig0000038f
    );
  blk000003c5 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig0000038f,
      R => sclr,
      Q => sig00000390
    );
  blk000003c6 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000390,
      R => sclr,
      Q => sig00000391
    );
  blk000003c7 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000391,
      R => sclr,
      Q => sig00000392
    );
  blk000003c8 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000392,
      R => sclr,
      Q => sig00000393
    );
  blk000003c9 : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000393,
      R => sclr,
      Q => sig00000394
    );
  blk000003ca : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000394,
      R => sclr,
      Q => sig00000395
    );
  blk000003cb : FDRE
    port map (
      C => clk,
      CE => ce,
      D => sig00000395,
      R => sclr,
      Q => sig00000396
    );
  blk000003cc : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig0000037b,
      I1 => sig00000393,
      O => sig00000397
    );
  blk000003cd : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000397,
      R => sclr,
      Q => sig00000048
    );
  blk000003ce : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => sig00000379,
      I1 => sig00000396,
      O => sig00000398
    );
  blk000003cf : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000398,
      R => sclr,
      Q => sig00000047
    );
  blk000000e8_blk000000fa : RAMB8BWER
    generic map(
      DATA_WIDTH_A => 36,
      DATA_WIDTH_B => 36,
      DOA_REG => 0,
      DOB_REG => 1,
      EN_RSTRAM_A => FALSE,
      EN_RSTRAM_B => FALSE,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"00000",
      INIT_B => X"00000",
      INIT_FILE => "NONE",
      RAM_MODE => "SDP",
      RSTTYPE => "SYNC",
      RST_PRIORITY_A => "CE",
      RST_PRIORITY_B => "CE",
      SIM_COLLISION_CHECK => "GENERATE_X_ONLY",
      SRVAL_A => X"00000",
      SRVAL_B => X"00000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST"
    )
    port map (
      RSTBRST => blk000000e8_sig000003dd,
      ENBRDEN => ce,
      REGCEA => blk000000e8_sig000003dd,
      ENAWREN => ce,
      CLKAWRCLK => clk,
      CLKBRDCLK => clk,
      REGCEBREGCE => ce,
      RSTA => blk000000e8_sig000003dd,
      WEAWEL(1) => sig0000003b,
      WEAWEL(0) => sig0000003b,
      DOADO(15) => NLW_blk000000e8_blk000000fa_DOADO_15_UNCONNECTED,
      DOADO(14) => blk000000e8_sig000003c5,
      DOADO(13) => blk000000e8_sig000003c6,
      DOADO(12) => blk000000e8_sig000003c7,
      DOADO(11) => blk000000e8_sig000003c8,
      DOADO(10) => blk000000e8_sig000003c9,
      DOADO(9) => blk000000e8_sig000003ca,
      DOADO(8) => blk000000e8_sig000003cb,
      DOADO(7) => blk000000e8_sig000003bd,
      DOADO(6) => blk000000e8_sig000003be,
      DOADO(5) => blk000000e8_sig000003bf,
      DOADO(4) => blk000000e8_sig000003c0,
      DOADO(3) => blk000000e8_sig000003c1,
      DOADO(2) => blk000000e8_sig000003c2,
      DOADO(1) => blk000000e8_sig000003c3,
      DOADO(0) => blk000000e8_sig000003c4,
      DOPADOP(1) => NLW_blk000000e8_blk000000fa_DOPADOP_1_UNCONNECTED,
      DOPADOP(0) => blk000000e8_sig000003cc,
      DOPBDOP(1) => NLW_blk000000e8_blk000000fa_DOPBDOP_1_UNCONNECTED,
      DOPBDOP(0) => NLW_blk000000e8_blk000000fa_DOPBDOP_0_UNCONNECTED,
      WEBWEU(1) => sig0000003b,
      WEBWEU(0) => sig0000003b,
      ADDRAWRADDR(12) => sig0000011d,
      ADDRAWRADDR(11) => sig0000011c,
      ADDRAWRADDR(10) => sig0000011b,
      ADDRAWRADDR(9) => sig0000011a,
      ADDRAWRADDR(8) => sig00000119,
      ADDRAWRADDR(7) => sig00000118,
      ADDRAWRADDR(6) => sig00000117,
      ADDRAWRADDR(5) => sig00000116,
      ADDRAWRADDR(4) => blk000000e8_sig000003dd,
      ADDRAWRADDR(3) => blk000000e8_sig000003dd,
      ADDRAWRADDR(2) => blk000000e8_sig000003dd,
      ADDRAWRADDR(1) => blk000000e8_sig000003dd,
      ADDRAWRADDR(0) => blk000000e8_sig000003dd,
      DIPBDIP(1) => blk000000e8_sig000003dd,
      DIPBDIP(0) => blk000000e8_sig000003dd,
      DIBDI(15) => blk000000e8_sig000003dd,
      DIBDI(14) => blk000000e8_sig000003dd,
      DIBDI(13) => blk000000e8_sig000003dd,
      DIBDI(12) => blk000000e8_sig000003dd,
      DIBDI(11) => blk000000e8_sig000003dd,
      DIBDI(10) => blk000000e8_sig000003dd,
      DIBDI(9) => blk000000e8_sig000003dd,
      DIBDI(8) => blk000000e8_sig000003dd,
      DIBDI(7) => blk000000e8_sig000003dd,
      DIBDI(6) => blk000000e8_sig000003dd,
      DIBDI(5) => blk000000e8_sig000003dd,
      DIBDI(4) => blk000000e8_sig000003dd,
      DIBDI(3) => blk000000e8_sig000003dd,
      DIBDI(2) => blk000000e8_sig000003dd,
      DIBDI(1) => blk000000e8_sig000003dd,
      DIBDI(0) => blk000000e8_sig000003dd,
      DIADI(15) => blk000000e8_sig000003dd,
      DIADI(14) => sig00000095,
      DIADI(13) => sig00000094,
      DIADI(12) => sig00000093,
      DIADI(11) => sig00000092,
      DIADI(10) => sig00000091,
      DIADI(9) => sig00000090,
      DIADI(8) => sig0000008f,
      DIADI(7) => sig0000008d,
      DIADI(6) => sig0000008c,
      DIADI(5) => sig0000008b,
      DIADI(4) => sig0000008a,
      DIADI(3) => sig00000089,
      DIADI(2) => sig00000088,
      DIADI(1) => sig00000087,
      DIADI(0) => sig00000086,
      ADDRBRDADDR(12) => sig00000115,
      ADDRBRDADDR(11) => sig00000114,
      ADDRBRDADDR(10) => sig00000113,
      ADDRBRDADDR(9) => sig00000112,
      ADDRBRDADDR(8) => sig00000111,
      ADDRBRDADDR(7) => sig00000110,
      ADDRBRDADDR(6) => sig0000010f,
      ADDRBRDADDR(5) => sig0000010e,
      ADDRBRDADDR(4) => blk000000e8_sig000003dd,
      ADDRBRDADDR(3) => blk000000e8_sig000003dd,
      ADDRBRDADDR(2) => blk000000e8_sig000003dd,
      ADDRBRDADDR(1) => blk000000e8_sig000003dd,
      ADDRBRDADDR(0) => blk000000e8_sig000003dd,
      DOBDO(15) => NLW_blk000000e8_blk000000fa_DOBDO_15_UNCONNECTED,
      DOBDO(14) => NLW_blk000000e8_blk000000fa_DOBDO_14_UNCONNECTED,
      DOBDO(13) => NLW_blk000000e8_blk000000fa_DOBDO_13_UNCONNECTED,
      DOBDO(12) => NLW_blk000000e8_blk000000fa_DOBDO_12_UNCONNECTED,
      DOBDO(11) => NLW_blk000000e8_blk000000fa_DOBDO_11_UNCONNECTED,
      DOBDO(10) => NLW_blk000000e8_blk000000fa_DOBDO_10_UNCONNECTED,
      DOBDO(9) => NLW_blk000000e8_blk000000fa_DOBDO_9_UNCONNECTED,
      DOBDO(8) => NLW_blk000000e8_blk000000fa_DOBDO_8_UNCONNECTED,
      DOBDO(7) => NLW_blk000000e8_blk000000fa_DOBDO_7_UNCONNECTED,
      DOBDO(6) => NLW_blk000000e8_blk000000fa_DOBDO_6_UNCONNECTED,
      DOBDO(5) => NLW_blk000000e8_blk000000fa_DOBDO_5_UNCONNECTED,
      DOBDO(4) => NLW_blk000000e8_blk000000fa_DOBDO_4_UNCONNECTED,
      DOBDO(3) => NLW_blk000000e8_blk000000fa_DOBDO_3_UNCONNECTED,
      DOBDO(2) => NLW_blk000000e8_blk000000fa_DOBDO_2_UNCONNECTED,
      DOBDO(1) => NLW_blk000000e8_blk000000fa_DOBDO_1_UNCONNECTED,
      DOBDO(0) => NLW_blk000000e8_blk000000fa_DOBDO_0_UNCONNECTED,
      DIPADIP(1) => blk000000e8_sig000003dd,
      DIPADIP(0) => sig0000008e
    );
  blk000000e8_blk000000f9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c5,
      Q => sig000000e5
    );
  blk000000e8_blk000000f8 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c6,
      Q => sig000000e4
    );
  blk000000e8_blk000000f7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c7,
      Q => sig000000e3
    );
  blk000000e8_blk000000f6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c8,
      Q => sig000000e2
    );
  blk000000e8_blk000000f5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c9,
      Q => sig000000e1
    );
  blk000000e8_blk000000f4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003ca,
      Q => sig000000e0
    );
  blk000000e8_blk000000f3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003cb,
      Q => sig000000df
    );
  blk000000e8_blk000000f2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003cc,
      Q => sig000000de
    );
  blk000000e8_blk000000f1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003bd,
      Q => sig000000dd
    );
  blk000000e8_blk000000f0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003be,
      Q => sig000000dc
    );
  blk000000e8_blk000000ef : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003bf,
      Q => sig000000db
    );
  blk000000e8_blk000000ee : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c0,
      Q => sig000000da
    );
  blk000000e8_blk000000ed : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c1,
      Q => sig000000d9
    );
  blk000000e8_blk000000ec : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c2,
      Q => sig000000d8
    );
  blk000000e8_blk000000eb : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c3,
      Q => sig000000d7
    );
  blk000000e8_blk000000ea : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000000e8_sig000003c4,
      Q => sig000000d6
    );
  blk000000e8_blk000000e9 : GND
    port map (
      G => blk000000e8_sig000003dd
    );
  blk0000011b_blk0000011c_blk00000120 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk0000011b_blk0000011c_sig000003e9,
      Q => sig000000d5
    );
  blk0000011b_blk0000011c_blk0000011f : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => blk0000011b_blk0000011c_sig000003e7,
      A1 => blk0000011b_blk0000011c_sig000003e8,
      A2 => blk0000011b_blk0000011c_sig000003e7,
      A3 => blk0000011b_blk0000011c_sig000003e7,
      CE => ce,
      CLK => clk,
      D => sig00000008,
      Q => blk0000011b_blk0000011c_sig000003e9,
      Q15 => NLW_blk0000011b_blk0000011c_blk0000011f_Q15_UNCONNECTED
    );
  blk0000011b_blk0000011c_blk0000011e : VCC
    port map (
      P => blk0000011b_blk0000011c_sig000003e8
    );
  blk0000011b_blk0000011c_blk0000011d : GND
    port map (
      G => blk0000011b_blk0000011c_sig000003e7
    );
  blk00000141_blk00000142_blk00000146 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk00000141_blk00000142_sig000003f4,
      Q => sig000000c4
    );
  blk00000141_blk00000142_blk00000145 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => blk00000141_blk00000142_sig000003f3,
      A1 => blk00000141_blk00000142_sig000003f2,
      A2 => blk00000141_blk00000142_sig000003f3,
      A3 => blk00000141_blk00000142_sig000003f2,
      CE => ce,
      CLK => clk,
      D => sig00000065,
      Q => blk00000141_blk00000142_sig000003f4,
      Q15 => NLW_blk00000141_blk00000142_blk00000145_Q15_UNCONNECTED
    );
  blk00000141_blk00000142_blk00000144 : VCC
    port map (
      P => blk00000141_blk00000142_sig000003f3
    );
  blk00000141_blk00000142_blk00000143 : GND
    port map (
      G => blk00000141_blk00000142_sig000003f2
    );
  blk000001f1_blk000001f2_blk000001f6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000001f1_blk000001f2_sig00000400,
      Q => sig0000000a
    );
  blk000001f1_blk000001f2_blk000001f5 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => blk000001f1_blk000001f2_sig000003ff,
      A1 => blk000001f1_blk000001f2_sig000003fe,
      A2 => blk000001f1_blk000001f2_sig000003fe,
      A3 => blk000001f1_blk000001f2_sig000003fe,
      CE => ce,
      CLK => clk,
      D => sig000002ca,
      Q => blk000001f1_blk000001f2_sig00000400,
      Q15 => NLW_blk000001f1_blk000001f2_blk000001f5_Q15_UNCONNECTED
    );
  blk000001f1_blk000001f2_blk000001f4 : VCC
    port map (
      P => blk000001f1_blk000001f2_sig000003ff
    );
  blk000001f1_blk000001f2_blk000001f3 : GND
    port map (
      G => blk000001f1_blk000001f2_sig000003fe
    );
  blk00000224_blk00000225_blk00000227 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk00000224_blk00000225_sig0000040a,
      R => sclr,
      Q => sig00000301
    );
  blk00000224_blk00000225_blk00000226 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => sig00000302,
      Q => blk00000224_blk00000225_sig0000040a
    );
  blk00000228_blk00000240 : INV
    port map (
      I => sig000002e1,
      O => blk00000228_sig00000425
    );
  blk00000228_blk0000023f : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig000002e2,
      O => blk00000228_sig0000042b
    );
  blk00000228_blk0000023e : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig000002e3,
      O => blk00000228_sig0000042a
    );
  blk00000228_blk0000023d : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig000002e4,
      O => blk00000228_sig00000429
    );
  blk00000228_blk0000023c : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig000002e5,
      O => blk00000228_sig00000428
    );
  blk00000228_blk0000023b : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig000002e6,
      O => blk00000228_sig00000427
    );
  blk00000228_blk0000023a : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig000002e7,
      O => blk00000228_sig00000426
    );
  blk00000228_blk00000239 : MUXCY
    port map (
      CI => blk00000228_sig0000041d,
      DI => blk00000228_sig0000041c,
      S => blk00000228_sig00000425,
      O => blk00000228_sig00000424
    );
  blk00000228_blk00000238 : XORCY
    port map (
      CI => blk00000228_sig0000041d,
      LI => blk00000228_sig00000425,
      O => sig000002d0
    );
  blk00000228_blk00000237 : XORCY
    port map (
      CI => blk00000228_sig0000041e,
      LI => sig000002e8,
      O => sig000002d7
    );
  blk00000228_blk00000236 : MUXCY
    port map (
      CI => blk00000228_sig00000424,
      DI => blk00000228_sig0000041d,
      S => blk00000228_sig0000042b,
      O => blk00000228_sig00000423
    );
  blk00000228_blk00000235 : XORCY
    port map (
      CI => blk00000228_sig00000424,
      LI => blk00000228_sig0000042b,
      O => sig000002d1
    );
  blk00000228_blk00000234 : MUXCY
    port map (
      CI => blk00000228_sig00000423,
      DI => blk00000228_sig0000041d,
      S => blk00000228_sig0000042a,
      O => blk00000228_sig00000422
    );
  blk00000228_blk00000233 : XORCY
    port map (
      CI => blk00000228_sig00000423,
      LI => blk00000228_sig0000042a,
      O => sig000002d2
    );
  blk00000228_blk00000232 : MUXCY
    port map (
      CI => blk00000228_sig00000422,
      DI => blk00000228_sig0000041d,
      S => blk00000228_sig00000429,
      O => blk00000228_sig00000421
    );
  blk00000228_blk00000231 : XORCY
    port map (
      CI => blk00000228_sig00000422,
      LI => blk00000228_sig00000429,
      O => sig000002d3
    );
  blk00000228_blk00000230 : MUXCY
    port map (
      CI => blk00000228_sig00000421,
      DI => blk00000228_sig0000041d,
      S => blk00000228_sig00000428,
      O => blk00000228_sig00000420
    );
  blk00000228_blk0000022f : XORCY
    port map (
      CI => blk00000228_sig00000421,
      LI => blk00000228_sig00000428,
      O => sig000002d4
    );
  blk00000228_blk0000022e : MUXCY
    port map (
      CI => blk00000228_sig00000420,
      DI => blk00000228_sig0000041d,
      S => blk00000228_sig00000427,
      O => blk00000228_sig0000041f
    );
  blk00000228_blk0000022d : XORCY
    port map (
      CI => blk00000228_sig00000420,
      LI => blk00000228_sig00000427,
      O => sig000002d5
    );
  blk00000228_blk0000022c : MUXCY
    port map (
      CI => blk00000228_sig0000041f,
      DI => blk00000228_sig0000041d,
      S => blk00000228_sig00000426,
      O => blk00000228_sig0000041e
    );
  blk00000228_blk0000022b : XORCY
    port map (
      CI => blk00000228_sig0000041f,
      LI => blk00000228_sig00000426,
      O => sig000002d6
    );
  blk00000228_blk0000022a : GND
    port map (
      G => blk00000228_sig0000041d
    );
  blk00000228_blk00000229 : VCC
    port map (
      P => blk00000228_sig0000041c
    );
  blk00000279_blk0000027a_blk0000027e : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk00000279_blk0000027a_sig00000436,
      Q => sig0000023d
    );
  blk00000279_blk0000027a_blk0000027d : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => blk00000279_blk0000027a_sig00000434,
      A1 => blk00000279_blk0000027a_sig00000435,
      A2 => blk00000279_blk0000027a_sig00000434,
      A3 => blk00000279_blk0000027a_sig00000435,
      CE => ce,
      CLK => clk,
      D => sig00000247,
      Q => blk00000279_blk0000027a_sig00000436,
      Q15 => NLW_blk00000279_blk0000027a_blk0000027d_Q15_UNCONNECTED
    );
  blk00000279_blk0000027a_blk0000027c : VCC
    port map (
      P => blk00000279_blk0000027a_sig00000435
    );
  blk00000279_blk0000027a_blk0000027b : GND
    port map (
      G => blk00000279_blk0000027a_sig00000434
    );
  blk0000027f_blk00000280_blk00000284 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk0000027f_blk00000280_sig00000441,
      Q => sig0000023e
    );
  blk0000027f_blk00000280_blk00000283 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => blk0000027f_blk00000280_sig00000440,
      A1 => blk0000027f_blk00000280_sig0000043f,
      A2 => blk0000027f_blk00000280_sig00000440,
      A3 => blk0000027f_blk00000280_sig00000440,
      CE => ce,
      CLK => clk,
      D => sig0000023f,
      Q => blk0000027f_blk00000280_sig00000441,
      Q15 => NLW_blk0000027f_blk00000280_blk00000283_Q15_UNCONNECTED
    );
  blk0000027f_blk00000280_blk00000282 : VCC
    port map (
      P => blk0000027f_blk00000280_sig00000440
    );
  blk0000027f_blk00000280_blk00000281 : GND
    port map (
      G => blk0000027f_blk00000280_sig0000043f
    );
  blk00000285_blk00000291 : INV
    port map (
      I => sig0000027b,
      O => blk00000285_sig0000044f
    );
  blk00000285_blk00000290 : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig0000027a,
      O => blk00000285_sig00000451
    );
  blk00000285_blk0000028f : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig00000279,
      O => blk00000285_sig00000450
    );
  blk00000285_blk0000028e : MUXCY
    port map (
      CI => blk00000285_sig0000044b,
      DI => blk00000285_sig0000044a,
      S => blk00000285_sig0000044f,
      O => blk00000285_sig0000044e
    );
  blk00000285_blk0000028d : XORCY
    port map (
      CI => blk00000285_sig0000044b,
      LI => blk00000285_sig0000044f,
      O => sig00000283
    );
  blk00000285_blk0000028c : XORCY
    port map (
      CI => blk00000285_sig0000044c,
      LI => sig00000278,
      O => sig00000280
    );
  blk00000285_blk0000028b : MUXCY
    port map (
      CI => blk00000285_sig0000044e,
      DI => blk00000285_sig0000044b,
      S => blk00000285_sig00000451,
      O => blk00000285_sig0000044d
    );
  blk00000285_blk0000028a : XORCY
    port map (
      CI => blk00000285_sig0000044e,
      LI => blk00000285_sig00000451,
      O => sig00000282
    );
  blk00000285_blk00000289 : MUXCY
    port map (
      CI => blk00000285_sig0000044d,
      DI => blk00000285_sig0000044b,
      S => blk00000285_sig00000450,
      O => blk00000285_sig0000044c
    );
  blk00000285_blk00000288 : XORCY
    port map (
      CI => blk00000285_sig0000044d,
      LI => blk00000285_sig00000450,
      O => sig00000281
    );
  blk00000285_blk00000287 : GND
    port map (
      G => blk00000285_sig0000044b
    );
  blk00000285_blk00000286 : VCC
    port map (
      P => blk00000285_sig0000044a
    );
  blk00000292_blk00000293_blk00000297 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk00000292_blk00000293_sig0000045d,
      Q => sig00000005
    );
  blk00000292_blk00000293_blk00000296 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => blk00000292_blk00000293_sig0000045c,
      A1 => blk00000292_blk00000293_sig0000045b,
      A2 => blk00000292_blk00000293_sig0000045b,
      A3 => blk00000292_blk00000293_sig0000045b,
      CE => ce,
      CLK => clk,
      D => NlwRenamedSig_OI_U0_i_synth_non_floating_point_arch_e_xfft_inst_control_addr_gen_io_addr_gen_rfd_i,
      Q => blk00000292_blk00000293_sig0000045d,
      Q15 => NLW_blk00000292_blk00000293_blk00000296_Q15_UNCONNECTED
    );
  blk00000292_blk00000293_blk00000295 : VCC
    port map (
      P => blk00000292_blk00000293_sig0000045c
    );
  blk00000292_blk00000293_blk00000294 : GND
    port map (
      G => blk00000292_blk00000293_sig0000045b
    );
  blk00000298_blk00000299_blk0000029d : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk00000298_blk00000299_sig00000469,
      Q => sig00000330
    );
  blk00000298_blk00000299_blk0000029c : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => blk00000298_blk00000299_sig00000467,
      A1 => blk00000298_blk00000299_sig00000468,
      A2 => blk00000298_blk00000299_sig00000467,
      A3 => blk00000298_blk00000299_sig00000467,
      CE => ce,
      CLK => clk,
      D => sig0000028d,
      Q => blk00000298_blk00000299_sig00000469,
      Q15 => NLW_blk00000298_blk00000299_blk0000029c_Q15_UNCONNECTED
    );
  blk00000298_blk00000299_blk0000029b : VCC
    port map (
      P => blk00000298_blk00000299_sig00000468
    );
  blk00000298_blk00000299_blk0000029a : GND
    port map (
      G => blk00000298_blk00000299_sig00000467
    );
  blk0000029e_blk0000029f_blk000002a3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk0000029e_blk0000029f_sig00000475,
      Q => sig00000339
    );
  blk0000029e_blk0000029f_blk000002a2 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => blk0000029e_blk0000029f_sig00000473,
      A1 => blk0000029e_blk0000029f_sig00000474,
      A2 => blk0000029e_blk0000029f_sig00000473,
      A3 => blk0000029e_blk0000029f_sig00000473,
      CE => ce,
      CLK => clk,
      D => sig00000004,
      Q => blk0000029e_blk0000029f_sig00000475,
      Q15 => NLW_blk0000029e_blk0000029f_blk000002a2_Q15_UNCONNECTED
    );
  blk0000029e_blk0000029f_blk000002a1 : VCC
    port map (
      P => blk0000029e_blk0000029f_sig00000474
    );
  blk0000029e_blk0000029f_blk000002a0 : GND
    port map (
      G => blk0000029e_blk0000029f_sig00000473
    );
  blk000002be_blk000002de : INV
    port map (
      I => sig00000325,
      O => blk000002be_sig0000049a
    );
  blk000002be_blk000002dd : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig00000326,
      O => blk000002be_sig000004a0
    );
  blk000002be_blk000002dc : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig00000327,
      O => blk000002be_sig0000049f
    );
  blk000002be_blk000002db : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig00000328,
      O => blk000002be_sig0000049e
    );
  blk000002be_blk000002da : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig00000329,
      O => blk000002be_sig0000049d
    );
  blk000002be_blk000002d9 : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig0000032a,
      O => blk000002be_sig0000049c
    );
  blk000002be_blk000002d8 : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => sig0000032b,
      O => blk000002be_sig0000049b
    );
  blk000002be_blk000002d7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000002be_sig00000498,
      R => sclr,
      Q => NlwRenamedSig_OI_xn_index(0)
    );
  blk000002be_blk000002d6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000002be_sig00000495,
      R => sclr,
      Q => NlwRenamedSig_OI_xn_index(1)
    );
  blk000002be_blk000002d5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000002be_sig00000493,
      R => sclr,
      Q => NlwRenamedSig_OI_xn_index(2)
    );
  blk000002be_blk000002d4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000002be_sig00000491,
      R => sclr,
      Q => NlwRenamedSig_OI_xn_index(3)
    );
  blk000002be_blk000002d3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000002be_sig0000048f,
      R => sclr,
      Q => NlwRenamedSig_OI_xn_index(4)
    );
  blk000002be_blk000002d2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000002be_sig0000048d,
      R => sclr,
      Q => NlwRenamedSig_OI_xn_index(5)
    );
  blk000002be_blk000002d1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000002be_sig0000048b,
      R => sclr,
      Q => NlwRenamedSig_OI_xn_index(6)
    );
  blk000002be_blk000002d0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => ce,
      D => blk000002be_sig00000497,
      R => sclr,
      Q => NlwRenamedSig_OI_xn_index(7)
    );
  blk000002be_blk000002cf : MUXCY
    port map (
      CI => blk000002be_sig0000048a,
      DI => blk000002be_sig00000489,
      S => blk000002be_sig0000049a,
      O => blk000002be_sig00000499
    );
  blk000002be_blk000002ce : XORCY
    port map (
      CI => blk000002be_sig0000048a,
      LI => blk000002be_sig0000049a,
      O => blk000002be_sig00000498
    );
  blk000002be_blk000002cd : XORCY
    port map (
      CI => blk000002be_sig0000048c,
      LI => sig0000032c,
      O => blk000002be_sig00000497
    );
  blk000002be_blk000002cc : MUXCY
    port map (
      CI => blk000002be_sig00000499,
      DI => blk000002be_sig0000048a,
      S => blk000002be_sig000004a0,
      O => blk000002be_sig00000496
    );
  blk000002be_blk000002cb : XORCY
    port map (
      CI => blk000002be_sig00000499,
      LI => blk000002be_sig000004a0,
      O => blk000002be_sig00000495
    );
  blk000002be_blk000002ca : MUXCY
    port map (
      CI => blk000002be_sig00000496,
      DI => blk000002be_sig0000048a,
      S => blk000002be_sig0000049f,
      O => blk000002be_sig00000494
    );
  blk000002be_blk000002c9 : XORCY
    port map (
      CI => blk000002be_sig00000496,
      LI => blk000002be_sig0000049f,
      O => blk000002be_sig00000493
    );
  blk000002be_blk000002c8 : MUXCY
    port map (
      CI => blk000002be_sig00000494,
      DI => blk000002be_sig0000048a,
      S => blk000002be_sig0000049e,
      O => blk000002be_sig00000492
    );
  blk000002be_blk000002c7 : XORCY
    port map (
      CI => blk000002be_sig00000494,
      LI => blk000002be_sig0000049e,
      O => blk000002be_sig00000491
    );
  blk000002be_blk000002c6 : MUXCY
    port map (
      CI => blk000002be_sig00000492,
      DI => blk000002be_sig0000048a,
      S => blk000002be_sig0000049d,
      O => blk000002be_sig00000490
    );
  blk000002be_blk000002c5 : XORCY
    port map (
      CI => blk000002be_sig00000492,
      LI => blk000002be_sig0000049d,
      O => blk000002be_sig0000048f
    );
  blk000002be_blk000002c4 : MUXCY
    port map (
      CI => blk000002be_sig00000490,
      DI => blk000002be_sig0000048a,
      S => blk000002be_sig0000049c,
      O => blk000002be_sig0000048e
    );
  blk000002be_blk000002c3 : XORCY
    port map (
      CI => blk000002be_sig00000490,
      LI => blk000002be_sig0000049c,
      O => blk000002be_sig0000048d
    );
  blk000002be_blk000002c2 : MUXCY
    port map (
      CI => blk000002be_sig0000048e,
      DI => blk000002be_sig0000048a,
      S => blk000002be_sig0000049b,
      O => blk000002be_sig0000048c
    );
  blk000002be_blk000002c1 : XORCY
    port map (
      CI => blk000002be_sig0000048e,
      LI => blk000002be_sig0000049b,
      O => blk000002be_sig0000048b
    );
  blk000002be_blk000002c0 : GND
    port map (
      G => blk000002be_sig0000048a
    );
  blk000002be_blk000002bf : VCC
    port map (
      P => blk000002be_sig00000489
    );

end STRUCTURE;

-- synthesis translate_on
