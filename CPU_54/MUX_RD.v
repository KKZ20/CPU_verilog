`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:57:25
// Design Name: 
// Module Name: MUX_RD
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


module MUX_RD(
    input [31:0] alu,
    input [31:0] dm_data,
    input [31:0] clz,
    input [31:0] hi_data,
    input [31:0] lo_data,
    input [31:0] cp0_rdata,
    input [31:0] pc_4,
    input [2:0] choice,
    output [31:0] r
    );
    reg [31:0] result;
    
    assign r = result;
    
    always @ (*)
    begin
        case (choice)
            3'b000: result = alu;
            3'b001: result = dm_data;
            3'b010: result = clz;
            3'b011: result = hi_data;
            3'b100: result = lo_data;
            3'b101: result = cp0_rdata;
            3'b110: result = pc_4;
            default: result = alu;
        endcase
    end
endmodule
