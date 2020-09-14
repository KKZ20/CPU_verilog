`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/28 15:01:47
// Design Name: 
// Module Name: Regfiles
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


module Regfiles(
    input clk,
    input rst,
    input we,
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] waddr,
    input [31:0] wdata,
    output [31:0] rdata1,
    output [31:0] rdata2
    );
    reg [31:0] array_reg[0:31];      
    assign rdata1 = array_reg[raddr1];
    assign rdata2 = array_reg[raddr2];    

    always @(negedge clk or posedge rst) 
    begin                                           
        if (rst) 
        begin                               
            array_reg[0]  <= 0;          
            array_reg[1]  <= 0;
            array_reg[2]  <= 0;
            array_reg[3]  <= 0;
            array_reg[4]  <= 0;
            array_reg[5]  <= 0;
            array_reg[6]  <= 0;
            array_reg[7]  <= 0;
            array_reg[8]  <= 0;
            array_reg[9]  <= 0;
            array_reg[10] <= 0;
            array_reg[11] <= 0;
            array_reg[12] <= 0;
            array_reg[13] <= 0;
            array_reg[14] <= 0;
            array_reg[15] <= 0;
            array_reg[16] <= 0;
            array_reg[17] <= 0;
            array_reg[18] <= 0;
            array_reg[19] <= 0;
            array_reg[20] <= 0;
            array_reg[21] <= 0;
            array_reg[22] <= 0;
            array_reg[23] <= 0;
            array_reg[24] <= 0;
            array_reg[25] <= 0;
            array_reg[26] <= 0;
            array_reg[27] <= 0;
            array_reg[28] <= 0;
            array_reg[29] <= 0;
            array_reg[30] <= 0;
            array_reg[31] <= 0;
        end     
        
        else if(we)
        begin          
            if(waddr != 0)
                array_reg[waddr] <= wdata;
            else
                array_reg[0] <= 0; 
        end             
    end 
endmodule

