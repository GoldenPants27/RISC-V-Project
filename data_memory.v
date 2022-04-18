`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2022 10:38:50 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,                   
                   input mem_read,              // semnal de activare a citirii din memorie
                   input mem_write,             // semnal de activare a scrierii in memorie
                   input [31:0] address,        // adresa de scriere/citire
                   input [31:0] write_data,     // valoarea scrisa in memorie
                   output reg [31:0] read_data  // valoarea citita din memorie
                   );

    reg [31:0] data_mem [0:1023];
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            data_mem[i] = 32'b0;
        end
    end
     
    always @(posedge clk) begin                 // scrierea sincrona
        if (mem_write) begin
            data_mem[address / 4] = write_data;
        end
    end
    
    always @(posedge mem_read) begin            // citirea asincrona
        read_data = data_mem[address / 4];
    end
    
endmodule
