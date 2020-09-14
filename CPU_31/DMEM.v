`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/28 14:58:32
// Design Name: 
// Module Name: DMEM
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


module DMEM(
    input clk,
    input rena,
    input wena,
    //input [31:0] addr,
    input [9:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out
    );
    reg [31:0] memory[0:1023];
    always @(posedge clk)
    begin
       if(rena)
            data_out <= memory[addr];
        if(wena)
            memory[addr] <= data_in;
    end
    //assign data_out = rena ? memory[(addr-32'h10010000/4)]:32'bz;
endmodule
