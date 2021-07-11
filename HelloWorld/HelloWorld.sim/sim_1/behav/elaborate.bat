@echo off
set xv_path=E:\\Xilinx\\Vivado\\2015.4\\bin
call %xv_path%/xelab  -wto 2a1bf3b715e041a5a6a4583329186536 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot simu_behav xil_defaultlib.simu xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
