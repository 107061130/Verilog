module UP_DOWN(clk, rst_n, add, decrease, q);
    input clk;
    input rst_n;
    input add;
    input decrease;
    output reg [3:0]q;
    reg [3:0]q_temp;

    always @*
        if (q != 4'd15 && add) q_temp = q + 1'b1;
        else if (q != 4'd0 && decrease) q_temp = q - 1'b1;
        else q_temp = q;
        
            
    always @(posedge clk or negedge rst_n)
        if (~rst_n) q <= 4'd0;
        else q <= q_temp;
        
endmodule