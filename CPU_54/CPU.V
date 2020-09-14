`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:51:06
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
    output [1:0] select,
    output [31:0] pc,
    output [31:0] addr,
    output [31:0] wdata
    );

    //----------预定义常量----------//
    parameter Clz     = 31;
    parameter Divu    = 32;
    parameter Eret    = 33;
    parameter Lb      = 35;
    parameter Lbu     = 36;
    parameter Lhu     = 37;
    parameter Sb      = 38;
    parameter Sh      = 39;
    parameter Lh      = 40;
    parameter Mfc0    = 41;
    parameter Mfhi    = 42;
    parameter Mflo    = 43;
    parameter Mtc0    = 44;
    parameter Mthi    = 45;
    parameter Mtlo    = 46;
    parameter Mult    = 47;
    parameter Multu   = 48;
    parameter Syscall = 49;
    parameter Teq     = 50;
    parameter Break   = 52;
    parameter Div     = 53;
    //----------------------------//

     //---------------变量定义----------------//
    reg [31:0] DMEM_data;
    wire [31:0] Pc;
    wire [31:0] Npc;
    wire [31:0] Rs;
    wire [31:0] Rt;
    wire [31:0] Alu;
    wire PC_CLK;

    wire [31:0] Mux1;            
    wire [31:0] Mux2;            
    wire [31:0] Mux3;            
    wire [4:0]  Mux4;            
    wire [4:0]  Mux5;            
    wire [31:0] Mux6;            
    wire [31:0] Mux7;            
    wire [31:0] Mux8;            
    wire [31:0] Mux9; 
    wire [31:0] Mux10; 
    wire [31:0] Mux_Rd;

    wire [31:0] EXT5;            
    wire [31:0] EXT16;           
    wire [31:0] EXT18;           
    wire [31:0] ADD;             
    wire [31:0] ADD8;    
    wire [31:0] CONNECT;

    wire [31:0] CLZ_count;

    wire [31:0] DIVU_q;
    wire [31:0] DIVU_r;

    wire [31:0] DIV_q;
    wire [31:0] DIV_r;

    wire [63:0] MULTU_z;
    wire [63:0] MULT_z;

    wire [1:0] temp_select;

    wire exception;
    wire [4:0] cause;
    wire [31:0] CP0_rdata; 
    wire [31:0] status;
    wire [31:0] exception_addr; 

    reg [31:0] HI_in;
    reg [31:0] LO_in;
    wire [31:0] HI_out;
    wire [31:0] LO_out;
    wire HI_ena;
    wire LO_ena;

    wire [53:0] code;

    wire dram_r;
    wire dram_w;
    wire rf_w;
    wire ext16_sign;

    wire M1;
    wire M2;
    wire M3;
    wire M4;
    wire M5;
    wire M6;
    wire M7;
    wire M8;
    wire M9;
    wire M10;
    wire [2:0] M_Rd;

    wire [3:0] aluc;
    wire zero;
    wire carry;
    wire negative;
    wire overflow;

    wire mfc0;
    wire mtc0;
    wire CLZ_ENA;          //CLZ的信号

    assign rena = dram_r;
    assign wena = dram_w;
    assign select = temp_select;       //选择
    assign pc = Pc;
    assign addr = Alu;
    assign wdata = Rt;
    //---------------------------------------//


    //-----------赋值部分------------//
    always @ (*)
    begin
        if (code[Lb])
            DMEM_data = {{24{rdata[31]}}, rdata[31:24]};
        else if (code[Lbu])
            DMEM_data = {24'b0, rdata[31:24]};
        else if (code[Lh])
            DMEM_data = {{16{rdata[31]}}, rdata[31:16]};
        else if (code[Lhu])
            DMEM_data = {16'b0, rdata[31:16]};
        else
            DMEM_data = rdata;
    end

    always @ (*)
    begin
        if (code[Div]) 
        begin
            HI_in = DIV_r;
            LO_in = DIV_q;
        end
        else if (code[Divu])
        begin
            HI_in = DIVU_r;
            LO_in = DIVU_q;
        end
        else if (code[Mult]) 
        begin
            HI_in = MULT_z[63:32];
            LO_in = MULT_z[31:0];
        end
        else if (code[Multu]) 
        begin
            HI_in = MULTU_z[63:32];
            LO_in = MULTU_z[31:0];
        end
        else if (code[Mthi])
            HI_in = Rs;
        else if (code[Mtlo])
            LO_in = Rs;
    end
    //---------------------------------------//


    //--------------模块调用-----------------//
    Instr_dec instr_decode(
        .instr_code(instr),
        .code(code)
    );
    operation control(
        .clk(clk),
        .zero(zero),
        .code(code),
        .instr(instr),
        .Rs(Rs),
        .PC_CLK(PC_CLK),
        .M1(M1),
        .M2(M2),
        .M3(M3),
        .M4(M4),
        .M5(M5),
        .M6(M6),
        .M7(M7),
        .M8(M8),
        .M9(M9), 
        .M10(M10),
        .ALUC(aluc),
        .RF_W(rf_w),
        .DM_w(dram_w),
        .DM_r(dram_r),
        .EXT16(ext16_sign),
        .mfc0(mfc0),
        .mtc0(mtc0),
        .exception(exception),
        .HI_ena(HI_ena),
        .LO_ena(LO_ena),
        .M_Rd(M_Rd),
        .select(temp_select),
        .cause(cause),
        .CLZ_ENA(CLZ_ENA)
    );
    Regfiles cpu_ref(
        .clk(clk),
        .rst(rst),
        .we(rf_w),
        .raddr1(instr[25:21]),
        .raddr2(instr[20:16]),
        .waddr(Mux5),
        .wdata(Mux_Rd),
        .rdata1(Rs),
        .rdata2(Rt)
    );
    PCReg pcreg(
        .clk(PC_CLK),
        .rst(rst),
        .ena(1'b1),
        .data_in(Mux10),
        .data_out(Pc)
    );
    NPC npc(
        .a(Pc),
        .rst(rst),
        .r(Npc)
    );
    CP0 cp0(
        .clk(clk),
        .rst(rst),
        .wdata(Rt),
        .addr(instr[15:11]),
        .pc(Pc),
        .mfc0(mfc0),
        .mtc0(mtc0),
        .exception(exception),
        .eret(code[Eret]),
        .cause(cause),
        .rdata(CP0_rdata),
        .status(status),
        .exception_addr(exception_addr)
    );
    ALU alu(
        .a(Mux8),
        .b(Mux9),
        .aluc(aluc),
        .r(Alu),
        .zero(zero),
        .carry(carry),
        .negative(negative),
        .overflow(overflow)
    );
    DIVU divu(
        .dividend(Rs),
        .divisor(Rt),
        .q(DIVU_q),
        .r(DIVU_r)
    );
    DIV div(
        .dividend(Rs),
        .divisor(Rt),
        .q(DIV_q),
        .r(DIV_r)
    );
    MULTU multu(
        .a(Rs),
        .b(Rt),
        .z(MULTU_z)
    );
    MULT mult(
        .a(Rs),
        .b(Rt),
        .z(MULT_z)
    );
    HI_LO hi(
        .clk(clk),
        .rst(rst),
        .ena(HI_ena),
        .idata(HI_in),
        .odata(HI_out)
    );
    HI_LO lo(
        .clk(clk),
        .rst(rst),
        .ena(LO_ena),
        .idata(LO_in),
        .odata(LO_out)
    );
    CLZ clz(
        .idata(Rs),
        .ena(CLZ_ENA),
        .odata(CLZ_count)
    );
    ADD adder(
        .a(EXT18),
        .b(Npc),
        .r(ADD)
    );
    ADD8 adder8(
        .a(Pc),
        .r(ADD8)
    );
    II connector(
        .a(Pc[31:28]),
        .b(instr[25:0]),
        .r(CONNECT)
    );

    MUX mux1(
        .a(Mux3),
        .b(Mux2),
        .choice(M1),
        .r(Mux1)
    );
    MUX mux2(
        .a(Npc),
        .b(ADD),
        .choice(M2),
        .r(Mux2)
    );
    MUX mux3(
        .a(CONNECT),
        .b(Rs),
        .choice(M3),
        .r(Mux3)
    );
    MUX5 mux4(
        .a(instr[10:6]),
        .b(Rs[4:0]),
        .choice({code[30], M4}),
        .z(Mux4)
    );
    MUX5 mux5(
        .a(instr[15:11]),
        .b(instr[20:16]),
        .choice({code[30], M5}),
        .z(Mux5)
    );
    MUX mux6(
        .a(Mux7),
        .b(ADD8),
        .choice(M6),
        .r(Mux6)
    );
    MUX mux8(
        .a(EXT5),
        .b(Rs),
        .choice(M8),
        .r(Mux8)
    );
    MUX mux9(
        .a(Rt),
        .b(EXT16),
        .choice(M9),
        .r(Mux9)
    );

    MUX mux10(
        .a(Mux1),
        .b(exception_addr),
        .choice(M10),
        .r(Mux10)
    );
    MUX_RD mux_rd(
        .alu(Alu),
        .dm_data(DMEM_data),
        .clz(CLZ_count),
        .hi_data(HI_out),
        .lo_data(LO_out),
        .cp0_rdata(CP0_rdata),
        .pc_4(Pc + 4),
        .choice(M_Rd),
        .r(Mux_Rd)
    );

    extend5 ext5(
        .a(Mux4),
        .b(EXT5)
    );
    extend16 ext16(
        .a(instr[15:0]),
        .flag(ext16_sign),
        .b(EXT16)
    );
    extend18 ext18(
        .a(instr[15:0]),
        .b(EXT18)
    );
    //---------------------------------------//
endmodule
