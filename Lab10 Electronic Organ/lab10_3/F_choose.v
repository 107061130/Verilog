module F_choose(last_change, key_down, clk, rst_n, f, f2, double);
    input clk;
    input rst_n;
    input [8:0]last_change;
    input [511:0]key_down;
    input double;
    output reg [21:0]f;
    output reg [21:0]f2;
    reg [21:0]f_temp;
    reg [21:0]f2_temp;
    
    always@*
        case (last_change)
            9'h021: begin
                f_temp = 22'd191570;
                if (double) f2_temp = 22'd151699;
                else f2_temp = f;              
            end
            9'h023: begin
                f_temp = 22'd170241;
                if (double) f2_temp = 22'd143266;
                else f2_temp = f;
            end
            9'h024: begin
                f_temp = 22'd151699;
                if (double) f2_temp = 22'd127551;
                else f2_temp = f;
            end
            9'h02B: begin
                f_temp = 22'd143266;
                if (double) f2_temp = 22'd113636;
                else f2_temp = f;
            end
            9'h034: begin
                f_temp = 22'd127551;
                if (double) f2_temp = 22'd101214;
                else f2_temp = f;
            end
            9'h01C: begin
                f_temp = 22'd113636;
                f2_temp = f;
            end
            9'h032: begin
                f_temp = 22'd101214;
                f2_temp = f;
            end
            default: begin
                f_temp = 22'd0;
                f2_temp = 22'd0;
            end
        endcase
 
        always@(posedge clk or negedge rst_n)
            if (~rst_n) begin
                f <= 22'd0;
                f2 <= 22'd0;  
            end
            else begin
                f <= f_temp;
                f2 <= f2_temp;
            end

endmodule