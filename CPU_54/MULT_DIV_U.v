`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:56:24
// Design Name: 
// Module Name: MULT_DIV_U
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


module MULTU(
    input [31:0] a,
    input [31:0] b,
    output [63:0] z
    );
	assign z = a * b;
	
endmodule

module DIVU(
    input [31:0] dividend,  //被除数
    input [31:0] divisor,   //除数
    output [31:0] q,        //商
    output [31:0] r         //余数
    );
	assign q = dividend / divisor;
	assign r = dividend % divisor;
	
endmodule
