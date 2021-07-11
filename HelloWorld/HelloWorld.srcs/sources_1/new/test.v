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


module test(a,b,c,d,e);// ģ��ӿ�
       input [5:0] a; // �����ź�a
       input [5:0] b; // �����ź�b
       input [5:0] c; // �����ź�c
       input [5:0] d; // �����ź�d
       output[7:0] e; // �������ź�
       wire [6:0]outa1,outa2; // �������������
       assign e = outa2+outa1; // ���������������ϲ�
/*
ͨ��������ģ��ĵ���д�����£�
�����õ�ģ������- �Զ��������- �������ź�
������������ڵ��źţ�.ina(ina1)
����д����ã��źŵ�˳����Ե���
*/
       adder myadder1 (.ina(a),.inb(b),.outa(outa1));
       // ����adder ģ�飬�Զ�������Ϊmyadder1
       adder myadder2 (.ina(c),.inb(d),.outa(outa2));
       // ����adder ģ�飬�Զ�������Ϊmyadder2
endmodule
       //adder ��ģ��
module adder(ina,inb,outa );// ģ��ӿ�
       input [5:0] ina; // ina-�����ź�
       input [5:0] inb; // inb-�����ź�
       output [6:0] outa; // outa-�����ź�
       assign outa = ina + inb; // ���
      // ģ�����
endmodule
