`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:52:39
// Design Name: 
// Module Name: EXT
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


module extend5 #(parameter WIDTH = 5)(
    input [WIDTH - 1:0] a,
    output [31:0] b
    );
    assign b = {{(32 - WIDTH){1'b0}},a};
endmodule

module extend16 #(parameter WIDTH = 16)(
    input [WIDTH - 1:0] a,
    input flag,             //1表示有符号
    output [31:0] b
    );
    //sign: 1: 符号位扩展; 0: 0扩展;
    assign b = flag ? {{(32 - WIDTH){a[WIDTH - 1]}},a} : {16'b0,a};
endmodule

module extend18 #(parameter WIDTH = 18)(
    input [15:0] a,
    output [31:0] b
    );
    assign b = {{(32 - WIDTH){a[15]}},a,2'b00};
endmodule
