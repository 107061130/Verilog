module DOWN(limit, clk, rst_n, decrease, borrow, set, value, stop, set_value);
    input [5:0]limit;
    input clk;
    input rst_n;
    input decrease;
    input set;
    input stop;
    input [5:0]set_value;
    output reg [5:0]value;
    output reg borrow;
    reg [5:0]LIMIT;
    reg [5:0]LIMIT_TEMP;
    reg [5:0]q;
    reg [5:0]q_temp;
    reg [5:0]in;
    
    always@*
        if (set) LIMIT_TEMP = set_value;
        else LIMIT_TEMP = LIMIT;
    always @(posedge clk or negedge rst_n)
        if (~rst_n) LIMIT <= 0; 
        else LIMIT = LIMIT_TEMP;
         
    always@*
        if (set) 
            q_temp = set_value;
        else begin
            if (q == 0 && decrease == 1) begin
                q_temp = limit;
                borrow = 1'b1;
            end
            else if (q != 0 && decrease == 1) begin
                q_temp = q - 1'b1;
                borrow = 1'b0;
            end
            else begin
                q_temp = q;
                borrow = 1'b0;
            end
        end

    always @(posedge clk or negedge rst_n)
        if (~rst_n) q <= 0;
        else if (stop) q <= LIMIT;
        else q <= q_temp;

    always@*
       if (set) value = set_value;
       else if (stop) value <= LIMIT;
       else value = q;
            
        
endmodule