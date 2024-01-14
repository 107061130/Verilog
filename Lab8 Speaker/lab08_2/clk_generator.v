module clk_generator(clk, clk_1hz, clk_100hz, clk_scan);
    input clk;
    output reg clk_1hz;
    output reg clk_100hz;
    output reg [1:0]clk_scan;
    
    reg next_1;
    reg next_100;
    reg [26:0]Q;
    reg [26:0]Q_TEMP;
    reg [18:0]K;
    reg [18:0]K_TEMP;
    
    
    always @*
        if (Q == 27'd10000000 - 1) begin 
            Q_TEMP = 27'd0;
            next_1 = ~clk_1hz;
        end
        else begin 
            Q_TEMP = Q + 1'b1;
            next_1 = clk_1hz;
        end

    always @*
        if (K == 19'd500000 - 1) begin 
            K_TEMP = 19'd0;
            next_100 = ~clk_100hz;
        end
        else begin 
            K_TEMP = K + 1'b1;
            next_100 = clk_100hz;
        end 
    always@(posedge clk) begin 
            K <= K_TEMP;
            Q <= Q_TEMP;
            clk_1hz <= next_1;
            clk_100hz <= next_100;
            clk_scan <= {Q[15], Q[14]};
    end
         
endmodule