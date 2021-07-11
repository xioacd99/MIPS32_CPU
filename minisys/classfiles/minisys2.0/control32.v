`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module control32(
    Opcode,
    Jrn,
    Function_opcode,
    Alu_resultHigh,
    RegDST,
    ALUSrc,
    MemorIOtoReg,
    RegWrite,
    MemRead,
    MemWrite,
    IORead,
    IOWrite,
    Branch,
    nBranch,
    Jmp,
    Jal,
    I_format,
    Sftmd,
    ALUOp
);
    input[5:0]   Opcode;                // ����ȡָ��Ԫ instruction[31..26]
    input[21:0] Alu_resultHigh;               // ����ִ�е�Ԫ Alu_resulthigh[31..10]
    input[5:0]   Function_opcode;       // ����ȡָ��Ԫ r- ���� instructions[5..0]
    output       Jrn;         	       // Ϊ 1 ������ǰָ���� jr
    output       RegDST;               // Ϊ 1 ����Ŀ�ļĴ����� rd������Ŀ�ļĴ����� rt
    output       ALUSrc;               // Ϊ 1 �����ڶ�������������������beq��bne ���⣩
    output       MemorIOtoReg;         // Ϊ 1 ������Ҫ�Ӵ洢���� I/O �����ݵ��Ĵ���
    output       RegWrite;   	      //  Ϊ 1 ������ָ����Ҫд�Ĵ���
    output       MemRead;             //  Ϊ 1 �����Ǵ洢����
    output       MemWrite;   	      //  Ϊ 1 ������ָ����Ҫд�洢��
    output       IORead;              // Ϊ 1 ������ I/O ��
    output       IOWrite;             // // Ϊ 1 ������ I/O д
    output       Branch;    	      //  Ϊ 1 ������ Beq ָ��
    output       nBranch;   	      //  Ϊ 1 ������ Bne ָ��
    output       Jmp;        	      //  Ϊ 1 ������ J ָ��
    output       Jal;        	      //  Ϊ 1 ������ Jal ָ��
    output       I_format;  	      //  Ϊ 1 ������ָ���ǳ� beq��bne��LW��SW ֮������� I- ����ָ��
    output       Sftmd;     	      //  Ϊ 1 ��������λָ��
    output[1:0]  ALUOp;	              //  �� R- ���ͻ� I_format = 1 ʱλ 1 Ϊ 1, beq��bneָ����λ 0 Ϊ 1
   
    // Ϊ 1 �ֱ��ʾ����һ��ָ��
    wire Jmp, I_format, Jal,Branch, nBranch;
    wire R_format, Lw, Sw;
    
   
    assign R_format = (Opcode == 6'b000000)? 1'b1 : 1'b0;    	//--00h 
    assign RegDST = R_format;                                   //˵��Ŀ����rd��������rt

    assign I_format = (Opcode[5:3] == 3'b001)? 1'b1: 1'b0;
    assign Lw = (Opcode == 6'b100011)? 1'b1 : 1'b0;
    assign Jal = (Opcode == 6'b000011)? 1'b1 : 1'b0;
    assign Jrn = (R_format & Function_opcode == 6'b001000)? 1'b1 : 1'b0;
    assign RegWrite = (I_format || (R_format & ~Jrn) || Lw || Jal)? 1'b1 : 1'b0;
    
    assign Sw = (Opcode == 6'b101011)? 1'b1 : 1'b0;
    assign ALUSrc = I_format || Lw || Sw;
    assign Branch = (Opcode == 6'b000100)? 1'b1 : 1'b0;
    assign nBranch = (Opcode == 6'b000101)? 1'b1 : 1'b0;
    assign Jmp = (Opcode == 6'b000010)? 1'b1 : 1'b0;
    
    assign MemWrite = ((Sw == 1) && (Alu_resultHigh != 22'b1111111111111111111111))? 1'b1: 1'b0;
    assign MemRead = ((Lw == 1) && (Alu_resultHigh != 22'b1111111111111111111111))? 1'b1 : 1'b0;
    assign IORead = ((Lw == 1) && (Alu_resultHigh == 22'b1111111111111111111111))? 1'b1 : 1'b0;
    assign IOWrite = ((Sw == 1) && (Alu_resultHigh == 22'b1111111111111111111111))? 1'b1 : 1'b0;
    assign MemorIOtoReg = Lw;
    assign Sftmd = (R_format & (Function_opcode == 6'b000000 || Function_opcode == 6'b000010 || 
        Function_opcode == 6'b000100 || Function_opcode == 6'b000110 || Function_opcode == 6'b000011 || 
        Function_opcode == 6'b000111))? 1'b1 : 1'b0; 
    assign ALUOp = {(R_format || I_format), (Branch || nBranch)};

endmodule
