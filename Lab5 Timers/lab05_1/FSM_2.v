module FSM2(in, clk, rst_n, count_enable);
    input in;
    input clk;
    input rst_n;
    output reg count_enable;
    reg next_state;
    reg current_state;
    
    always @*
        case (current_state)
            1'b0:
            if (in)
            begin
                next_state = 1'b1;
                count_enable = 1'b1;
            end
            else
            begin
                next_state = 1'b0;
                count_enable = 1'b0;
            end
            1'b1:
                if (in)
                begin
                    next_state = 1'b0;
                    count_enable = 1'b0;
                end
                else
                begin
                    next_state = 1'b1;
                    count_enable = 1'b1;
                end
            default:
                begin
                    next_state = 1'b0;
                    count_enable = 1'b0;
                end
        endcase

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        current_state <= 1'b0;
    else
        current_state <= next_state;
endmodule