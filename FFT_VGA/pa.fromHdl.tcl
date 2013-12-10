
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name FFT_VGA -dir "/root/FPGA-MISC/FFT_VGA/planAhead_run_2" -part xc6slx16csg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "fft_flow.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {ipcore_dir/dcm.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
add_files [list {ipcore_dir/fft_core.ngc}]
set hdlfile [add_files [list {ipcore_dir/adc_ram.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/multiplier.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/fft_ram_simple.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/sqrt.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/vga_ram.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {lib.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {vga_configurable.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
add_files [list {ipcore_dir/vga_ram.ngc}]
add_files [list {ipcore_dir/sqrt.ngc}]
add_files [list {ipcore_dir/multiplier.ngc}]
add_files [list {ipcore_dir/fft_ram_simple.ngc}]
set hdlfile [add_files [list {ipcore_dir/fft_core.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
add_files [list {ipcore_dir/adc_ram.ngc}]
set hdlfile [add_files [list {fft_ram.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
add_files [list {fft.ngc}]
set_property top fft_with_ram $srcset
add_files [list {fft_flow.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_ram_simple.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/vga_ram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/adc_ram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/multiplier.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_ram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_core.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/adc_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/sqrt.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-3
