`timescale 1ns / 1ps
module cpuclk_sim();
    //  INPUT
    reg pclk = 0;
    //output
    wire clock;
    
    cpuclk UCLK(
        .clk_in1(pclk),     //100MHz
        .clk_out1(clock)    //cpuclock
    );
    
    always #5 pclk = ~pclk;
endmodule
