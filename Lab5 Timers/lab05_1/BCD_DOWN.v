module BCD_DOWN(limit, clk, rst_n, decrease, q, borrow);
    input [3:0]limit;
    input clk;
    input rst_n;
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
            
    always @(posedge clk or posedge rst_n)
        if (~rst_n) q <= limit;
        else q <= q_temp; 
        
endmodule