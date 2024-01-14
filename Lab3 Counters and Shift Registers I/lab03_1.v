`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/05 16:27:59
// Design Name: 
// Module Name: fcounter
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


module fd(clk, rst_n, clk_out);
    reg [26:0]q;
    input clk;
    input rst_n;
    output clk_out;
        
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) q <= 0;
        else q <= q + 1;
    end
    assign clk_out = q[26];
    
endmodule
