`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2022 10:07:40 PM
// Design Name: 
// Module Name: ADDER_Branch
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


module adder_branch(input [31:0] current_PC, imm_value,
                    output [31:0] branch_PC);
                    
    assign branch_PC = current_PC + imm_value;
               
endmodule
