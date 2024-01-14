module fshifter(q, clk, rst_n);
    output reg [7:0]q;
    input clk;
    input rst_n;;
    wire clk_d;
    
    FD U0(clk, rst_n, clk_d);
    
    always @(posedge clk_d or negedge rst_n)
        if (~rst_n) 
            q <= 8'b01010101; 
        else begin
              q[0] <= q[7];
              q[1] <= q[0];
              q[2] <= q[1];
              q[3] <= q[2];
              q[4] <= q[3];
              q[5] <= q[4];
              q[6] <= q[5];
              q[7] <= q[6];
        end         
    
endmodule

module FD(CLK, RST_N, CLK_OUT);
    input CLK;
    input RST_N;
    output reg CLK_OUT;
    reg s;

    reg [26:0]Q;
    reg [26:0]Q_temp;
    
    always @*
        Q_temp = Q + 1'b1;
    always @(posedge CLK or negedge RST_N) 
        if (~RST_N || s == 1) Q <= 27'd0;
        else Q <= Q_temp;
    
    always @* 
        if (Q == 27'd50000000)
            s = 1;         
        else 
            s = 0;
        
     always @(posedge CLK or negedge RST_N)
           if (~RST_N)
               CLK_OUT <= 0;
           else
               CLK_OUT <= CLK_OUT ^ s;

endmodule
