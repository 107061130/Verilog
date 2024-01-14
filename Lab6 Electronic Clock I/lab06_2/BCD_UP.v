module BCD_UP(limit, clk, rst_h, add, q, borrow, RETURN, INITIAL);
    input INITIAL;
    input [6:0]limit;
    input clk;
    input rst_h;
    input add;
    input [3:0]RETURN;
    output reg [6:0]q;
    output reg borrow;
    reg [6:0]q_temp;
    reg [6:0]LIMIT;
    
    always @*
        case(RETURN)
            4'd2: LIMIT = limit - 4'd3;
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