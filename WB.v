`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2022 09:19:41 PM
// Design Name: 
// Module Name: WB
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


module WB(input [4:0] RD_WB,               // RD din etapa WB
          input [31:0] ADDRESS_WB,          // adresa in etapa de WB
          input [31:0] READ_DATA_WB,        // datele citite din data memory in etapa de WB
          input MemtoReg,                   // semnalul de control al multiplexorului
          input ControlRegWrite,            // semnalul provenit din unitatea de control
          output [31:0] WRITE_DATA_WB_ID,   // outputul multiplexorului
          output RegWrite_ID,               // semnalul de control ce va fi trimis catre bancul de registrii din ID
          output [4:0] RD_WB_FORWARD       // RD ce va fi trimis catre unitatea de forward
          );
          
    assign WRITE_DATA_WB_ID = (MemtoReg) ? READ_DATA_WB : ADDRESS_WB;
    assign RD_WB_FORWARD = RD_WB;
    assign RegWrite_ID = ControlRegWrite;
          
endmodule
