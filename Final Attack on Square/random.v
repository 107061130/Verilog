module random(clk, rst, position);
    input clk;
    input rst;
    output [11:0]position;
    
    reg [11:0]Q;
    reg [11:0]Q_TEMP;
    

    always@* Q_TEMP = Q*2 + (Q[1]^Q[6]^Q[7]^Q[8]^Q[12]);
        
    always@(posedge clk or posedge rst)
        if (rst) Q <= 12'b010110110101;
        else Q <= Q_TEMP;
                
    assign position = Q;
        
endmodule