module FSM(clk, rst_n, key_valid, key_down, last_change, value1, value2, value3);
    input clk;
    input rst_n;
    input key_valid;
    input [511:0]key_down;
    input [8:0]last_change;
    output reg [6:0]value1;
    output reg [3:0]value2;
    output reg [6:0]value3;
    
    reg [6:0]value1_temp;
    reg [3:0]value2_temp;
    reg [6:0]value3_temp;
    reg [1:0]state;
    reg [1:0]next_state;
    
    always@*
        case(state)
            2'b00: begin
                if (key_valid & key_down[9'h079]) begin
                    value1_temp = value1;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    next_state = 2'b01;
                end
                else if (key_valid) begin
                    case(last_change)
                        9'h70: value1_temp =4'd0;
                        9'h69: value1_temp =4'd1; 
                        9'h72: value1_temp =4'd2;
                        9'h7A: value1_temp =4'd3;
                        9'h6B: value1_temp =4'd4;
                        9'h73: value1_temp =4'd5;
                        9'h74: value1_temp =4'd6;
                        9'h6C: value1_temp =4'd7;
                        9'h75: value1_temp =4'd8;
                        9'h7D: value1_temp =4'd9;
                        default: value1_temp =value1;                       
                    endcase
                    next_state = 2'b00;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                end
                else begin
                    value1_temp = value1;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    next_state = 2'b00;
                end
            end
            2'b01: begin
                if (key_valid & key_down[9'h05A]) begin
                    value1_temp = value1;
                    value2_temp = value2;
                    value3_temp = value1 + value2;
                    next_state = 2'b10;
                end
                else if (key_valid) begin
                    case(last_change)
                        9'h70: value2_temp =4'd0;
                        9'h69: value2_temp =4'd1; 
                        9'h72: value2_temp =4'd2;
                        9'h7A: value2_temp =4'd3;
                        9'h6B: value2_temp =4'd4;
                        9'h73: value2_temp =4'd5;
                        9'h74: value2_temp =4'd6;
                        9'h6C: value2_temp =4'd7;
                        9'h75: value2_temp =4'd8;
                        9'h7D: value2_temp =4'd9;
                        default: value2_temp =value2;                       
                    endcase
                    value1_temp = value1;
                    value3_temp = 4'd0;
                    next_state = 2'b01;
                end
                else begin
                    value1_temp = value1;
                    value2_temp = value2;
                    value3_temp = 4'd0;
                    next_state = 2'b01;
                end
            end
            2'b10: begin
                if (key_valid && key_down[9'h079]) begin
                    value1_temp = value3;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    next_state = 2'b01;
                end
                else if (key_valid && key_down[9'h05A]) begin
                    value1_temp = 4'd0;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    next_state = 2'b00;
                end
                else begin
                    value1_temp = value1;
                    value2_temp = value2;
                    value3_temp = value3;
                    next_state = 2'b10;
                end
            end
            default: begin
                value1_temp = 4'd0;
                value2_temp = 4'd0;
                value3_temp = 4'd0;
                next_state = 2'b00;
            end
        endcase
        
        always@(posedge clk or negedge rst_n)
            if (~rst_n) begin
                state <= 2'b00;
                value1 <= 4'd0;
                value2 <= 4'd0;
                value3 <= 4'd0;
            end
            else begin
                state <= next_state;
                value1 = value1_temp;
                value2 <= value2_temp;
                value3 <= value3_temp;
            end            
endmodule