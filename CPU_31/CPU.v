`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/28 15:22:32
// Design Name: 
// Module Name: CPU
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



module CPU(
    input clk,
    input rst,
    input [31:0] instr,
    input [31:0] rdata,
    output rena,
    output wena,
    output [31:0] pc,
    output [31:0] addr,
    output [31:0] wdata
    );

    //--------------------------------//
    wire [31:0] Pc;
    wire PC_CLK;
    wire IM_R;
    wire RF_CLK;
    wire [31:0] Npc;
    wire [31:0] Rs;
    wire [31:0] Rt;
    wire [31:0] Alu;

    wire [31:0] mux1;            
    wire [31:0] mux2;            
    wire [31:0] mux3;            
    wire [4:0]  mux4;            
    wire [4:0]  mux5;            
    wire [31:0] mux6;            
    wire [31:0] mux7;            
    wire [31:0] mux8;            
    wire [31:0] mux9; 

    wire [31:0] EXT5;            
    wire [31:0] EXT16;           
    wire [31:0] EXT18;           
    wire [31:0] ADD;             
    wire [31:0] ADD8;    
    wire [31:0] CONNECT;

    wire [31:0] code;

    wire dram_r;
    wire dram_w;
    wire rf_w;
    wire ext16_flag;

    wire M1;
    wire M2;
    wire M3;
    wire M4;
    wire M5;
    wire M6;
    wire M7;
    wire M8;
    wire M9;

    wire [3:0] aluc;
    wire zero;
    wire carry;
    wire negative;
    wire overflow;

    assign rena = dram_r;
    assign wena = dram_w;
    assign pc = Pc;
    assign addr = Alu;
    assign wdata = Rt;
    //--------------------------------//
 
    Instr_dec instr_decode(
        .instr_code(instr),
        .code(code)
    );
    operation control(
        .clk(clk),
        .zero(zero),
        .code(code),
    
        .PC_CLK(PC_CLK),    
        .IM_R(IM_R),
        .RF_CLK(RF_CLK),     
        .M1(M1),       
        .M2(M2),        
        .M3(M3),        
        .M4(M4),      
        .M5(M5),     
        .M6(M6),  
        .M7(M7),  
        .M8(M8),
        .M9(M9), 
        .ALUC(aluc),
        .RF_W(rf_w),        
        .DM_w(dram_w),   
        .DM_r(dram_r),     
        .EXT16(ext16_flag)
    );
    Regfiles cpu_ref(
        .clk(clk),
        .rst(rst),
        .we(rf_w),
        .raddr1(instr[25:21]),
        .raddr2(instr[20:16]),
        .waddr(mux5),
        .wdata(mux6),
        .rdata1(Rs),
        .rdata2(Rt)
    );
    PCReg pcreg(
        .clk(PC_CLK),
        .rst(rst),
        .ena(1'b1),
        .data_in(mux1),
        .data_out(Pc)
    );
    ALU alu(
        .a(mux8),
        .b(mux9),
        .aluc(aluc),
        .r(Alu),
        .zero(zero),
        .carry(carry),
        .negative(negative),
        .overflow(overflow)
    );
    NPC npc(
        .a(Pc),
        .rst(rst),
        .r(Npc)
    );
    ADDER add(
        .a(EXT18),
        .b(Npc),
        .r(ADD)
    );
    ADD8 add8(
        .a(Pc),
        .r(ADD8)
    );
    II ii(
        .a(Pc[31:28]),
        .b(instr[25:0]),
        .r(CONNECT)
    );
    MUX MUX1(
        .a(mux3),
        .b(mux2),
        .choice(M1),
        .z(mux1)
    );
    MUX MUX2(
        .a(Npc),
        .b(ADD),
        .choice(M2),
        .z(mux2)
    );
    MUX MUX3(
        .a(CONNECT),
        .b(Rs),
        .choice(M3),
        .z(mux3)
    );
    MUX5 Mux4(
        .a(instr[10:6]),
        .b(Rs[4:0]),
        .choice({code[30],M4}),
        .z(mux4)
    );
    MUX5 Mux5(
        .a(instr[15:11]),
        .b(instr[20:16]),
        .choice({code[30],M5}),
        .z(mux5)
    );
    MUX MUX6(
        .a(mux7),
        .b(ADD8),
        .choice(M6),
        .z(mux6)
    );
    MUX MUX7(
        .a(Alu),
        .b(rdata),
        .choice(M7),
        .z(mux7)
    );
    MUX MUX8(
        .a(EXT5),
        .b(Rs),
        .choice(M8),
        .z(mux8)
    );
    MUX MUX9(
        .a(Rt),
        .b(EXT16),
        .choice(M9),
        .z(mux9)
    );
    extend5 ext5(
        .a(mux4),
        .b(EXT5)
    );
    extend16 ext16(
        .a(instr[15:0]),
        .flag(ext16_flag),             //1±íÊ¾ÓÐ·ûºÅ
        .b(EXT16)
    );
    extend18 ext18(
        .a(instr[15:0]),
        .b(EXT18)
    );

endmodule
