`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2022 06:46:14 PM
// Design Name: 
// Module Name: and_branch
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


module and_branch(input branch,
                  input zero,
                  output PCSrc
                  );
                  
    assign PCSrc = branch & zero;
                  
endmodule
