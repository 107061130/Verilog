`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/23 22:48:17
// Design Name: 
// Module Name: smux
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


module smux(
    input x,
    input y,
    input cin,
    output cout,
    output s
    );
    
    assign s = cin ^ (x ^ y);
    assign cout = cin & (x ^ y) | (x & y);
    
endmodule
