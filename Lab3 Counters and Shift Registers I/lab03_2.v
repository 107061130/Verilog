module FD(clk, rst_n, q);
    input clk;
    input rst_n;
    output reg q = 0;
    reg s;

    reg [26:0]Q;
    reg [26:0]Q_temp;
    
    always @*
        Q_temp = Q + 1'b1;
    always @(posedge clk or negedge rst_n) 
        if (~rst_n || s == 1) Q <= 27'd0;
        else Q <= Q_temp;
    
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            q <= 0;
        else
            q <= q ^ s;
    
    always @* 
        if (Q == 27'd50000000 - 1) begin
            s = 1;         
        end
        else begin 
            s = 0;
        end
endmodule


