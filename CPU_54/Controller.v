`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:48:40
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
    input clk,          //系统时钟
    input zero,         //alu是否为零
    input [53:0] code,
    input [31:0] instr,
    input [31:0] Rs,
    
    output PC_CLK,      //PC寄存器时钟    
    output M1,       
    output M2,        
    output M3,        
    output M4,        
    output M5,        
    output M6,       
    output M7,       
    output M8,      
    output M9, 
    output M10,     
    output [3:0] ALUC,
    output RF_W,        
    output DM_w,   
    output DM_r,     
    output EXT16,
    output mfc0,
    output mtc0,
    output exception,
    output HI_ena,
    output LO_ena,
    output [2:0] M_Rd,
    output [1:0] select, //DMEM的选择信号 
    output [4:0] cause,
    output CLZ_ENA
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
    parameter CLZ   = 31;
    parameter DIVU  = 32;
    parameter ERET  = 33;
    parameter JALR  = 34;
    parameter LB    = 35;
    parameter LBU   = 36;
    parameter LHU   = 37;
    parameter SB    = 38;
    parameter SH    = 39;
    parameter LH    = 40;
    parameter MFC0  = 41;
    parameter MFHI  = 42;
    parameter MFLO  = 43;
    parameter MTC0  = 44;
    parameter MTHI  = 45;
    parameter MTLO  = 46;
    parameter MULT  = 47;
    parameter MULTU = 48;
    parameter SYSCALL = 49;
    parameter TEQ   = 50;
    parameter BGEZ  = 51;
    parameter BREAK = 52;
    parameter DIV   = 53;

    reg [4:0] cp0_cause;
    reg [1:0] temp_select;
    reg [2:0] select_rd;

    assign PC_CLK = clk;

    assign M1 = ~(code[JR] | code[J] | code[JAL] | code[JALR]);
    assign M2 = (code[BEQ] & zero) | (code[BNE] & ~zero) | (code[BGEZ] & (Rs[31]==0));
    assign M3 = code[JR] | code [JALR];
    assign M4 = code[SLLV] | code[SRLV] | code[SRAV];
    assign M5 = code[ADDI] | code[ADDIU] | code[ANDI] | code[ORI] | code[XORI] | code[LW] | code[SW] | code[SLTI] | code[SLTIU] | code[LUI] | code[LB] | code[LBU] | code[LH] | code[LHU] | code[MFC0];
    assign M6 = code[JAL] | code[JALR];
    assign M7 = code[LW] | code[LH] | code[LHU] | code[LB] | code[LBU];
    assign M8 = ~(code[SLL] | code[SRL] | code[SRA] | code[SLLV] | code[SRLV] | code[SRAV]);
    assign M9 = code[ADDI] | code[ADDIU] | code[ANDI] | code[ORI] | code[XORI] | code[LW] | code[SW] | code[SLTI] | code[SLTIU] | code[LUI] | code[LB] | code[LBU] | code[LH] | code[LHU] | code[SB] | code[SH];
    assign M10 = code[ERET] |exception;
    assign M_Rd = select_rd;

    assign ALUC[0] = code[SUB] | code[SUBU] | code[OR] | code[NOR] | code[SLT] | code[SRL] | code[SRLV] | code[ORI] | code[BEQ] | code[BNE] | code[SLTI] | code[TEQ];
    assign ALUC[1] = code[ADD] | code[SUB] | code[XOR] | code[NOR] | code[SLT] | code[SLTU] | code[SLL] | code[SLLV] | code[ADDI] | code[XORI] | code[LW] | code[SW] | code[BEQ] | code[BNE] | code[SLTI] | code[SLTIU];
    assign ALUC[2] = code[AND] | code[OR] | code[XOR] | code[NOR] | code[SLL] | code[SRL] | code[SRA] | code[SLLV] | code[SRLV] | code[SRAV] | code[ANDI] | code[ORI] | code[XORI];
    assign ALUC[3] = code[SLT] | code[SLTU] | code[SLL] | code[SRL] | code[SRA] | code[SLLV] | code[SRLV] | code[SRAV] | code[SLTI] | code[SLTIU] | code[LUI];

    assign RF_W = ~(code[JR] | code[SW] | code[BEQ] | code[BNE] | code[J] | code[DIVU] | code[ERET] | code[SB] | code[SH] | code[MTC0] | code[MTHI] | code[MTLO] | code[MULT] | code[MULTU] | code[SYSCALL] | code[TEQ] | code[BGEZ] | code[BREAK] | code[DIV]);
    assign DM_w = code[SW] | code[SH] | code[SB];
    assign DM_r = code[LW] | code[LH] | code[LHU] | code[LB] | code[LBU];
    //assign DM_cs = code[LW] | code[SW];
    assign EXT16 = ~(code[ANDI] | code[ORI] | code[XORI]);

    assign select = temp_select;
    assign mfc0 = (instr[25:21]==5'b00000) ? 1'b1:1'b0;
    assign mtc0 = (instr[25:21]==5'b00100) ? 1'b1:1'b0;
    assign exception = code[SYSCALL] | (code[TEQ] &zero) | code[BREAK];
    assign cause = cp0_cause;

    assign HI_ena = code[DIV] | code[DIVU] | code[MULT] | code[MULTU] | code[MTHI];
    assign LO_ena = code[DIV] | code[DIVU] | code[MULT] | code[MULTU] | code[MTLO];

    assign CLZ_ENA = code[CLZ];

    always @ (*)
    begin
        if (code[SB])
            temp_select = 2'b01;
        else if (code[SH])
            temp_select = 2'b10;
        else if (code[SW])
            temp_select = 2'b11;
    end

    always @ (*) 
    begin
        if (code[SYSCALL])
            cp0_cause = 5'b01000;
        else if (code[TEQ])
            cp0_cause = 5'b01101;
        else if (code[BREAK])
            cp0_cause = 5'b01001;
        else
            cp0_cause = 5'b00000;
    end

    always @ (*)
    begin
        if (M7)
            select_rd = 3'b001;
        else if (code[CLZ])
            select_rd = 3'b010;
        else if (code[MFHI])
            select_rd = 3'b011;
        else if (code[MFLO])
            select_rd = 3'b100;
        else if (code[MFC0] & mfc0)
            select_rd = 3'b101;
        else if (code[JALR])
            select_rd = 3'b110;
        else
            select_rd = 3'b000;
    end

endmodule
