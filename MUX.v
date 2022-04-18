`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2022 09:13:52 PM
// Design Name: 
// Module Name: MUX
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


module MUX(input [1:0] sel,
           input [31:0] ina, inb, inc,
           output reg [31:0] out);

    always @* begin
        case(sel)
            2'b00: out <= ina;
            2'b01: out <= inb;
            2'b10: out <= inc;
        endcase
    end

endmodule
