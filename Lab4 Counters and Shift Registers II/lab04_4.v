module main(clk, rst, light, ssd);
    input clk;
    input rst;
    output [3:0]light;
    output [7:0]ssd;
   
    wire enable;
    wire [3:0]value0;
    wire [3:0]value1;
    wire clk_d;
    wire clk_scan;
    wire [1:0]borrow;
    wire [3:0]num;
    
    FD U0(.clk(clk), .rst(rst), .clk_out(clk_d), .clk_out2(clk_scan));
    STOP U3(.in1(value1), .in2(value0), .out(enable));
    BCD_DOWN digit1(.limit(4'b0000), .clk(clk_d), .rst(rst), .decrease(enable), .q(value0), .borrow(borrow[0]));
    BCD_DOWN digit2(.limit(4'b0011), .clk(clk_d), .rst(rst), .decrease(borrow[0]), .q(value1), .borrow(borrow[1]));
    SCAN U1(.control(clk_scan), .rst(rst), .in0(value0), .in1(value1), .light(light), .out(num));
    DEC U2(.in(num), .out(ssd));

endmodule

module FD(clk, rst, clk_out, clk_out2);
    input clk;
    input rst;
    output reg clk_out = 0;
    output clk_out2;
    reg s;

    reg [26:0]Q;
    reg [26:0]Q_temp;
    
    always @*
        Q_temp = Q + 1'b1;
    always @(posedge clk or negedge rst) 
        if (~rst || s == 1) Q <= 27'd0;
        else Q <= Q_temp;
    
    always @(posedge clk or negedge rst)
        if (~rst)
            clk_out <= 0;
        else
            clk_out <= clk_out ^ s;
    
    always @* 
        if (Q == 27'd50000000 - 1) begin
            s = 1;         
        end
        else begin 
            s = 0;
        end
    assign clk_out2 = Q[14];
endmodule

module BCD_DOWN(limit, clk, rst, decrease, q, borrow);
    input [3:0]limit;
    input clk;
    input rst;
    input decrease;
    output reg [3:0]q;
    output reg borrow;
    reg [3:0]q_temp;

    always @*
        if (q == 4'b0000 && decrease == 1) begin
            q_temp = 4'b1001;
            borrow = 1'b1;
        end
        else if (q != 4'b0000 && decrease == 1) begin
            q_temp = q - 1'b1;
            borrow = 1'b0;
        end
        else begin
            q_temp = q;
            borrow = 1'b0;
        end
            
    always @(posedge clk or negedge rst)
        if (~rst) q <= limit;
        else q <= q_temp;
endmodule

module SCAN(control, rst, in0, in1, light, out);
    input control;
    input rst;
    input [3:0]in0;
    input [3:0]in1;
    output reg [3:0]light;
    output reg [3:0]out;
    
    always @*
        if (control == 1'b0) begin
            light = 4'b1110;
            out = in0;
        end
        else begin
            light = 4'b1101;
            out = in1;
        end
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

module STOP(in1, in2, out);
    input [3:0]in1;
    input [3:0]in2;
    output reg out;
    
    always @*
        if (in1 == 4'b0000 && in2 == 4'b0000) out = 0;
        else out = 1;
endmodule
