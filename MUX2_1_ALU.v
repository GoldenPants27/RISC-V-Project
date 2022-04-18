`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2022 10:04:04 PM
// Design Name: 
// Module Name: MUX2_1_ALU
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


module MUX2_1_ALU(input sel,
                  input [31:0] ina, inb,
                  output [31:0] out);
                  
    assign out = (sel == 0) ? ina : inb;

endmodule
