`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 16:00:14
// Design Name: 
// Module Name: pcreg
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


module PCReg(
    input clk,            //下降沿赋值
    input rst,            //高电平有效
    input ena,
    input [31:0] data_in,
    output [31:0] data_out
    );
    reg [31:0] temp;
    always @(negedge clk or posedge rst) 
    begin
        if (ena) 
        begin
            if (rst) 
            begin
                temp <= 32'h00400000;
            end
            else 
            begin
                temp <= data_in;
            end
        end
    end

    assign data_out = (ena && !rst) ? temp : 32'hz;
endmodule
