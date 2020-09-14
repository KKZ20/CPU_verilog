`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:45:42
// Design Name: 
// Module Name: ALU
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


module addu(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    
    assign r=a+b;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[2]=r[32];
    assign sym[1]=r[31];
endmodule

module add(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [32:0] r,
    output [3:0] sym
    );
    assign r=a+b;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[1]=(r<0)?1:0;
    assign sym[0]=r[32];
endmodule

module subu(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    assign r=a-b;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[2]=r[32];
    assign sym[1]=r[31];
endmodule

module sub(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [32:0] r,
    output [3:0] sym
    );
    assign r=a-b;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[1]=(r<0)?1:0;
    assign sym[0]=r[32];
endmodule

module and_r(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    assign r=a&b;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[1]=r[31];
endmodule

module or_r(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    assign r=a|b;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[1]=r[31];
endmodule

module xor_r(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    assign r=a^b;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[1]=r[31];
endmodule

module nor_r(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    assign r=~(a|b);
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[1]=r[31];
endmodule

module lui(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    assign r={b[15:0],16'b0};
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[1]=r[31];    
endmodule

module slt(
    input signed [31:0] a,
    input signed [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    //wire [31:0] temp;
    assign r=(a<b)?33'b000000000000000000000000000000001:0;
    //assign temp=a-b;
    assign sym[3]=(a==b)?1:0;
    assign sym[1]=(a<b)?1:0;
endmodule

module sltu(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym
    );
    assign r=(a<b)?33'b000000000000000000000000000000001:0;
    assign sym[3]=(a==b)?1:0;
    assign sym[2]=(a<b)?1:0;
    assign sym[1]=r[31];
endmodule

module sra(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [32:0] r,
    output [3:0] sym   
    );
    assign r=b>>>a;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[2]=r[32];
    assign sym[1]=r[31];    
endmodule

module sll_r(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym    
    );
    assign r=b<<a;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[2]=r[32];
    assign sym[1]=r[31]; 
endmodule

module srl(
    input [31:0] a,
    input [31:0] b,
    output [32:0] r,
    output [3:0] sym    
    );
    assign r=b>>a;
    assign sym[3]=(r[31:0]==32'b0)?1:0;
    assign sym[2]=r[32];
    assign sym[1]=r[31];
endmodule

module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] aluc,
    output reg [31:0] r,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow
    );
    parameter M=32;
    parameter N=3;
    wire [M:0] r_addu;
    wire [M:0] r_add;
    wire [M:0] r_subu;
    wire [M:0] r_sub;
    wire [M:0] r_and;
    wire [M:0] r_or;
    wire [M:0] r_xor;
    wire [M:0] r_nor;
    wire [M:0] r_lui;
    wire [M:0] r_slt;
    wire [M:0] r_sltu;
    wire [M:0] r_sra;
    wire [M:0] r_sll_r;
    wire [M:0] r_srl;
    
    wire [N:0] sym_addu;
    wire [N:0] sym_add;
    wire [N:0] sym_subu;
    wire [N:0] sym_sub;
    wire [N:0] sym_and;
    wire [N:0] sym_or;
    wire [N:0] sym_xor;
    wire [N:0] sym_nor;
    wire [N:0] sym_lui;
    wire [N:0] sym_slt;
    wire [N:0] sym_sltu;
    wire [N:0] sym_sra;
    wire [N:0] sym_sll_r;
    wire [N:0] sym_srl;
    
    addu op_1 (a,b,r_addu,sym_addu);
    add op_2 (a,b,r_add,sym_add);
    subu op_3 (a,b,r_subu,sym_subu);
    sub op_4 (a,b,r_sub,sym_sub);
    and_r op_5 (a,b,r_and,sym_and);
    or_r op_6 (a,b,r_or,sym_or);
    xor_r op_7 (a,b,r_xor,sym_xor);
    nor_r op_8 (a,b,r_nor,sym_nor);
    lui op_9 (a,b,r_lui,sym_lui);
    slt op_10 (a,b,r_slt,sym_slt);
    sltu op_11 (a,b,r_sltu,sym_sltu);
    sra op_12 (a,b,r_sra,sym_sra);
    sll_r op_13 (a,b,r_sll_r,sym_sll_r);
    srl op_14 (a,b,r_srl,sym_srl);
    
     always@(*)
     begin
        zero=0;
        carry=0;
        negative =0;
        overflow =0;
        case(aluc)
            4'b0000:
            begin
                r=r_addu[31:0];
                zero=sym_addu[3];
                carry=sym_addu[2];
                negative=sym_addu[1];
            end
            4'b0010:
            begin
                r=r_add[31:0];
                zero=sym_add[3];
                negative=sym_add[1];
                overflow=sym_add[0];
            end 
            4'b0001:
            begin
                r=r_subu[31:0];
                zero=sym_subu[3];
                carry=sym_subu[2];
                negative=sym_subu[1];            
                //overflow=sym_subu[0];            
            end
            4'b0011:
            begin
                r=r_sub[31:0];
                zero=sym_sub[3];
                //carry=sym_sub[2];
                negative=sym_sub[1];            
                overflow=sym_sub[0];             
            end
            4'b0100:
            begin
                r=r_and[31:0];
                zero=sym_and[3];
                //carry=sym_and[2];
                negative=sym_and[1];            
                //overflow=sym_and[0];                
            end
            4'b0101:
            begin
                r=r_or[31:0];
                zero=sym_or[3];
                //carry=sym_or[2];
                negative=sym_or[1];            
                //overflow=sym_or[0];            
            end
            4'b0110:
            begin
                r=r_xor[31:0];
                zero=sym_xor[3];
                //carry=sym_xor[2];
                negative=sym_xor[1];            
                //overflow=sym_xor[0];             
            end
            4'b0111:
            begin
                r=r_nor[31:0];
                zero=sym_nor[3];
                //carry=sym_nor[2];
                negative=sym_nor[1];            
                //overflow=sym_nor[0];             
            end            
            4'b1000,4'b1001:
            begin
                r=r_lui[31:0];
                zero=sym_lui[3];
                //carry=sym_lui[2];
                negative=sym_lui[1];            
                //overflow=sym_lui[0];             
            end
            4'b1011:
            begin
                r=r_slt[31:0];
                zero=sym_slt[3];
                //carry=sym_slt[2];
                negative=sym_slt[1];            
                //overflow=sym_slt[0];             
            end                                                                                              
            4'b1010:
            begin
                r=r_sltu[31:0];
                zero=sym_sltu[3];
                carry=sym_sltu[2];
                negative=sym_sltu[1];            
                //overflow=sym_sltu[0];             
            end            
            4'b1100:
            begin
                r=r_sra[31:0];
                zero=sym_sra[3];
                carry=sym_sra[2];
                negative=sym_sra[1];            
                //overflow=sym_sra[0];              
            end            
            4'b1110,4'b1111:
            begin
                r=r_sll_r[31:0];
                zero=sym_sll_r[3];
                carry=sym_sll_r[2];
                negative=sym_sll_r[1];            
                //overflow=sym_sll_r[0];              
            end            
            4'b1101:
            begin
                r=r_srl[31:0];
                zero=sym_srl[3];
                carry=sym_srl[2];
                negative=sym_srl[1];            
                //overflow=sym_srl[0];              
            end            
        endcase
     end
endmodule
