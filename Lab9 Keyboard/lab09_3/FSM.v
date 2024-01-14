module FSM(clk, rst_n, press, key_down, last_change, value1, value2, value3, state, neg);
    input clk;
    input rst_n;
    input press;
    input [511:0]key_down;
    input [8:0]last_change;
    output reg [13:0]value1;
    output reg [6:0]value2;
    output reg [13:0]value3;
    output reg [1:0]state;
    output reg neg;
    
    reg [13:0]value1_temp;
    reg [6:0]value2_temp;
    reg [13:0]value3_temp;
    reg [1:0]next_state;
    reg [1:0]count;
    reg [1:0]count_next;
    reg [1:0]ASD;
    reg [1:0]ASD_TEMP;
    reg neg_temp;
    
    always@*
        case(state)
            2'b00: begin
                if (press && (key_down[9'h079] || key_down[9'h07B] || key_down[9'h07C])) begin
                    value1_temp = value1;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    next_state = 2'b01;
                    if (key_down[9'h079])  ASD_TEMP = 2'd0;
                    else if (key_down[9'h07B]) ASD_TEMP = 2'd1;
                    else ASD_TEMP = 2'd2;
                    count_next = 2'b00;
                    neg_temp = neg;
                end
                else if (press && count == 0) begin
                    case(last_change)
                        9'h70: value1_temp = 4'd0;
                        9'h69: value1_temp = 4'd1; 
                        9'h72: value1_temp = 4'd2;
                        9'h7A: value1_temp = 4'd3;
                        9'h6B: value1_temp = 4'd4;
                        9'h73: value1_temp = 4'd5;
                        9'h74: value1_temp = 4'd6;
                        9'h6C: value1_temp = 4'd7;
                        9'h75: value1_temp = 4'd8;
                        9'h7D: value1_temp = 4'd9;
                        default: value1_temp =value1;                       
                    endcase
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    count_next = 2'd2;
                    ASD_TEMP = ASD;
                    neg_temp = neg;
                    next_state = 2'b00;
                end
                else if (press && count == 2'd2) begin
                    case(last_change)
                        9'h70: value1_temp = 4'd10*value1 + 4'd0;
                        9'h69: value1_temp = 4'd10*value1 + 4'd1; 
                        9'h72: value1_temp = 4'd10*value1 + 4'd2;
                        9'h7A: value1_temp = 4'd10*value1 + 4'd3;
                        9'h6B: value1_temp = 4'd10*value1 + 4'd4;
                        9'h73: value1_temp = 4'd10*value1 + 4'd5;
                        9'h74: value1_temp = 4'd10*value1 + 4'd6;
                        9'h6C: value1_temp = 4'd10*value1 + 4'd7;
                        9'h75: value1_temp = 4'd10*value1 + 4'd8;
                        9'h7D: value1_temp = 4'd10*value1 + 4'd9;
                        default: value1_temp =value1;                       
                    endcase
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    count_next = 1'b0;
                    ASD_TEMP = ASD;
                    neg_temp = neg;
                    next_state = 2'b00;
                end
                else begin
                    value1_temp = value1;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    count_next = count;
                    ASD_TEMP = ASD;
                    neg_temp = neg;
                    next_state = 2'b00;
                end
            end
            2'b01: begin
                if (press && key_down[9'h05A]) begin
                    value1_temp = value1;
                    value2_temp = value2;
                    if (ASD == 0) begin
                        value3_temp = value1 + value2;
                        neg_temp = neg;
                    end
                    else if (ASD == 1) begin
                        if (value1 < value2) begin
                            value3_temp = value2 - value1;
                            neg_temp = ~neg;
                        end
                        else begin
                            value3_temp = value1 - value2;
                            neg_temp = neg;
                        end
                    end
                    else begin
                        value3_temp = value1 * value2;
                        neg_temp = neg;
                    end
                    count_next = 2'd0;
                    ASD_TEMP = ASD;
                    next_state = 2'b10;
                end
                else if (press && count == 0) begin
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
                    count_next = 1'd1;
                    ASD_TEMP = ASD;
                    neg_temp = neg;
                    next_state = 2'b01;
                end
                else if (press && count == 1) begin
                    case(last_change)
                        9'h70: value2_temp = 4'd10*value2 + 4'd0;
                        9'h69: value2_temp = 4'd10*value2 + 4'd1; 
                        9'h72: value2_temp = 4'd10*value2 + 4'd2;
                        9'h7A: value2_temp = 4'd10*value2 + 4'd3;
                        9'h6B: value2_temp = 4'd10*value2 + 4'd4;
                        9'h73: value2_temp = 4'd10*value2 + 4'd5;
                        9'h74: value2_temp = 4'd10*value2 + 4'd6;
                        9'h6C: value2_temp = 4'd10*value2 + 4'd7;
                        9'h75: value2_temp = 4'd10*value2 + 4'd8;
                        9'h7D: value2_temp = 4'd10*value2 + 4'd9;
                        default: value2_temp =value2;                       
                    endcase
                    value1_temp = value1;
                    value3_temp = 4'd0;
                    count_next = 1'b0;
                    ASD_TEMP = ASD;
                    neg_temp = neg;
                    next_state = 2'b01;
                end
                else begin
                    value1_temp = value1;
                    value2_temp = value2;
                    value3_temp = 4'd0;
                    count_next = count;
                    ASD_TEMP = ASD;
                    neg_temp = neg;
                    next_state = 2'b01;
                end
            end
            2'b10:
                if (press & key_down[9'h05A]) begin
                    value1_temp = 4'd0;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    ASD_TEMP = ASD;
                    count_next = 2'b0;
                    neg_temp = 1'b0;
                    next_state = 2'b00;
                end
                else if (press & (key_down[9'h079] || key_down[9'h07B] || key_down[9'h07C])) begin
                    value1_temp = value3;
                    value2_temp = 4'd0;
                    value3_temp = 4'd0;
                    if (key_down[9'h079])
                        if (neg) ASD_TEMP = 2'd1;
                        else ASD_TEMP = 2'd0;
                    else if (key_down[9'h07B]) 
                        if (neg) ASD_TEMP = 2'd0;
                        else ASD_TEMP = 2'd1;
                    else ASD_TEMP = 2'd2;              
                    count_next = 2'b0;
                    neg_temp = neg;
                    next_state = 2'b01;
                end
                else begin
                    value1_temp = 4'd0;
                    value2_temp = 4'd0;
                    value3_temp = value3;
                    ASD_TEMP = ASD;
                    count_next = 2'b0;
                    neg_temp = neg;
                    next_state = 2'b10;
                end
            default: begin
                value1_temp = 4'd0;
                value2_temp = 4'd0;
                value3_temp = 4'd0;
                ASD_TEMP = ASD;
                count_next = 0;
                neg_temp = 1'b0;
                next_state = 2'b00;
            end
        endcase
        
        always@(posedge clk or negedge rst_n)
            if (~rst_n) begin
                state <= 2'b00;
                value1 <= 4'd0;
                value2 <= 4'd0;
                value3 <= 4'd0;
                count <= 0;
                ASD <= 0;
                neg <= 0;
            end
            else begin
                state <= next_state;
                value1 <= value1_temp;
                value2 <= value2_temp;
                value3 <= value3_temp;
                count <= count_next;
                ASD <= ASD_TEMP;
                neg <= neg_temp;
            end            
endmodule