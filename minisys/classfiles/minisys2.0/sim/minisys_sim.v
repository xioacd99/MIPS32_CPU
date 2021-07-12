`timescale 1ns / 1ps

module minisys_sim();
    // input
    reg clk = 0;
    reg rst = 1;
    
    minisys u (
        .clk(clk),
        .rst(rst)
    );
    initial begin
        #7000 rst = 0;
    end
    always #10 clk=~clk;
        
endmodule
