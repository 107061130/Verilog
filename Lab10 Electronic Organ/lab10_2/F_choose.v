module F_choose(last_change, key_down, CAP, clk, rst_n, f, num);
    input clk;
    input rst_n;
    input [8:0]last_change;
    input [511:0]key_down;
    input CAP;
    output reg [22:0]f;
    output reg [3:0]num;
    reg [22:0]f_temp;
    reg [3:0]num_temp;
    
    always@*
        if (~CAP) begin
            case (last_change)
                9'h021: begin
                    f_temp = 22'd191570;
                    num_temp = 4'd1;
                end
                9'h023: begin
                    f_temp = 22'd170241;
                    num_temp = 4'd2;
                end
                9'h024: begin
                    f_temp = 22'd151699;
                    num_temp = 4'd3;
                end
                9'h02B: begin
                    f_temp = 22'd143266;
                    num_temp = 4'd4;
                end
                9'h034: begin
                    f_temp = 22'd127551;
                    num_temp = 4'd5;
                end
                9'h01C: begin
                    f_temp = 22'd113636;
                    num_temp = 4'd6;
                end
                9'h032: begin
                    f_temp = 22'd101214;
                    num_temp = 4'd7;
                end
                9'h058: begin
                    f_temp = f;
                    num_temp = num;
                end
                default: begin
                    f_temp = 22'd0;
                    num_temp = 4'd0;
                end
            endcase
        end
        else begin
            case (last_change)
                9'h021: begin
                    f_temp = 22'd95419;
                    num_temp = 4'd8;
                end
                9'h023: begin
                    f_temp = 22'd85034;
                    num_temp = 4'd9;
                end
                9'h024: begin
                    f_temp = 22'd75757;
                    num_temp = 4'd10;
                end
                9'h02B: begin
                    f_temp = 22'd71633;
                    num_temp = 4'd11;
                end
                9'h034: begin
                    f_temp = 22'd63755;
                    num_temp = 4'd12;
                end
                9'h01C: begin
                    f_temp = 22'd56818;
                    num_temp = 4'd13;
                end
                9'h032: begin
                    f_temp = 22'd50607;
                    num_temp = 4'd14;
                end
                9'h058: begin
                    f_temp = f;
                    num_temp = num;
                end
                default: begin
                    f_temp = 22'd0;
                    num_temp = 4'd0;
                end
        endcase

        end
        
        always@(posedge clk or negedge rst_n)
            if (~rst_n || ~key_down[last_change]) begin
                f <= 7'd0;
                num <= 0;
            end
            else begin
                f <= f_temp;
                num <= num_temp;
            end

endmodule