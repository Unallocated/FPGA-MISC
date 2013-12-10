
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name FFT_VGA -dir "/root/FPGA-MISC/FFT_VGA/planAhead_run_1" -part xc6slx16csg324-3
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "/root/FPGA-MISC/FFT_VGA/fft_with_ram.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/root/FPGA-MISC/FFT_VGA} {ipcore_dir} }
add_files [list {ipcore_dir/fft_ram_simple.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/vga_ram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/adc_ram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/multiplier.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_ram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_core.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/adc_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/sqrt.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "/root/FPGA-MISC/FFT_VGA/fft_flow.ucf" [current_fileset -constrset]
add_files [list {fft_flow.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {fft_with_ram.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "/root/FPGA-MISC/FFT_VGA/fft_with_ram.ncd"
if {[catch {read_twx -name results_1 -file "/root/FPGA-MISC/FFT_VGA/fft_with_ram.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"/root/FPGA-MISC/FFT_VGA/fft_with_ram.twx\": $eInfo"
}
