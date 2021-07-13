`timescale 1ns / 1ps

module Ifetc32(
    Instruction, 
    PC_plus_4_out, 
    Add_result, 
    Read_data_1,
    Branch,
    nBranch, 
    Jmp, 
    Jal, 
    Jrn, 
    Zero, 
    clock, 
    reset, 
    opcplus4
);
    output[31:0] Instruction;			// ���ָ�����ģ��
    output[31:0] PC_plus_4_out;         // (pc + 4) ��ִ�е�Ԫ
    input[31:0]  Add_result;            // ����ִ�е�Ԫ,�������ת��ַ
    input[31:0]  Read_data_1;           // �������뵥Ԫ��jrָ���õĵ�ַ
    input        Branch;                // ���Կ��Ƶ�Ԫ
    input        nBranch;               // ���Կ��Ƶ�Ԫ
    input        Jmp;                   // ���Կ��Ƶ�Ԫ
    input        Jal;                   // ���Կ��Ƶ�Ԫ
    input        Jrn;                   // ���Կ��Ƶ�Ԫ
    input        Zero;                  // ����ִ�е�Ԫ
    input        clock,reset;           // ʱ���븴λ
    output[31:0] opcplus4;              // JAL ָ��ר�õ� PC + 4
    
    
    wire[31:0]   PC_plus_4;             // PC + 4
    reg[31:0]	  PC;                   
    reg[31:0]    next_PC;               // ����ָ���PC����һ���� PC + 4)
    reg[31:0]    opcplus4;
    
   // ����64KB ROM��������ʵ��ֻ�� 64KB ROM
    prgrom instmem(
        .clka(clock),                   // input wire clka
        .addra(PC[15:2]),               // input wire [13:0] addra
        .douta(Instruction)             // output wire [31:0] douta
    );
    
    assign PC_plus_4[31:2] = PC[31:2] + 1;
    assign PC_plus_4[1:0] = 2'b00;
    assign PC_plus_4_out = PC_plus_4;  

    // beq $n ,$m if $n = $m branch   bne if $n != $m branch jr
    always @* begin  
        if (Jrn == 1)
            begin
                next_PC[1:0] = 2'b00;
                next_PC[31:2] = Read_data_1[29:0];
            end
        else if ((Branch == 1 && Zero == 1)||(nBranch == 1 && Zero == 0))
            begin
                next_PC[1:0] = 2'b00;
                next_PC[31:2] = Add_result[29:0];
            end
        else
            begin
                next_PC = PC_plus_4;
            end
    end
    
    // J��Jal��reset
    always @(negedge clock) 
        begin 
            if (reset == 1) 
                begin
                    PC <= 32'h00000000;
                end 
            else if (Jmp == 1)
                begin
                    PC[27:2] = Instruction[25:0];
                    PC[31:28] = 4'b0000;
                    PC[1:0] = 2'b00;
                end
            else if (Jal == 1)
                begin
                    opcplus4[29:0] = PC_plus_4[31:2];
                    opcplus4[31:30] = 2'b00;
                    PC[27:2] = Instruction[25:0];
                    PC[31:28] = 4'b0000;
                    PC[1:0] = 2'b00;
                end
            else
                begin
                    PC = next_PC;
                end
        end
endmodule
