
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name FFT -dir "/root/FPGA-MISC/FFT with VGA/planAhead_run_2" -part xc6slx16csg324-3
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "/root/FPGA-MISC/FFT with VGA/fft_flow_4_no_fifos.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/root/FPGA-MISC/FFT with VGA} {ipcore_dir} }
add_files [list {ipcore_dir/clk_test_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/flow_3_adc_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_flow_dds.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/adc_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/flow2_fft_ram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/dds.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_burst_mode.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/flow2_fft.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/sqrt_core.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/flow2_adc_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_flow_fft.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "fft_flow.ucf" [current_fileset -constrset]
add_files [list {fft_flow.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "/root/FPGA-MISC/FFT with VGA/fft_flow_4_no_fifos.ncd"
if {[catch {read_twx -name results_1 -file "/root/FPGA-MISC/FFT with VGA/fft_flow_4_no_fifos.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"/root/FPGA-MISC/FFT with VGA/fft_flow_4_no_fifos.twx\": $eInfo"
}
