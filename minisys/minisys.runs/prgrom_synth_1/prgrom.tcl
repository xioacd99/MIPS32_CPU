# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tfgg484-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir F:/.vscode/Github/MIPS32_CPU/minisys/minisys.cache/wt [current_project]
set_property parent.project_path F:/.vscode/Github/MIPS32_CPU/minisys/minisys.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_ip F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom.xci
set_property used_in_implementation false [get_files -all f:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom.dcp]
set_property is_locked true [get_files F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom.xci]

synth_design -top prgrom -part xc7a100tfgg484-1 -mode out_of_context
rename_ref -prefix_all prgrom_
write_checkpoint -noxdef prgrom.dcp
catch { report_utilization -file prgrom_utilization_synth.rpt -pb prgrom_utilization_synth.pb }
if { [catch {
  file copy -force F:/.vscode/Github/MIPS32_CPU/minisys/minisys.runs/prgrom_synth_1/prgrom.dcp F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}
if { [catch {
  write_verilog -force -mode synth_stub F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode synth_stub F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_verilog -force -mode funcsim F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode funcsim F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if {[file isdir F:/.vscode/Github/MIPS32_CPU/minisys/minisys.ip_user_files/ip/prgrom]} {
  catch { 
    file copy -force F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom_stub.v F:/.vscode/Github/MIPS32_CPU/minisys/minisys.ip_user_files/ip/prgrom
  }
}

if {[file isdir F:/.vscode/Github/MIPS32_CPU/minisys/minisys.ip_user_files/ip/prgrom]} {
  catch { 
    file copy -force F:/.vscode/Github/MIPS32_CPU/minisys/minisys.srcs/sources_1/ip/prgrom/prgrom_stub.vhdl F:/.vscode/Github/MIPS32_CPU/minisys/minisys.ip_user_files/ip/prgrom
  }
}
