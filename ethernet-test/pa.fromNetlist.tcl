
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name ethernet-test -dir "/mnt/hgfs/git/FPGA-MISC/ethernet-test/planAhead_run_1" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/mnt/hgfs/git/FPGA-MISC/ethernet-test/ethernet.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/mnt/hgfs/git/FPGA-MISC/ethernet-test} {ipcore_dir} }
add_files [list {ipcore_dir/fifo.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "master.ucf" [current_fileset -constrset]
add_files [list {master.ucf}] -fileset [get_property constrset [current_run]]
link_design
