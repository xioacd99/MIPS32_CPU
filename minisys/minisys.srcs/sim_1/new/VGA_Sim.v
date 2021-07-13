`timescale 1s / 1ps

module VGA_Sim();
    reg clk;
    reg rst;  
    reg [31:0] CPU_outcome;

    wire [3:0] r;
    wire [3:0] g;  
    wire [3:0] b;  
    wire hs;
    wire vs; 

    vga_char_display VGA_1(
        clk,  
        rst,
        CPU_outcome,
        r,
        g,
        b,
        hs,
        vs
    );
    
initial begin
    #1 
    begin 
        rst = 0;
        CPU_outcome = 32'h00000002;
        clk = 0;
    end;
    #1 
        rst = 1;
    #1 
    rst = 0;
end
    always #1 clk = ~clk;
endmodule
