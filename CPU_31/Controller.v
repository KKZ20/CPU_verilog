`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/28 15:01:07
// Design Name: 
// Module Name: Controller
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


module operation(
    input clk,
    input zero,
    input [31:0] code,
    
    output PC_CLK,    
    output IM_R,
    output RF_CLK,     
    output M1,       
    output M2,        
    output M3,        
    output M4,        
    output M5,        
    output M6,       
    output M7,       
    output M8,      
    output M9,      
    output [3:0] ALUC,
    output RF_W,        
    output DM_w,   
    output DM_r,     
    output EXT16
    );
    parameter ADD   = 0;
    parameter ADDU  = 1;
    parameter SUB   = 2;
    parameter SUBU  = 3;
    parameter AND   = 4;
    parameter OR    = 5;
    parameter XOR   = 6;
    parameter NOR   = 7;
    parameter SLT   = 8;
    parameter SLTU  = 9;
    parameter SLL   = 10;
    parameter SRL   = 11;
    parameter SRA   = 12;
    parameter SLLV  = 13;
    parameter SRLV  = 14;
    parameter SRAV  = 15;
    parameter JR    = 16;
    parameter ADDI  = 17;
    parameter ADDIU = 18;
    parameter ANDI  = 19;
    parameter ORI   = 20;
    parameter XORI  = 21;
    parameter LW    = 22;
    parameter SW    = 23;
    parameter BEQ   = 24;
    parameter BNE   = 25;
    parameter SLTI  = 26;
    parameter SLTIU = 27;
    parameter LUI   = 28;
    parameter J     = 29;
    parameter JAL   = 30;

    assign PC_CLK = clk;
    assign IM_R = 1;

    assign M1 = ~(code[JR] | code[J] | code[JAL]);
    assign M2 = (code[BEQ] & zero) | (code[BNE] & ~zero);
    assign M3 = code[JR];
    assign M4 = code[SLLV] | code[SRLV] | code[SRAV];
    assign M5 = code[ADDI] | code[ADDIU] | code[ANDI] | code[ORI] | code[XORI] | code[LW] | code[SW] | code[SLTI] | code[SLTIU] | code[LUI];
    assign M6 = code[JAL];
    assign M7 = code[LW];
    assign M8 = ~(code[SLL] | code[SRL] | code[SRA] | code[SLLV] | code[SRLV] | code[SRAV]);
    assign M9 = code[ADDI] | code[ADDIU] | code[ANDI] | code[ORI] | code[XORI] | code[LW] | code[SW] | code[SLTI] | code[SLTIU] | code[LUI];

    assign ALUC[0] = code[SUB] | code[SUBU] | code[OR] | code[NOR] | code[SLT] | code[SRL] | code[SRLV] | code[ORI] | code[BEQ] | code[BNE] | code[SLTI];
    assign ALUC[1] = code[ADD] | code[SUB] | code[XOR] | code[NOR] | code[SLT] | code[SLTU] | code[SLL] | code[SLLV] | code[ADDI] | code[XORI] | code[LW] | code[SW] | code[BEQ] | code[BNE] | code[SLTI] | code[SLTIU];
    assign ALUC[2] = code[AND] | code[OR] | code[XOR] | code[NOR] | code[SLL] | code[SRL] | code[SRA] | code[SLLV] | code[SRLV] | code[SRAV] | code[ANDI] | code[ORI] | code[XORI];
    assign ALUC[3] = code[SLT] | code[SLTU] | code[SLL] | code[SRL] | code[SRA] | code[SLLV] | code[SRLV] | code[SRAV] | code[SLTI] | code[SLTIU] | code[LUI];

    assign RF_W = ~(code[JR] | code[SW] | code[BEQ] | code[BNE] | code[J]);
    assign RF_CLK = ~clk;
    assign DM_w = code[SW];
    assign DM_r = code[LW];
    //assign DM_cs = code[LW] | code[SW];
    assign EXT16 = ~(code[ANDI] | code[ORI] | code[XORI]);
    

endmodule
