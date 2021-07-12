`timescale 1ns / 1ps

module control32_sim();
        // input
        reg[5:0]   Opcode = 6'b000000;                // ����ȡָ��Ԫinstruction[31..26]
        reg[5:0]   Function_opcode  = 6'b100000;      // r-form instructions[5..0]  ADD
        // output
        wire       Jrn;
        wire       RegDST;
        wire       ALUSrc;                           // �����ڶ����������ǼĴ�������������
        wire       MemtoReg;
        wire       RegWrite;
        wire       MemWrite;
        wire       Branch;
        wire       nBranch;
        wire       Jmp;
        wire       Jal;
        wire       I_format;
        wire       Sftmd;
        wire[1:0]  ALUOp;
        
    control32 Uctrl(
        Opcode,
        Function_opcode,
        Jrn,
        RegDST,
        ALUSrc,
        MemtoReg,
        RegWrite,
        MemWrite,
        Branch,
        nBranch,
        Jmp,
        Jal,
        I_format,
        Sftmd,
        ALUOp
    );
    initial begin
        #200    Function_opcode  = 6'b001000;               // JR
        #200    Opcode = 6'b001000;                         //  ADDI
        #200    Opcode = 6'b100011;                         //  LW
        #200    Opcode = 6'b101011;                         //  SW
        #250    Opcode = 6'b000100;                         //  BEQ
        #200    Opcode = 6'b000101;                         //  BNE
        #250    Opcode = 6'b000010;                         //  JMP
        #200    Opcode = 6'b000011;                         //  JAL
        #250                                                //  SRL
            begin 
                Opcode = 6'b000000; 
                Function_opcode  = 6'b000010; 
            end;
    end         
endmodule
