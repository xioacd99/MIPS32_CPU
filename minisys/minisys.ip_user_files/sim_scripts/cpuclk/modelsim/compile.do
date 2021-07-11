vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../minisys.srcs/sources_1/ip/cpuclk/cpuclk_clk_wiz.v" \
"../../../../minisys.srcs/sources_1/ip/cpuclk/cpuclk.v" \


vlog -work xil_defaultlib "glbl.v"

