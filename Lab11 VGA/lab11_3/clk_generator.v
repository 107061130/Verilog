module clk_generator(clk1, clk, clk_1hz);
    input clk;
    output clk1;
    output reg clk_1hz;

    reg [26:0] Q;
    reg [26:0] Q_TEMP;
    reg next_1;

    always @*
        if (Q == 27'd5000000 - 1) begin 
            Q_TEMP = 27'd0;
            next_1 = ~clk_1hz;
        end
        else begin 
            Q_TEMP = Q + 1'b1;
            next_1 = clk_1hz;
        end
    
    always@(posedge clk) begin
        Q <= Q_TEMP;
        clk_1hz <= next_1;
    end
    assign clk1 = Q[1];   
 
endmodule