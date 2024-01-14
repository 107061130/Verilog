module clk_generator(clk, clk_scan);
    input clk;
    output reg [1:0]clk_scan;

    reg [26:0]Q;
    reg [26:0]Q_TEMP;
    
    always @*
        if (Q == 27'd50000000 - 1) 
            Q_TEMP = 27'd0;
        else 
            Q_TEMP = Q + 1'b1;

    always@(posedge clk) begin
        Q <= Q_TEMP; 
        clk_scan <= {Q[15], Q[14]};
    end
         
endmodule