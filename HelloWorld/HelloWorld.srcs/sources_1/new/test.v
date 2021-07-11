`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/11 09:00:51
// Design Name: 
// Module Name: test
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


module test(a,b,c,d,e);// 模块接口
       input [5:0] a; // 输入信号a
       input [5:0] b; // 输入信号b
       input [5:0] c; // 输入信号c
       input [5:0] d; // 输入信号d
       output[7:0] e; // 求和输出信号
       wire [6:0]outa1,outa2; // 定义输出网线型
       assign e = outa2+outa1; // 把两部分输出结果合并
/*
通常，我们模块的调用写法如下：
被调用的模块名字- 自定义的名字- 括号内信号
这里比如括号内的信号，.ina(ina1)
这种写法最常用，信号的顺序可以调换
*/
       adder myadder1 (.ina(a),.inb(b),.outa(outa1));
       // 调用adder 模块，自定义名字为myadder1
       adder myadder2 (.ina(c),.inb(d),.outa(outa2));
       // 调用adder 模块，自定义名字为myadder2
endmodule
       //adder 子模块
module adder(ina,inb,outa );// 模块接口
       input [5:0] ina; // ina-输入信号
       input [5:0] inb; // inb-输入信号
       output [6:0] outa; // outa-输入信号
       assign outa = ina + inb; // 求和
      // 模块结束
endmodule
