module SEPERATE(in, en, fish, num, clk, rst_n, div, next);
    input clk;
    input rst_n;
    input [13:0]in;
    input en;
    input [9:0]div;
    output reg[13:0]fish;
    output [3:0]num;
    output reg next;
    
    reg [13:0]value;
    reg [13:0]value_next;
    reg [3:0]count;
    reg [3:0]count_next;
    reg [13:0]fish_next;
    
    initial value = in;
    
    always@*
        if (value > div && en) begin
            value_next = value - div;
            fish_next = 0;
            count_next = count + 1'b1;
            next = 1'b0;
        end
        else begin
            value_next = value;
            fish_next = value;
            count_next = count;
            next = 1'b1;
        end
        
        always@(posedge clk or negedge rst_n)
            if (~rst_n) begin
                value = in;
                fish = 0;
                count = 0;
            end
            else begin
                value = value_next;
                fish = fish_next;
                count = next;
            end
endmodule