`timescale 1ns / 1ps

module ControlIO32_sim();
    // input
    reg[5:0]   Opcode = 6'b000000;                          // 来自取指单元instruction[31..26]
    reg[5:0]   Function_opcode  = 6'b100000;                // r-form instructions[5..0]  ADD
    reg[21:0]  Alu_resultHigh = 22'b11000000110100100011;   // 读操作需要从端口或存储器读数据到寄存器LW和SW的真正地址
                                                            // 是Alu_Result,这里的Alu_resultHigh来自执行单元Alu_Result[31..10]，这个信号要进入到control32.v的模块中
    // output
    wire       Jrn;
    wire       RegDST;
    wire       ALUSrc;                                      // 决定第二个操作数是寄存器还是立即数
    wire       MemorIOtoReg;
    wire       RegWrite;
    wire       MemRead;
    wire       MemWrite;
    wire       IORead;
    wire       IOWrite;
    wire       Branch;
    wire       nBranch;
    wire       Jmp;
    wire       Jal;
    wire       I_format;
    wire       Sftmd;
    wire[1:0]  ALUOp;
    
    control32 UctrlIO(
        .Opcode(Opcode),
        .Function_opcode(Function_opcode),
        .Alu_resultHigh(Alu_resultHigh),
        .Jrn(Jrn),
        .RegDST(RegDST),
        .ALUSrc(ALUSrc),
        .MemorIOtoReg(MemorIOtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .IORead(IORead),
        .IOWrite(IOWrite),
        .Branch(Branch),
        .nBranch(nBranch),
        .Jmp(Jmp),
        .Jal(Jal),
        .I_format(I_format),
        .Sftmd(Sftmd),
        .ALUOp(ALUOp)
);
            
    initial begin
        #200    Function_opcode  = 6'b001000;               // JR
        #200    Opcode = 6'b001000;                         //  ADDI
        #200    Opcode = 6'b100011;                         //  LW
        #200    Opcode = 6'b101011;                         //  SW
        #200                                                //  LW  IO
            begin 
                Opcode = 6'b100011; 
                Alu_resultHigh = 22'b1111111111111111111111; 
            end;  
        #200                                                //  SW  io
            begin 
                Opcode = 6'b101011; 
                Alu_resultHigh = 22'b1111111111111111111111; 
            end;  
        #250    Opcode = 6'b000100;                         //  BEQ
        #200    Opcode = 6'b000101;                         //  BNE
        #250    Opcode = 6'b000010;                         //  JMP
        #200    Opcode = 6'b000011;                         //  JAL
        #250                                                //  SRL
            begin 
                Opcode = 6'b000000; 
                Function_opcode  = 6'b000010; 
            end
    end         
endmodule
