`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2022 07:19:07 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUinput,
           input [31:0] ina, inb,
           output zero,
           output reg [31:0] out);
    
    always @* begin
        casex(ALUinput)
            4'b0010: out <= ina + inb; // ADD
            4'b0110: out <= ina - inb; // SUB + BEQ, BNE prin verificarea flag ZERO
            4'b0000: out <= ina & inb; // AND
            4'b0001: out <= ina | inb; // OR
            4'b0011: out <= ina ^ inb; // XOR
            4'b0101: out <= ina >> inb[4:0]; // SRL
            4'b0100: out <= ina << inb[4:0]; // SLL
            4'b1001: out <= ina >>> inb[4:0]; // SRA
            4'b1000: out <= ($signed(ina) < $signed(inb)) ? 1 : 0; // SLT + BLT, BGE
            4'b0111: out <= (ina < inb) ? 1 : 0; // SLTU + BLTU, BGEU
            //4'b0110: out <= (ina == inb) ? 1 : 0; // BEQ, BNE
            //4'b1000: out <= ($signed(ina) <= $singed(inb)) ? 1 : 0; // BLT, BGE
            //4'b0111: out <= (ina <= inb) ? 1 : 0; // BLTU, BGEU
        endcase
    end
    
    assign zero = (out == 32'b0) ? 1 : 0;

endmodule
