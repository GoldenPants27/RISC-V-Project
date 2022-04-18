`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 06:00:05 PM
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(input [4:0] rd,         // adresa registrului destinatie in etapa EX
                        input [4:0] rs1,        // adresa registrului sursa 1 decodificat in etapa ID
                        input [4:0] rs2,        // adresa registrului sursa 2 decodificat in etapa ID
                        input MemRead,          // semnalul de control MemRead din etapa EX
                        output reg PCwrite,     // semnalul PCwrite ce controleaza scrierea in registrul PC
                        output reg IF_IDwrite,  // semnal ca controleaza scrierea in registrul de pipeline IF_ID
                        output reg control_sel  // semnal transmis spre unitatea de control
                        );
                        
    always @* begin
        if (MemRead && ((rd == rs1) || (rd == rs2))) begin
            PCwrite <= 1'b0;
            IF_IDwrite <= 1'b0;
            control_sel <= 1'b1;
        end
        else begin
            PCwrite <= 1'b1;
            IF_IDwrite <= 1'b1;
            control_sel <= 1'b0;
        end
    end

endmodule
