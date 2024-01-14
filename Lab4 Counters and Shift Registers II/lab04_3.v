module main(clk, rst, light, ssd);
    input clk;
    input rst;
    output [3:0]light;
    output [7:0]ssd;
    wire [3:0]value;
    wire clk_d;
    
    fd U0(.clk(clk), .rst(rst), .clk_out(clk_d));
    BCD_DOWN U1(.clk(clk_d), .rst(rst), .q(value));
    DEC U2(.in(value), .out(ssd));
    assign light = 4'b1110;
    
endmodule

module fd(clk, rst, clk_out);
    reg [26:0]q;
    input clk;
    input rst;
    output clk_out;
        
    always @(posedge clk or negedge rst) 
        if (~rst) q <= 0;
        else q <= q + 1'b1;
    
    assign clk_out = q[26];
    
endmodule

module BCD_DOWN(clk, rst, q);
    input clk;
    input rst;
    output reg [3:0]q;
    reg [3:0]q_temp;
    
    always @*
        if (q == 4'b0000) q_temp = 4'b1001;
        else q_temp = q - 1'b1;
        
    always @(posedge clk or negedge rst)
        if (~rst) q <= 4'b0000;
        else q <= q_temp;
    
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

module DEC(in, out);
    input [3:0]in;
    output reg [7:0]out;
    
    always @*
        case(in)
        4'd0: out = `SS_0;
        4'd1: out = `SS_1;
        4'd2: out = `SS_2;
        4'd3: out = `SS_3;
        4'd4: out = `SS_4;
        4'd5: out = `SS_5;
        4'd6: out = `SS_6;
        4'd7: out = `SS_7;
        4'd8: out = `SS_8;
        4'd9: out = `SS_9;
        default: out = 8'b11111111;
        endcase
endmodule