`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:52:02
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
    input [1:0] select,
    input [31:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out
    );

    reg [7:0] memory[1023:0];
    wire [7:0] real_addr;

    assign real_addr = addr - 32'h10010000;

    always @ (posedge clk)
    begin
        if (rena)
            data_out <= {memory[real_addr], memory[real_addr + 1], memory[real_addr + 2], memory[real_addr + 3]};
        if (wena) 
        begin
            if (select == 2'b01) 
            begin
                //SB
                memory[real_addr] = data_in[7:0];
            end
            else if (select == 2'b10) 
            begin
                //SH
                memory[real_addr] = data_in[15:8];
                memory[real_addr + 1] = data_in[7:0];
            end
            else if (select == 2'b11) 
            begin
                //SW
                memory[real_addr] = data_in[31:24];
                memory[real_addr + 1] = data_in[23:16];
                memory[real_addr + 2] = data_in[15:8];
                memory[real_addr + 3] = data_in[7:0];
            end
        end
    end
endmodule
