`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2022 06:20:03 PM
// Design Name: 
// Module Name: mem
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


module MEM(input clk,                       // semnal de ceas pentru scrierea in data memory 
           input MEM_READ,                  // semnal de activare a citirii din memorie
           input MEM_WRITE,                 // semnal de activare a scrierii in memorie
           input [31:0] ADDRESS_MEM,        // adresa de scriere/citire
           input [31:0] WRITE_DATA,         // valoarea scrisa in memorie
           input ZERO,                      // semnal de zero pentru AND de branch
           input [31:0] BRANCH_SUM,         // valoare adresei dupa branch
           input BRANCH,                    // semnal de branch pentru AND de branch
           output [31:0] ADDRESS_MEM_WB,    // adresa de scriere/citire la iesirea din MEM catre WB
           output [31:0] READ_DATA,         // valoarea citita din memorie
           output [31:0] PC_BRANCH,         // valoarea PC dupa branch
           output PCSrc                     // semnalul de alegere pentrul muxul din IF 
           );
           
    data_memory DATA_MEMORY(clk, MEM_READ, MEM_WRITE, ADDRESS_MEM, WRITE_DATA, READ_DATA);
    and_branch AND_BRANCH(BRANCH, ZERO, PCSrc);
    
    assign ADDRESS_MEM_WB = ADDRESS_MEM;
    assign PC_BRANCH = BRANCH_SUM;
    
endmodule
