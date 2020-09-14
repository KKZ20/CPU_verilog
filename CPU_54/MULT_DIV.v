`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:55:48
// Design Name: 
// Module Name: MULT_DIV
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


module MULT(
    input [31:0] a,
    input [31:0] b,
    output [63:0] z
    );
	wire [31:0] temp_a;
	wire [31:0] temp_b;
    wire [63:0] temp_z;

    assign temp_a = a[31] ? (0-a) : a;
	assign temp_b = b[31] ? (0-b) : b;
	assign temp_z = temp_a * temp_b;

	assign z = (a[31]==b[31]) ? temp_z : (0-temp_z);
	
endmodule

module DIV(
    input [31:0] dividend,  //被除数
    input [31:0] divisor,   //除数
    output [31:0] q,        //商
    output [31:0] r         //余数
    );
	wire [31:0] temp_dividend;
    wire [31:0] temp_divisor;
    wire [31:0] temp_q;
    wire [31:0] temp_r;
    wire [63:0] temp_m;

    assign temp_dividend = dividend[31]?(0-dividend):dividend;
    assign temp_divisor = divisor[31]?(0-divisor):divisor;
    assign temp_q = temp_dividend / temp_divisor;
    assign temp_r = temp_dividend % temp_divisor;
	
    
    assign q = (dividend[31]==divisor[31])?temp_q:(0-temp_q);
	assign temp_m = q * divisor;
    assign r = dividend - temp_m[31:0];
	
endmodule
