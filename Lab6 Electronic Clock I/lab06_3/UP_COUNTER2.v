module BCD_UP2(limit, clk, rst_h, add, q, borrow, RETURN, INITIAL, RETURN2);
    input INITIAL;
    input [7:0]limit;
    input clk;
    input rst_h;
    input add;
    input [3:0]RETURN;
    input [7:0]RETURN2;
    output reg [7:0]q;
    output reg borrow;
    reg [7:0]q_temp;
    reg [7:0]LIMIT;
    
    always @*
        case(RETURN)
            4'd2: begin
                if (RETURN2 == 8'd0) LIMIT = limit - 4'd2;
                else if (RETURN2 % 3'd4 == 0 && RETURN2 % 7'd100 != 1'd0) LIMIT = limit - 4'd2;
                else LIMIT = limit - 4'd3;
            end
            4'd4: LIMIT = limit - 4'd1;
            4'd6: LIMIT = limit - 4'd1;
            4'd9: LIMIT = limit - 4'd1;
            4'd11: LIMIT = limit - 4'd1;
            default: LIMIT = limit;
        endcase
    always @*
        if (q == LIMIT && add == 1) begin
            q_temp = INITIAL;
            borrow = 1'b1;
        end
        else if (q != LIMIT && add == 1) begin
            q_temp = q + 1'b1;
            borrow = 1'b0;
        end
        else begin
            q_temp = q;
            borrow = 1'b0;
        end
            
    always @(posedge clk or posedge rst_h)
        if (rst_h) q <= INITIAL;
        else q <= q_temp;
        
endmodule