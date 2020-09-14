`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:53:11
// Design Name: 
// Module Name: HI_LO
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


module HI_LO(
    input clk,  
    input rst,  
    input ena,  
    input [31:0] idata,   
    output [31:0] odata  
    );
    reg [31:0] data;

    always @ (negedge clk or posedge rst) 
    begin
        if (rst == 1)
            data = 32'h00000000; 
        else if (ena)
            data = idata;
    end

    assign odata = data;
endmodule
