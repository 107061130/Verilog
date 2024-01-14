module clk_generator(clk, clk_100hz);
    input clk;
    output reg clk_100hz; 

    reg next_100;
    reg [18:0]K;
    reg [18:0]K_TEMP;
    
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
        clk_100hz <= next_100;
    end
         
endmodule