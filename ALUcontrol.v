`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2022 06:45:26 PM
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);

    always @(*) begin
        casex({ALUop, funct7, funct3})
            12'b100000000000: ALUinput = 4'b0010; // ADD
            12'b100100000000: ALUinput = 4'b0110; // SUB
            12'b100000000111: ALUinput = 4'b0000; // AND
            12'b100000000110: ALUinput = 4'b0001; // OR
            12'b110000000110: ALUinput = 4'b0001; // ORI
            12'b100000000100: ALUinput = 4'b0011; // XOR
            12'b100000000101: ALUinput = 4'b0101; // SRLI, SRL
            12'b100000000001: ALUinput = 4'b0100; // SLLI, SLL
            12'b100100000101: ALUinput = 4'b1001; // SRAI, SRA
            12'b100000000011: ALUinput = 4'b0111; // SLTU
            12'b100000000010: ALUinput = 4'b1000; // SLT
            12'b01xxxxxxx000: ALUinput = 4'b0110; // BEQ
            12'b01xxxxxxx001: ALUinput = 4'b0110; // BNE
            12'b01xxxxxxx100: ALUinput = 4'b1000; // BLT
            12'b01xxxxxxx101: ALUinput = 4'b1000; // BGE
            12'b01xxxxxxx110: ALUinput = 4'b0111; // BLTU
            12'b01xxxxxxx111: ALUinput = 4'b0111; // BGEU
            12'b00xxxxxxxxxx: ALUinput = 4'b0010; // LD, SD
        endcase
    end

endmodule
