`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 16:12:46
// Design Name: 
// Module Name: test
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


module CPU_test;
    reg clk;
    reg rst;
    wire [31:0] instr;
    wire [31:0] pc;
    
    integer file_output;
    integer count = 0;
    initial
    begin
        file_output = $fopen("result.txt");
        clk = 0;
        rst = 1;
        #10
        rst = 0;
    end
        
    always #2 clk = ~clk;
    always @(posedge clk) 
    begin
        count <= count + 1;
        if (rst == 0) 
        begin
            $fdisplay(file_output,"pc: %h",sc.sccpu.pcreg.data_out);
            $fdisplay(file_output,"instr: %h",instr);
            $fdisplay(file_output,"regfile0: %h",sc.sccpu.cpu_ref.array_reg[0]);
            $fdisplay(file_output,"regfile1: %h",sc.sccpu.cpu_ref.array_reg[1]);
            $fdisplay(file_output,"regfile2: %h",sc.sccpu.cpu_ref.array_reg[2]);
            $fdisplay(file_output,"regfile3: %h",sc.sccpu.cpu_ref.array_reg[3]);
            $fdisplay(file_output,"regfile4: %h",sc.sccpu.cpu_ref.array_reg[4]);
            $fdisplay(file_output,"regfile5: %h",sc.sccpu.cpu_ref.array_reg[5]);
            $fdisplay(file_output,"regfile6: %h",sc.sccpu.cpu_ref.array_reg[6]);
            $fdisplay(file_output,"regfile7: %h",sc.sccpu.cpu_ref.array_reg[7]);
            $fdisplay(file_output,"regfile8: %h",sc.sccpu.cpu_ref.array_reg[8]);
            $fdisplay(file_output,"regfile9: %h",sc.sccpu.cpu_ref.array_reg[9]);
            $fdisplay(file_output,"regfile10: %h",sc.sccpu.cpu_ref.array_reg[10]);
            $fdisplay(file_output,"regfile11: %h",sc.sccpu.cpu_ref.array_reg[11]);
            $fdisplay(file_output,"regfile12: %h",sc.sccpu.cpu_ref.array_reg[12]);
            $fdisplay(file_output,"regfile13: %h",sc.sccpu.cpu_ref.array_reg[13]);
            $fdisplay(file_output,"regfile14: %h",sc.sccpu.cpu_ref.array_reg[14]);
            $fdisplay(file_output,"regfile15: %h",sc.sccpu.cpu_ref.array_reg[15]);
            $fdisplay(file_output,"regfile16: %h",sc.sccpu.cpu_ref.array_reg[16]);
            $fdisplay(file_output,"regfile17: %h",sc.sccpu.cpu_ref.array_reg[17]);
            $fdisplay(file_output,"regfile18: %h",sc.sccpu.cpu_ref.array_reg[18]);
            $fdisplay(file_output,"regfile19: %h",sc.sccpu.cpu_ref.array_reg[19]);
            $fdisplay(file_output,"regfile20: %h",sc.sccpu.cpu_ref.array_reg[20]);
            $fdisplay(file_output,"regfile21: %h",sc.sccpu.cpu_ref.array_reg[21]);
            $fdisplay(file_output,"regfile22: %h",sc.sccpu.cpu_ref.array_reg[22]);
            $fdisplay(file_output,"regfile23: %h",sc.sccpu.cpu_ref.array_reg[23]);
            $fdisplay(file_output,"regfile24: %h",sc.sccpu.cpu_ref.array_reg[24]);
            $fdisplay(file_output,"regfile25: %h",sc.sccpu.cpu_ref.array_reg[25]);
            $fdisplay(file_output,"regfile26: %h",sc.sccpu.cpu_ref.array_reg[26]);
            $fdisplay(file_output,"regfile27: %h",sc.sccpu.cpu_ref.array_reg[27]);
            $fdisplay(file_output,"regfile28: %h",sc.sccpu.cpu_ref.array_reg[28]);
            $fdisplay(file_output,"regfile29: %h",sc.sccpu.cpu_ref.array_reg[29]);
            $fdisplay(file_output,"regfile30: %h",sc.sccpu.cpu_ref.array_reg[30]);
            $fdisplay(file_output,"regfile31: %h",sc.sccpu.cpu_ref.array_reg[31]);
            //$fdisplay(file_output,"rdata: %h",sc.rdata);

        end
    end

    sccomp_dataflow sc(
        .clk_in(clk),
        .reset(rst),
        .inst(instr),
        .pc(pc)
    );
endmodule
