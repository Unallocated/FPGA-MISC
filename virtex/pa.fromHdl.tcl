
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name virtex -dir "/root/FPGA-MISC/virtex/planAhead_run_3" -part xc4vsx55ff1148-12
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "virtex_55.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {t_pll.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {virtex_55.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top virtex_55 $srcset
add_files [list {virtex_55.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc4vsx55ff1148-12
