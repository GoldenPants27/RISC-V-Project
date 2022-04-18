`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2022 09:38:51 PM
// Design Name: 
// Module Name: EX
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


module EX(input [31:0] IMM_EX,              // valoarea imidiata in EX
          input [31:0] REG_DATA1_EX,        // valoarea registrului sursa 1
          input [31:0] REG_DATA2_EX,        // valoarea registrului sursa 2
          input [31:0] PC_EX,               // adresa instructiunii curente in EX
          input [2:0] FUNCT3_EX,            // funct3 pentru instructiunea din EX
          input [6:0] FUNCT7_EX,            // funct7 pentru instructiunea din EX
          input [4:0] RD_EX,                // adresa registrului destinatie
          input [4:0] RS1_EX,               // adresa registrului sursa 1
          input [4:0] RS2_EX,               // adresa registrului sursa 2
          input RegWrite_EX,                // semnal de scriere in bancul de registrii
          input MemtoReg_EX,                // ...
          input MemRead_EX,                 // semnal pentru activarea citirii din memorie
          input MemWrite_EX,                // semnal pentru activarea scrierii in memorie
          input [1:0] ALUop_EX,             // semnal de control ALUop
          input ALUsrc_EX,                  // semnal de selectie intre RS2 si valoarea imediata
          input Branch_EX,                  // semnal de identificare ale instructiunilor de tip branch
          input [1:0] forwardA, forwardB,   // semnalele de selectie pentru multiplexoarele de forwarding
          
          input [31:0] ALU_DATA_WB,         // valoarea calculata de ALU, prezenta in WB
          input [31:0] ALU_DATA_MEM,        // valoarea calculata de ALU, prezenta in MEM
          
          output ZERO_EX,                   // flag-ul ZERO calculat de ALU
          output [31:0] ALU_OUT_EX,         // rezultatul calculat de ALU in EX
          output [31:0] PC_Branch_EX,       // adresa de salt calculata in EX
          output [31:0] REG_DATA2_EX_FINAL  // valoarea registrului sursa 2 selectata dintre
          );                                // valorile prezente in etapele EX, MEM si WB
    
    wire [31:0] mux1_out, mux2_out, mux3_out;
    wire [3:0] ALUinput;
    reg [31:0] mux3_in;
      
    adder_branch ADD_BRANCH(PC_EX, IMM_EX, PC_Branch_EX);
    MUX MUX1(forwardA, REG_DATA1_EX, ALU_DATA_WB, ALU_DATA_MEM, mux1_out);
    MUX MUX2(forwardB, REG_DATA2_EX, ALU_DATA_WB, ALU_DATA_MEM, mux2_out);
    
    assign REG_DATA2_EX_FINAL = mux2_out;
    
    always @* begin
        mux3_in = mux2_out;
    end
    
    MUX2_1_ALU MUX3(ALUsrc_EX, mux3_in, IMM_EX, mux3_out);
    ALUcontrol ALU_CONTROL(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALUinput);
    ALU ALU(ALUinput, mux1_out, mux3_out, ZERO_EX, ALU_OUT_EX);
    
endmodule
