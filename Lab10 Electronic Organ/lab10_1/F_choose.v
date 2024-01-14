module F_choose(clk, rst_n, DIV);
    input clk;
    input rst_n;
    output reg [22:0]DIV;
    
    reg [3:0]count;
    reg [3:0]count_temp;
    
    always@*
        if (count == 4'd13) count_temp = 4'd0;
        else count_temp = count + 1'b1;

     always@(posedge clk or negedge rst_n)
        if (~rst_n) count <= 4'd0;
        else count <= count_temp;
    
    always@*
        case(count)
            4'd0: DIV = 22'd191570;
            4'd1: DIV = 22'd170241;
            4'd2: DIV = 22'd151699;
            4'd3: DIV = 22'd143266;
            4'd4: DIV = 22'd127551;
            4'd5: DIV = 22'd113636;
            4'd6: DIV = 22'd101214;
            4'd7: DIV = 22'd95419;
            4'd8: DIV = 22'd85034;
            4'd9: DIV = 22'd75757;
            4'd10: DIV = 22'd71633;
            4'd11: DIV = 22'd63755;
            4'd12: DIV = 22'd56818;
            4'd13: DIV = 22'd50607;
            default: DIV = 22'd0;
        endcase
endmodule