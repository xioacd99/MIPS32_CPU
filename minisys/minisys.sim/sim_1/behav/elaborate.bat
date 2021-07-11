@echo off
set xv_path=D:\\Vivado_application\\Vivado\\2015.4\\bin
call %xv_path%/xelab  -wto c180edc3119f49e5a7693aeac972597b -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot VGA_Sim_behav xil_defaultlib.VGA_Sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
