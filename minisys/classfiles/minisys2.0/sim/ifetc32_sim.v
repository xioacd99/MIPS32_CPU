`timescale 1ns / 1ps

module ifetc32_sim();
    // input
    reg[31:0]  Add_result = 32'h00000000;
    reg[31:0]  Read_data_1 = 32'h00000000;
    reg        Branch = 1'b0;
    reg        nBranch = 1'b0;
    reg        Jmp = 1'b0;
    reg        Jal = 1'b0;
    reg        Jrn = 1'b0;
    reg        Zero = 1'b0;
    reg        clock = 1'b0,reset = 1'b1;

    // output
    wire[31:0] Instruction;            // ���ָ��
    wire[31:0] PC_plus_4_out;
    wire[31:0] opcplus4;
        
    Ifetc32 Uifetch
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

    initial begin
        #300   reset = 1'b0;
        #600   Jal = 1;
        #200   
            begin 
                Jrn = 1;
                Jal = 0; 
                Read_data_1 = 32'h0000019c;
            end;
        #200   
            begin 
                Jrn = 0;
                Branch = 1'b1; 
                Zero = 1'b1; 
                Add_result = 32'h00000002;
            end;        
        #200   
            begin 
                Branch = 1'b0; 
                Zero = 1'b0; 
            end;        
    end
    always #50 clock = ~clock;            
endmodule
