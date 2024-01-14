module counter(clk_1hz, rst, LOSE, sec);
    input clk_1hz;
    input rst;
    input LOSE;
    output reg [10:0]sec;
    reg [10:0]sec_temp;
    
    always@*
        if (LOSE) sec_temp = 0;
        else sec_temp = sec +1;
    always@(posedge clk_1hz or posedge rst)
        if (rst) sec <= 0;
        else sec <= sec_temp;
        
endmodule
