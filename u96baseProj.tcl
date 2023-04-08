create_project u96base_1 /home/fgerid/work/u96base_1 -part xczu3eg-sbva484-1-i
set_property board_part avnet.com:ultra96v2:part0:1.2 [current_project]
set_property platform.extensible true [current_project]
create_bd_design "design_1"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ultra_ps_e_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {Auto}}  [get_bd_intf_pins axi_gpio_0/GPIO]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_FPD} Slave {/axi_gpio_0/S_AXI} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_gpio_0/S_AXI]
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {/zynq_ultra_ps_e_0/pl_clk0 (100 MHz)} Clk_xbar {/zynq_ultra_ps_e_0/pl_clk0 (100 MHz)} Master {/zynq_ultra_ps_e_0/M_AXI_HPM1_FPD} Slave {/axi_gpio_0/S_AXI} ddr_seg {Auto} intc_ip {/ps8_0_axi_periph} master_apm {0}}  [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM1_FPD]
regenerate_bd_layout
set_property PFM.CLOCK {pl_clk0 {id "0" is_default "false" proc_sys_reset "/proc_sys_reset_0" status "fixed" freq_hz "100000000"}} [get_bd_cells /zynq_ultra_ps_e_0]
set_property PFM.CLOCK {} [get_bd_cells /zynq_ultra_ps_e_0]
set_property PFM.CLOCK {pl_clk0 {id "0" is_default "false" proc_sys_reset "/proc_sys_reset_0" status "fixed" freq_hz "100000000"}} [get_bd_cells /zynq_ultra_ps_e_0]
set_property pfm_name design_1 [get_files {design_1.bd}]
set_property PFM.CLOCK {pl_clk0 {id "0" is_default "true" proc_sys_reset "/proc_sys_reset_0" status "fixed" freq_hz "100000000"}} [get_bd_cells /zynq_ultra_ps_e_0]
open_bd_design {/home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd}
set_property synth_checkpoint_mode None [get_files  /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd]
generate_target all [get_files  /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd]
export_ip_user_files -of_objects [get_files /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd] -no_script -sync -force -quiet
export_simulation -of_objects [get_files /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd] -directory /home/fgerid/work/u96base_1/u96base_1.ip_user_files/sim_scripts -ip_user_files_dir /home/fgerid/work/u96base_1/u96base_1.ip_user_files -ipstatic_source_dir /home/fgerid/work/u96base_1/u96base_1.ip_user_files/ipstatic -lib_map_path [list {modelsim=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/modelsim} {questa=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/questa} {ies=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/ies} {xcelium=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/xcelium} {vcs=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/vcs} {riviera=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
make_wrapper -files [get_files /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse /home/fgerid/work/u96base_1/u96base_1.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v
startgroup
set_property -dict [list CONFIG.C_GPIO_WIDTH {4}] [get_bd_cells axi_gpio_0]
endgroup
startgroup
set_property -dict [list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_OUTPUTS {1}] [get_bd_cells axi_gpio_0]
endgroup
set_property name gpio_out [get_bd_intf_ports gpio_rtl]
save_bd_design
reset_target all [get_files  /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd]
export_ip_user_files -of_objects  [get_files  /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd] -sync -no_script -force -quiet
generate_target all [get_files  /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd]
export_ip_user_files -of_objects [get_files /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd] -no_script -sync -force -quiet
export_simulation -of_objects [get_files /home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd] -directory /home/fgerid/work/u96base_1/u96base_1.ip_user_files/sim_scripts -ip_user_files_dir /home/fgerid/work/u96base_1/u96base_1.ip_user_files -ipstatic_source_dir /home/fgerid/work/u96base_1/u96base_1.ip_user_files/ipstatic -lib_map_path [list {modelsim=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/modelsim} {questa=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/questa} {ies=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/ies} {xcelium=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/xcelium} {vcs=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/vcs} {riviera=/home/fgerid/work/u96base_1/u96base_1.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
launch_runs impl_1 -to_step write_bitstream -jobs 2
synth_design -rtl -rtl_skip_mlo -name rtl_1
set_property IOSTANDARD LVCMOS18 [get_ports [list {gpio_out_tri_o[3]}]]
set_property IOSTANDARD LVCMOS18 [get_ports [list {gpio_out_tri_o[3]}]]
set_property IOSTANDARD LVCMOS18 [get_ports [list {gpio_out_tri_o[2]}]]
set_property IOSTANDARD LVCMOS18 [get_ports [list {gpio_out_tri_o[1]}]]
set_property IOSTANDARD LVCMOS18 [get_ports [list {gpio_out_tri_o[0]}]]
reset_run impl_1 -prev_step 
file mkdir /home/fgerid/work/u96base_1/u96base_1.srcs/constrs_1/new
close [ open /home/fgerid/work/u96base_1/u96base_1.srcs/constrs_1/new/ultra.xdc w ]
add_files -fileset constrs_1 /home/fgerid/work/u96base_1/u96base_1.srcs/constrs_1/new/ultra.xdc
set_property target_constrs_file /home/fgerid/work/u96base_1/u96base_1.srcs/constrs_1/new/ultra.xdc [current_fileset -constrset]
save_constraints -force
reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 2
close_design
synth_design -rtl -rtl_skip_mlo -name rtl_1
place_ports {gpio_out_tri_o[3]} A2
place_ports {gpio_out_tri_o[2]} A4
place_ports {gpio_out_tri_o[1]} A6
place_ports {gpio_out_tri_o[0]} A7
place_ports {gpio_out_tri_o[0]} A8
reset_run impl_1 -prev_step 
save_constraints
reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 2
set_property pfm_name {xilinx:ultra96v2:name:0.0} [get_files -all {/home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd}]
set_property platform.name {name} [current_project]
write_hw_platform -include_bit -force -file /home/fgerid/work/u96base_1/u96base_1_wrapper.xsa
close_design
open_run impl_1
set_property pfm_name {xilinx:ultra96v2:name:0.0} [get_files -all {/home/fgerid/work/u96base_1/u96base_1.srcs/sources_1/bd/design_1/design_1.bd}]
write_hw_platform -force -file /home/fgerid/work/u96base_1/u96base_1_wrapper.xsa

