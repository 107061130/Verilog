module FSM_lap_SET(in, rst_n, lap, in2, SET, clk);
    input in;
    input rst_n;
    input in2;
    input clk;
    output reg lap;
    output reg SET;
    reg [1:0]state;
    reg [1:0]next_state;
    
    always @*
        case (state)
            2'b00:
                if (in2) begin
                    next_state = 2'b10;
                    lap = 1'b0;
                    SET = 1'b1;
                end
                else if (in) begin
                    next_state = 2'b01;
                    lap = 1'b1;
                    SET = 1'b0;
                end
                else begin
                    next_state = 1'b0;
                    lap = 1'b0;
                    SET = 1'b0;
                end
            2'b01:
                if (in2) begin
                    next_state = 2'b10;
                    lap = 1'b0;
                    SET = 1'b1;
                end
                else if (in) begin
                    next_state = 2'b00;
                    lap = 1'b0;
                    SET = 1'b0;
                end
                else begin
                   next_state = 2'b01;
                   lap = 1'b1;
                   SET = 1'b0;
                end
            2'b10:
                if (in2) begin
                    next_state = 2'b00;
                    lap = 1'b0;
                    SET = 1'b0;
                end
                else begin
                    next_state = 2'b10;
                    lap = 1'b0;
                    SET = 1'b1;
                end
            default:
                begin
                    next_state = 1'b0;
                    lap = 1'b0;
                    SET = 1'b0;
                end
        endcase

        
    always@(posedge clk or negedge rst_n)
        if (~rst_n) state <= 2'b00;
        else state <= next_state;
         
endmodule