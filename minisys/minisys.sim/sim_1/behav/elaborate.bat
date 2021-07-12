@echo off
set xv_path=E:\\Xilinx\\Vivado\\2015.4\\bin
call %xv_path%/xelab  -wto c180edc3119f49e5a7693aeac972597b -m64 --debug typical --relax --mt 2 -L blk_mem_gen_v8_3_1 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot minisys_sim_behav xil_defaultlib.minisys_sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
