`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 15:47:54
// Design Name: 
// Module Name: CLZ
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


module CLZ(
    input [31:0] idata,
    input ena,
    output reg [31:0] odata
    );
    always @ (*) 
    begin
        if (ena) 
        begin 
            if (idata[31])
                odata <= 32'd0;
            else if (idata[30])
                odata <= 32'd1;
            else if (idata[29])
                odata <= 32'd2;
            else if (idata[28])
                odata <= 32'd3;
            else if (idata[27])
                odata <= 32'd4;
            else if (idata[26])
                odata <= 32'd5;
            else if (idata[25])
                odata <= 32'd6;
            else if (idata[24])
                odata <= 32'd7;
            else if (idata[23])
                odata <= 32'd8;
            else if (idata[22])
                odata <= 32'd9;
            else if (idata[21])
                odata <= 32'd10;
            else if (idata[20])
                odata <= 32'd11;
            else if (idata[19])
                odata <= 32'd12;
            else if (idata[18])
                odata <= 32'd13;
            else if (idata[17])
                odata <= 32'd14;
            else if (idata[16])
                odata <= 32'd15;
            else if (idata[15])
                odata <= 32'd16;
            else if (idata[14])
                odata <= 32'd17;
            else if (idata[13])
                odata <= 32'd18;
            else if (idata[12])
                odata <= 32'd19;
            else if (idata[11])
                odata <= 32'd20;
            else if (idata[10])
                odata <= 32'd21;
            else if (idata[9])
                odata <= 32'd22;
            else if (idata[8])
                odata <= 32'd23;
            else if (idata[7])
                odata <= 32'd24;
            else if (idata[6])
                odata <= 32'd25;
            else if (idata[5])
                odata <= 32'd26;
            else if (idata[4])
                odata <= 32'd27;
            else if (idata[3])
                odata <= 32'd28;
            else if (idata[2])
                odata <= 32'd29;
            else if (idata[1])
                odata <= 32'd30;
            else if (idata[0])
                odata <= 32'd31;
            else if (idata[0] == 1'b0)
                odata <= 32'd32;
            else 
                odata <= 32'bx;
        end 
        else 
            odata <= 32'bx;
    end

endmodule
