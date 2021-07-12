`timescale 1ns / 1ps
module minisys_sim();
    // input
    reg clk = 0;
    reg rst = 1;
    reg switch2N4 = 8'b10101100;
    
    // output
    wire led2N4;
    
    minisys u (
        .clk(clk),
        .rst(rst), 
        .led2N4(led2N4), 
        .switch2N4(switch2N4)
    );
    initial begin
        #7000 rst = 0;
    end
    always #10 clk=~clk;
        
endmodule
