`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 06:31:27 PM
// Design Name: 
// Module Name: MEM_WB_reg
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


module MEM_WB_reg(input clk,
                  input reset,
                  input RegWrite_MEM,
                  input MemtoReg_MEM,
                  input [4:0] RD_EX_MEM,
                  input [31:0] ADDRESS_MEM_WB,
                  input [31:0] READ_DATA_MEM,
                  output reg RegWrite_WB,
                  output reg MemtoReg_WB,
                  output reg [4:0] RD_MEM_WB,
                  output reg [31:0] ADDRESS_WB,
                  output reg [31:0] READ_DATA_WB
                  );
                  
    always @(posedge clk) begin
        if (reset) begin
            RegWrite_WB = 1'b0;
            MemtoReg_WB = 1'b0;
            RD_MEM_WB = 32'b0;
            ADDRESS_WB = 32'b0;
            READ_DATA_WB = 32'b0;
        end
        else begin
            RegWrite_WB = RegWrite_MEM;
            MemtoReg_WB = MemtoReg_MEM;
            RD_MEM_WB = RD_EX_MEM;
            ADDRESS_WB = ADDRESS_MEM_WB;
            READ_DATA_WB = READ_DATA_MEM;
        end
    end

endmodule
