`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/25 23:20:41
// Design Name: 
// Module Name: LAB02_2
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


module LAB02_2(i, D_ssd, light, d);
    input [3:0]i;
    output [7:0]D_ssd;
    output [3:0]light;
    output [3:0]d;
    
    
    display U0(i, D_ssd);
    
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

module display(in, segs);
    input [3:0]in;
    output reg [7:0]segs;
    
    always @*
        case (in)
        4'd0: segs = `SS_0;
        4'd1: segs = `SS_1;
        4'd2: segs = `SS_2;
        4'd3: segs = `SS_3;
        4'd4: segs = `SS_4;
        4'd5: segs = `SS_5;
        4'd6: segs = `SS_6;
        4'd7: segs = `SS_7;
        4'd8: segs = `SS_8;
        4'd9: segs = `SS_9;
        default: segs = 8'b01110001;
     endcase
endmodule