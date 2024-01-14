`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/26 12:35:58
// Design Name: 
// Module Name: LAB02_3
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


module LAB02_3(i, D, d, light);
    input [3:0]i;
    output [7:0]D;
    output [3:0]d;
    output [3:0]light;
    
    display U0(i, D);
    assign light = 4'b0000;
    assign d = i;
endmodule

`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_10 8'b00010001
`define SS_11 8'b11000001
`define SS_12 8'b11100101
`define SS_13 8'b10000101
`define SS_14 8'b01100001
`define SS_15 8'b01110001

module display(in, DEC);
    input [3:0]in;
    output reg [7:0]DEC;
    
    always @*
    case (in)
     4'd0: DEC = `SS_0;
     4'd1: DEC = `SS_1;
     4'd2: DEC = `SS_2;
     4'd3: DEC = `SS_3;
     4'd4: DEC = `SS_4;
     4'd5: DEC = `SS_5;
     4'd6: DEC = `SS_6;
     4'd7: DEC = `SS_7;
     4'd8: DEC = `SS_8;
     4'd9: DEC = `SS_9;
     4'd10: DEC = `SS_10;
     4'd11: DEC = `SS_11;
     4'd12: DEC = `SS_12;
     4'd13: DEC = `SS_13;
     4'd14: DEC = `SS_14;
     4'd15: DEC = `SS_15;  
     default: DEC = 8'b11111111;
    
    endcase
endmodule

