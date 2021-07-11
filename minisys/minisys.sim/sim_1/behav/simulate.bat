@echo off
set xv_path=D:\\Vivado_application\\Vivado\\2015.4\\bin
call %xv_path%/xsim VGA_Sim_behav -key {Behavioral:sim_1:Functional:VGA_Sim} -tclbatch VGA_Sim.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
