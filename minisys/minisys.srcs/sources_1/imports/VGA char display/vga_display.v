`timescale 1ns / 1ps

module vga_char_display(  
    input clk,  
    input rst,  
    input [31:0] CPU_outcome,
    output reg [3:0] r,  
    output reg [3:0] g,  
    output reg [3:0] b,  
    output hs,  
    output vs  
);   
    
    reg [9:0] hcount, vcount;  
    wire [7:0] p[55:0];   
    
    reg [3:0] input_data1;
    reg [3:0] input_data2;
    reg [3:0] input_data3;
    reg [3:0] input_data4;
    reg [3:0] input_data5;
    reg [3:0] input_data6;
    reg [3:0] input_data7;
    reg [3:0] input_data8;

    // 640*480 60HZ
    parameter hsw = 96;
    parameter hbp = 48;
    parameter haw = 640;
    parameter hfp = 16;
    
    parameter vsw = 2;
    parameter vbp = 33;
    parameter vaw = 480;
    parameter vfp = 10;
    
    parameter left = hsw + hbp;
    parameter right = hsw + hbp + haw;
    parameter hframe = hsw + hbp + haw + hfp;
    
    parameter top = vsw + vbp;
    parameter bottom = vsw + vbp + vaw;
    parameter vframe =  vsw + vbp + vaw + vfp;
    
    
    parameter show_h = 0 + left;
    parameter show_v = 0 +  top;
    parameter show_width = 56;
    parameter show_height = 8;
    
    
    // assign the input_data according to CPU_outcome
    always @(posedge clk)
    begin
        input_data1 <= CPU_outcome[31:28];
        input_data2 <= CPU_outcome[27:24];
        input_data3 <= CPU_outcome[23:20];
        input_data4 <= CPU_outcome[19:16];
        input_data5 <= CPU_outcome[15:12];
        input_data6 <= CPU_outcome[11:8];
        input_data7 <= CPU_outcome[7:4];
        input_data8 <= CPU_outcome[3:0];
    end

    RAM_set u_ram_1 (  
        .clk(clk),  
        .rst(rst),  
        .data(input_data1),  
        .col0(p[0]),  
        .col1(p[1]),  
        .col2(p[2]),  
        .col3(p[3]),  
        .col4(p[4]),  
        .col5(p[5]),  
        .col6(p[6])  
    );  
    RAM_set u_ram_2 (  
        .clk(clk),  
        .rst(rst),  
        .data(input_data2),  
        .col0(p[7]),  
        .col1(p[8]),  
        .col2(p[9]),  
        .col3(p[10]),  
        .col4(p[11]),  
        .col5(p[12]),  
        .col6(p[13])  
    ); 
    RAM_set u_ram_3 (  
        .clk(clk),  
        .rst(rst),  
        .data(input_data3),  
        .col0(p[14]),  
        .col1(p[15]),  
        .col2(p[16]),  
        .col3(p[17]),  
        .col4(p[18]),  
        .col5(p[19]),  
        .col6(p[20])  
    );
    RAM_set u_ram_4 (  
        .clk(clk),  
        .rst(rst),  
        .data(input_data4),  
        .col0(p[21]),  
        .col1(p[22]),  
        .col2(p[23]),  
        .col3(p[24]),  
        .col4(p[25]),  
        .col5(p[26]),  
        .col6(p[27])  
    ); 
    RAM_set u_ram_5 (  
        .clk(clk),  
        .rst(rst),  
        .data(input_data5),  
        .col0(p[28]),  
        .col1(p[29]),  
        .col2(p[30]),  
        .col3(p[31]),  
        .col4(p[32]),  
        .col5(p[33]),  
        .col6(p[34])  
    );  
    RAM_set u_ram_6 (  
        .clk(clk),  
        .rst(rst),  
        .data(input_data6),  
        .col0(p[35]),  
        .col1(p[36]),  
        .col2(p[37]),  
        .col3(p[38]),  
        .col4(p[39]),  
        .col5(p[40]),  
        .col6(p[41])  
    ); 
    RAM_set u_ram_7 (  
        .clk(clk),  
        .rst(rst),  
        .data(input_data7),  
        .col0(p[42]),  
        .col1(p[43]),  
        .col2(p[44]),  
        .col3(p[45]),  
        .col4(p[46]),  
        .col5(p[47]),  
        .col6(p[48])  
    );
    RAM_set u_ram_8 (  
        .clk(clk),  
        .rst(rst),  
        .data(input_data8),  
        .col0(p[49]),  
        .col1(p[50]),  
        .col2(p[51]),  
        .col3(p[52]),  
        .col4(p[53]),  
        .col5(p[54]),  
        .col6(p[55])  
    ); 
  
    assign hs = (hcount < hsw) ? 0 : 1;             
    always @ (posedge clk or posedge rst)
    begin  
        if (rst)  
            hcount <= 0;  
        else if (hcount == hframe-1)  
            hcount <= 0;  
        else  
            hcount <= hcount+1;  
    end  
 
    assign vs = (vcount < vsw) ? 0 : 1;             
    always @ (posedge clk or posedge rst)          
    begin  
        if (rst)  
            vcount <= 0;  
        else if (hcount == hframe-1) 
        begin       
            if (vcount == vframe-1)  
                vcount <= 0;  
            else  
                vcount <= vcount+1;  
        end  
        else  
            vcount <= vcount;  
    end  

    always @ (posedge clk or posedge rst)  
    begin  
        if (rst) 
            begin  
                r <= 0;  
                g <= 0;  
                b <= 0;  
            end  
        else if (vcount >= top && vcount <= bottom && hcount >= left && hcount <= right) 
            begin  
                if (vcount >= show_v && vcount <= show_v + show_height && hcount >= show_h && hcount <= show_h + show_width) 
                    begin  
                        if (p[hcount - left][vcount - top]) 
                            begin  
                                r <= 4'b1111;  
                                g <= 4'b1111;  
                                b <= 4'b1111;  
                            end  
                        else 
                            begin  
                                r <= 4'b0000;  
                                g <= 4'b0000;  
                                b <= 4'b0000;  
                            end  
                    end  
                else 
                    begin  
                        r <= 4'b0000;  
                        g <= 4'b0000;  
                        b <= 4'b0000;  
                    end  
        end  
    else 
        begin  
            r <= 4'b0000;  
            g <= 4'b0000;  
            b <= 4'b0000;  
        end  
    end  
endmodule  

