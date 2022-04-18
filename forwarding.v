`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 06:11:21 PM
// Design Name: 
// Module Name: forwarding
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


module forwarding(input [4:0] rs1,                      // adresa registrului sursa 1 in etapa EX
                  input [4:0] rs2,                      // adresa registrului sursa 2 in etapa EX
                  input [4:0] ex_mem_rd,                // adresa registrului destinatie in etapa MEM
                  input [4:0] mem_wb_rd,                // adresa registrului destinatie in etapa WB
                  input ex_mem_regwrite,                // semnalul de control RegWrite in etapa MEM
                  input mem_wb_regwrite,                // semnalul de control RegWrite in etapa WB
                  output reg [1:0] forwardA, forwardB   // semnalele de selectie a multiplexoarelor ce vor alege valoarea ce trebuie bypassata 
                  );
                  
    reg checkA, checkB;

    always @* begin     // Pentru hazard in etapa EX
        checkA = 0;
        checkB = 0;
        if (ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == rs1)) begin
            forwardA = 2'b10;
            checkA = 1;
        end 
        if (ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == rs2)) begin
            forwardB = 2'b10;
            checkB = 1;
        end
        if (mem_wb_regwrite && (mem_wb_rd != 0) && !(ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == rs1)) && (mem_wb_rd == rs1)) begin
            forwardA = 2'b01;
            checkA = 1;
        end
        if (mem_wb_regwrite && (mem_wb_rd != 0) && !(ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == rs2)) && (mem_wb_rd == rs2)) begin
            forwardB = 2'b01;
            checkB = 1;
        end
        if (checkA == 0) begin
            forwardA = 2'b00;
        end
        if (checkB == 0) begin
            forwardB = 2'b00;
        end
    end
    
//    always @* begin     // Pentru hazard in etapa MEM
//        if (mem_wb_regwrite & (mem_wb_rd != 0) & !(ex_mem_regwrite & (ex_mem_rd != 0) & (ex_mem_rd == rs1)) & (mem_wb_rd == rs1)) begin
//            forwardA = 2'b01;
//            check = 1'b1;
//        end
//        else begin
//            check = 1'b0;
//        end
        
//        if (mem_wb_regwrite & (mem_wb_rd != 0) & !(ex_mem_regwrite & (ex_mem_rd != 0) & (ex_mem_rd == rs2)) & (mem_wb_rd == rs2)) begin
//            forwardB = 2'b01;
//            check = 1'b1;
//        end
//        else begin
//            check = 1'b0;
//        end
//    end

endmodule
