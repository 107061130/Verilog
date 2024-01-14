module FSM_pause_start(in, rst_n, count_en, set, in2, stop, clk);
    input set;
    input in;
    input rst_n;
    input in2;
    input clk;
    output reg count_en;
    output reg stop;
    reg [1:0]state;
    reg [1:0]next_state;
    
        
        always @*
            case (state)
                2'b00:
                if (in) begin
                    next_state = 2'b01;
                    count_en = 1'b1;
                    stop = 1'b0;
                end
                else if (~in && in2) begin
                    next_state = 2'b10;
                    count_en = 1'b0;
                    stop = 1'b1;
                end
                else begin
                    next_state = 1'b0;
                    count_en = 1'b0;
                    stop = 1'b0;
                end
                2'b01:
                    if (in) begin
                        next_state = 2'b00;
                        count_en = 1'b0;
                        stop = 1'b0;
                    end
                    else if (~in && in2) begin
                        next_state = 2'b10;
                        count_en = 1'b0;
                        stop = 1'b1;
                    end
                    else begin
                        next_state = 2'b01;
                        count_en = 1'b1;
                        stop = 1'b0;
                    end
                2'b10:
                    if (in2) begin
                        next_state = 2'b01;
                        count_en = 1'b1;
                        stop = 1'b0;
                    end
                    else begin
                        next_state = 2'b10;
                        count_en = 1'b1;
                        stop = 1'b1;
                    end
                default:
                    begin
                        next_state = 1'b0;
                        count_en = 1'b0;
                        stop = 1'b0;
                    end
            endcase

        
    always@(posedge clk or negedge rst_n)
        if (~rst_n) state <= 2'b00;
        else state <= next_state;
         
endmodule