# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tfgg484-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir F:/.vscode/Github/MIPS32_CPU/minisys/minisys.cache/wt [current_project]
set_property parent.project_path F:/.vscode/Github/MIPS32_CPU/minisys/minisys.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgmip32.coe
add_files F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/ram/dmem32.coe
read_verilog -library xil_defaultlib F:/.vscode/Github/MIPS32_CPU/minisys/classfiles/minisys2.0/control32.v
read_xdc F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/constrs_1/imports/xdc/minisys.xdc
set_property used_in_implementation false [get_files F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/constrs_1/imports/xdc/minisys.xdc]

synth_design -top control32 -part xc7a100tfgg484-1
write_checkpoint -noxdef control32.dcp
catch { report_utilization -file control32_utilization_synth.rpt -pb control32_utilization_synth.pb }