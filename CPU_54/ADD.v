`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:44:58
// Design Name: 
// Module Name: ADD
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


module ADD(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r
    );
    assign r=a+b;
endmodule


module ADD8(
    input [31:0] a,
    output [31:0] r
    );
    assign r=a+4;
endmodule
