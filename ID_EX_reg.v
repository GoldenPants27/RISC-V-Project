`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 06:30:29 PM
// Design Name: 
// Module Name: ID_EX_reg
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


module ID_EX_reg(input clk,
                 input reset,
                 input [31:0] IMM_ID,
                 input [31:0] REG_DATA1_ID,
                 input [31:0] REG_DATA2_ID,
                 input RegWrite_ID,
                 input MemtoReg_ID,
                 input MemRead_ID,
                 input MemWrite_ID,
                 input [1:0] ALUop_ID,
                 input ALUsrc_ID,
                 input Branch_ID,
                 input [31:0] PC_ID,
                 input [6:0] FUNCT7_ID,
                 input [2:0] FUNCT3_ID,
                 input [4:0] RD_ID,
                 input [4:0] RS1_ID,
                 input [4:0] RS2_ID,
                 output reg [31:0] IMM_EX,
                 output reg [31:0] REG_DATA1_EX,
                 output reg [31:0] REG_DATA2_EX,
                 output reg RegWrite_EX,
                 output reg MemtoReg_EX,
                 output reg MemRead_EX,
                 output reg MemWrite_EX,
                 output reg [1:0] ALUop_EX,
                 output reg ALUsrc_EX,
                 output reg Branch_EX,
                 output reg [31:0] PC_EX,
                 output reg [6:0] FUNCT7_EX,
                 output reg [2:0] FUNCT3_EX,
                 output reg [4:0] RD_EX,
                 output reg [4:0] RS1_EX,
                 output reg [4:0] RS2_EX
                 );
                 
    always @(posedge clk) begin
        if (reset) begin
            IMM_EX = 32'b0;
            REG_DATA1_EX = 32'b0;
            REG_DATA2_EX = 32'b0;
            RegWrite_EX = 1'b0;
            MemtoReg_EX = 1'b0;
            MemRead_EX = 1'b0;
            MemWrite_EX = 1'b0;
            ALUop_EX = 2'b0;
            ALUsrc_EX = 1'b0;
            Branch_EX = 1'b0;
            PC_EX = 32'b0;
            FUNCT7_EX = 7'b0;
            FUNCT3_EX = 3'b0;
            RD_EX = 5'b0;
            RS1_EX = 5'b0;
            RS2_EX = 5'b0;
        end
        else begin
            IMM_EX = IMM_ID;
            REG_DATA1_EX = REG_DATA1_ID;
            REG_DATA2_EX = REG_DATA2_ID;
            RegWrite_EX = RegWrite_ID;
            MemtoReg_EX = MemtoReg_ID;
            MemRead_EX = MemRead_ID;
            MemWrite_EX = MemWrite_ID;
            ALUop_EX = ALUop_ID;
            ALUsrc_EX = ALUsrc_ID;
            Branch_EX = Branch_ID;
            PC_EX = PC_ID;
            FUNCT7_EX = FUNCT7_ID;
            FUNCT3_EX = FUNCT3_ID;
            RD_EX = RD_ID;
            RS1_EX = RS1_ID;
            RS2_EX = RS2_ID;
        end
    end
                 
endmodule
