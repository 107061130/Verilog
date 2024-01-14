module random(clk, num, rst, en);
    input clk;
    input rst;
    input en;
    output [2:0]num;
    
    reg [8:0]Q;
    reg [8:0]Q_TEMP;
    
    always@*
        if (en)Q_TEMP = Q*2 + (Q[1]^Q[6]^Q[7]^Q[8]);
        else Q_TEMP = Q;
        
    always@(posedge clk or posedge rst)
        if (rst) Q <= 9'b110110101;
        else Q <= Q_TEMP;
                
    assign num = Q[2:0] % 7;
        
endmodule