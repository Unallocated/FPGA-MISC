
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name FFT -dir "C:/Users/main-local/Desktop/FFT/planAhead_run_1" -part xc6slx16csg324-3
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "C:/Users/main-local/Desktop/FFT/fft_flow.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/main-local/Desktop/FFT} {ipcore_dir} }
add_files [list {ipcore_dir/adc_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/dds.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_flow_dds.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fft_flow_fft.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "fft_flow.ucf" [current_fileset -constrset]
add_files [list {fft_flow.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "C:/Users/main-local/Desktop/FFT/fft_flow.ncd"
if {[catch {read_twx -name results_1 -file "C:/Users/main-local/Desktop/FFT/fft_flow.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"C:/Users/main-local/Desktop/FFT/fft_flow.twx\": $eInfo"
}
