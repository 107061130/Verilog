`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 19:37:18
// Design Name: 
// Module Name: lab01_1-2
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


module lab01_2(
    input [3:0]a,
    input [3:0]b, 
    input cin,
    output cout,
    output [3:0]s
    );
    reg cout;
    reg [3:0]s;

    always @* begin
        if (a + b + cin > 9) begin
            cout = 1;
            s = a + b + cin + 6;
        end
        else begin
            cout = 0;
            s = a + b + cin;
        end
    end
endmodule