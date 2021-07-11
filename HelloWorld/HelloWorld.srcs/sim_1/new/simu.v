`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/11 09:01:32
// Design Name: 
// Module Name: simu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simu();
       reg [5:0] a;
       reg [5:0] b;
       reg [5:0] c;
       reg [5:0] d;
       wire[7:0] e;
       reg [5:0] i; //中间变量
       // 调用被仿真模块模块
test myTest (.a(a), .b(b),.c(c),.d(d),.e(e));
initial begin // initial是仿真用的初始化关键词
a=0;b=0;c=0;d=0; // 必须初始化输入信号
for(i=1;i<31;i=i+1) begin
              #10 ;
              a = i;
              b = i;
              c = i;
              d = i;
       end // 给是输入信号a 赋值
end
initial begin
       $monitor($time,,,"%d + %d + %d + %d ={%d}",a,b,c,d,e); // 信号打印输出
       #500 $finish;
end
endmodule
