`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 06:31:07 PM
// Design Name: 
// Module Name: EX_MEM_reg
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


module EX_MEM_reg(input clk,
                  input reset,
                  input REG_WRITE_EX,
                  input MEM_REG_EX,
                  input MEM_READ_EX,
                  input MEM_WRITE_EX,
                  input [31:0] ADDRESS_EX,
                  input [31:0] READ_DATA2_EX,
                  input ZERO_EX,
                  input [31:0] BRANCH_SUM_EX,
                  input BRANCH_EX,
                  input [4:0] RD_EX,
                  output reg REG_WRITE_MEM,
                  output reg MEM_REG_MEM,
                  output reg MEM_READ_MEM,
                  output reg MEM_WRITE_MEM,
                  output reg [31:0] ADDRESS_MEM,
                  output reg [31:0] WRITE_DATA,
                  output reg ZERO_MEM,
                  output reg [31:0] BRANCH_SUM_MEM,
                  output reg BRANCH_MEM,
                  output reg [4:0] RD_MEM
                  );
                  
    always @(posedge clk) begin
        if (reset) begin
            REG_WRITE_MEM = 1'b0;
            MEM_REG_MEM = 1'b0;
            MEM_READ_MEM = 1'b0;
            MEM_WRITE_MEM = 1'b0;
            ADDRESS_MEM = 32'b0;
            WRITE_DATA = 32'b0;
            ZERO_MEM = 1'b0;
            BRANCH_SUM_MEM = 32'b0;
            BRANCH_MEM = 1'b0;
            RD_MEM = 32'b0;
        end
        else begin
            REG_WRITE_MEM = REG_WRITE_EX;
            MEM_REG_MEM = MEM_REG_EX;
            MEM_READ_MEM = MEM_READ_EX;
            MEM_WRITE_MEM = MEM_WRITE_EX;
            ADDRESS_MEM = ADDRESS_EX;
            WRITE_DATA = READ_DATA2_EX;
            ZERO_MEM = ZERO_EX;
            BRANCH_SUM_MEM = BRANCH_SUM_EX;
            BRANCH_MEM = BRANCH_EX;
            RD_MEM = RD_EX;
        end
    end
                  
endmodule
