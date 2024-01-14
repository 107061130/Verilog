module BCD_UP(limit, clk, rst_h, q,);
    input [3:0]limit;
    input clk;
    input rst_h;
    output reg [5:0]q;
    reg [5:0]q_temp;

    always @*
        if (q == limit) q_temp = 0;
        else q_temp = q + 1'b1;
            
    always @(posedge clk or posedge rst_h)
        if (rst_h) q <= 0;
        else q <= q_temp; 
        
endmodule