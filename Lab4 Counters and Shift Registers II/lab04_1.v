module main(clk, rst, b);
    input clk;
    input rst;
    output [3:0]b;
    wire clk_d;
    
    fd U0(.clk(clk), .rst(rst), .clk_out(clk_d));
    counter U1(.clk(clk_d), .rst(rst), .out(b));
    
endmodule

module fd(clk, rst, clk_out);
    input clk;
    input rst;
    output reg clk_out;
    reg s;
    reg [26:0]q;

    always@(posedge clk or negedge rst)
        if (~rst || s == 1) q <= 0;
        else q <= q + 1;
    
    always @* 
        if (q == 27'd50000000) s = 1;         
        else s = 0;
    
    always@(posedge clk or negedge rst)
        if (~rst) clk_out <= 0;
        else clk_out <= clk_out ^ s;
    
endmodule

module counter(clk, rst, out);
    input clk;
    input rst;
    output reg [3:0]out;
    
    always@(posedge clk or negedge rst)
        if (~rst) out <= 0;
        else out = out + 1;
endmodule