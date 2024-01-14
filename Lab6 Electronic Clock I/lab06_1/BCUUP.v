module BCD_UP(limit, clk, rst_h, add, q, borrow);
    input [4:0]limit;
    input clk;
    input rst_h;
    input add;
    output reg [4:0]q;
    output reg borrow;
    reg [4:0]q_temp;

    always @*
        if (q == limit && add == 1) begin
            q_temp = 8'd0;
            borrow = 1'b1;
        end
        else if (q != limit && add == 1) begin
            q_temp = q + 1'b1;
            borrow = 1'b0;
        end
        else begin
            q_temp = q;
            borrow = 1'b0;
        end
            
    always @(posedge clk or posedge rst_h)
        if (rst_h) q <= 8'd0;
        else q <= q_temp;
        
endmodule