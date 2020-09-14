`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:58:47
// Design Name: 
// Module Name: MUX5
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


module MUX5(
    input [4:0] a,
    input [4:0] b,
    input [1:0] choice,
    output reg [4:0] z
    );
    //reg [4:0] t_z;
    always @ (*)
    begin
        case(choice)
            2'b01:z = b;
            2'b00:z = a;
            2'b10:z = 5'b11111;
            2'b11:z = 5'b11111;
            default:z = 5'bz;
        endcase
    end
    //assign z = t_z;
endmodule
