module RGB(in,rst,clk,count);
    input in;
    input rst;
    input clk;
    output reg [3:0] count;
    reg [3:0]count_tmp;

    always@*
        if(in)
            count_tmp = count + 1;
        else
            count_tmp = count;

    always@(posedge clk or posedge rst)
        if(rst)
            count <= 4'hF;
        else
            count <= count_tmp;

endmodule
