`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Idecode32(
    read_data_1,
    read_data_2,
    Instruction,
    read_data,
    ALU_result,
    Jal,
    RegWrite,
    MemorIOtoReg,
    RegDst,
    Sign_extend,
    clock,
    reset,
    opcplus4
 );
    output[31:0] read_data_1;               // ����ĵ�һ������
    output[31:0] read_data_2;               // ����ĵڶ�������
    input[31:0]  Instruction;               // ȡָ��Ԫ����ָ��
    input[31:0]  read_data;   				//  ��DATA RAM or I/O portȡ��������
    input[31:0]  ALU_result;   				// ��ִ�е�Ԫ��������Ľ������Ҫ��չ��������32λ
    input        Jal;                       //  ���Կ��Ƶ�Ԫ��˵����JALָ�� 
    input        RegWrite;                  // ���Կ��Ƶ�Ԫ
    input        MemorIOtoReg;              // ���Կ��Ƶ�Ԫ
    input        RegDst;                    //  ���Կ��Ƶ�Ԫ
    output[31:0] Sign_extend;               // ��չ���32λ������
    input		 clock,reset;                // ʱ�Ӻ͸�λ
    input[31:0]  opcplus4;                 // ����ȡָ��Ԫ��JAL����
    
    wire[31:0] read_data_1;
    wire[31:0] read_data_2;
    reg[31:0] register[0:31];			   //�Ĵ����鹲32��32λ�Ĵ���
    reg[4:0] write_register_address;        // Ҫд�ļĴ����ĺ�
    reg[31:0] write_data;                   // Ҫд�Ĵ��������ݷ�����

    wire[4:0] read_register_1_address;    // Ҫ���ĵ�һ���Ĵ����ĺţ�rs��
    wire[4:0] read_register_2_address;     // Ҫ���ĵڶ����Ĵ����ĺţ�rt��
    wire[4:0] write_register_address_1;   // r-formָ��Ҫд�ļĴ����ĺţ�rd��
    wire[4:0] write_register_address_0;    // i-formָ��Ҫд�ļĴ����ĺ�(rt)
    wire[15:0] Instruction_immediate_value;  // ָ���е�������
    wire[5:0] opcode;                       // ָ����
    
    assign opcode = Instruction[31:26];						//OP
    assign read_register_1_address = Instruction[25:21];   	//rs
    assign read_register_2_address = Instruction[20:16];    //rt
    assign write_register_address_1 = Instruction[15:11];	//rd(r-form)
    assign write_register_address_0 = Instruction[20:16];	//rt(i-form)
    assign Instruction_immediate_value = Instruction[15:0];	//data,rladr(i-form)
    
    wire sign;                      // ȡ����λ��ֵ
    assign sign = Instruction_immediate_value[15];
    assign Sign_extend[31:0] = ((opcode==6'b001100)     // andi
                      ||(opcode==6'b001101)             // ori
                      ||(opcode==6'b001110)             // xori
                      ||(opcode==6'b001011))            // sltiu
                      ? {16'h0000,Instruction_immediate_value[15:0]}  // ������0��չ
                      :{sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,Instruction_immediate_value[15:0]};  //������������չ
    
    assign read_data_1 = register[read_register_1_address];
    assign read_data_2 = register[read_register_2_address];
    
    always @* begin                                            //�������ָ����ָͬ���µ�Ŀ��Ĵ���
        if((RegDst==1) && (Jal==0)) //r-form jal (pc+1 > sp[$Rlast])
            write_register_address = write_register_address_1; //RD(15-11)  R-formָ��
        else if((RegDst==0) && (Jal==1))
            write_register_address = 5'b11111;                 //JAL ָ����Ҫ���¸�ָ��ĵ�ַ�����һ���Ĵ���
        else  write_register_address  = write_register_address_0;//i-form rt(20-16)
    end
    
    always @* begin  //������̻�������ʵ�ֽṹͼ�����µĶ�·ѡ���� ,lw $5,$3(100)
        if((MemorIOtoReg==0) && (Jal== 0)) begin               //����LW and IO, Ҳ����JALָ��
            write_data = ALU_result[31:0];
        end else if((MemorIOtoReg==0) && (Jal== 1)) begin      //����LW��������jal,�¸���ַ��$15
            write_data = opcplus4;
        end else begin
            write_data = read_data; 		                   //��LWָ��
        end
    end
    
    integer i;
    always @(posedge clock) begin       // ������дĿ��Ĵ���
        if(reset==1) begin              // ��ʼ���Ĵ�����
            for(i=0;i<32;i=i+1) register[i] <= i;
        end else if(RegWrite==1) begin  // ע��Ĵ���0�����0
            case(write_register_address[4:0])
                5'd0:register[0] <= 32'd0;
                5'd1:register[1] <= write_data;
                5'd2:register[2] <= write_data;
                5'd3:register[3] <= write_data;
                5'd4:register[4] <= write_data;
                5'd5:register[5] <= write_data;
                5'd6:register[6] <= write_data;
                5'd7:register[7] <= write_data;
                5'd8:register[8] <= write_data;
                5'd9:register[9] <= write_data;
                5'd10:register[10] <= write_data;
                5'd11:register[11] <= write_data;
                5'd12:register[12] <= write_data;
                5'd13:register[13] <= write_data;
                5'd14:register[14] <= write_data;
                5'd15:register[15] <= write_data;
                5'd16:register[16] <= write_data;
                5'd17:register[17] <= write_data;
                5'd18:register[18] <= write_data;
                5'd19:register[19] <= write_data;
                5'd20:register[20] <= write_data;
                5'd21:register[21] <= write_data;
                5'd22:register[22] <= write_data;
                5'd23:register[23] <= write_data;
                5'd24:register[24] <= write_data;
                5'd25:register[25] <= write_data;
                5'd26:register[26] <= write_data;
                5'd27:register[27] <= write_data;
                5'd28:register[28] <= write_data;
                5'd29:register[29] <= write_data;
                5'd30:register[30] <= write_data;
                5'd31:register[31] <= write_data;
                default:register[0] <= 32'd0;
            endcase
        end
    end
endmodule
