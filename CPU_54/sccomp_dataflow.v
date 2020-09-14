`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 16:01:40
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
    );

    wire clk;
    wire rena;
    wire wena;
    wire [1:0] select;
    wire [31:0] iram_addr;
    wire [31:0] dram_addr;
    wire [31:0] rdata;
    wire [31:0] wdata;
    
    assign clk = clk_in;
    assign iram_addr = pc - 32'h0040_0000;
    
    IMEM iram(
        .addr(iram_addr[12:2]),
        .instr(inst)
    );
    DMEM dram(
        .clk(clk),
        .rena(rena),
        .wena(wena),
        .select(select),
        .addr(dram_addr),
        .data_in(wdata),
        .data_out(rdata)
    );
    CPU sccpu(
        .clk(clk),
        .rst(reset),
        .instr(inst),
        .rdata(rdata),
        .rena(rena),
        .wena(wena),
        .select(select),
        .pc(pc),
        .addr(dram_addr),
        .wdata(wdata)
    );
endmodule
