module clk_generator(clk, clk_1hz, rst_n);
    input clk;
    input rst_n;
    output reg clk_1hz;
    
    reg next_1;
    reg [26:0]Q;
    reg [26:0]Q_TEMP;
     
    always @*
        if (Q == 27'd50000000 - 1) begin 
            Q_TEMP = 27'd0;
            next_1 = ~clk_1hz;
        end
        else begin 
            Q_TEMP = Q + 1'b1;
            next_1 = clk_1hz;
        end

    always@(posedge clk or negedge rst_n) begin 
        if (~rst_n) begin
            Q <= 0;
            clk_1hz <= 0;
        end
        else begin
            Q <= Q_TEMP;
            clk_1hz <= next_1;
        end
    end
         
endmodule