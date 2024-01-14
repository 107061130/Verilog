module pixel_generator(clk, clk_1hz, valid, rst, h_cnt, v_cnt, num, pixel, en);
    input clk;
    input clk_1hz;
    input rst;
    input valid;
    input [9:0]h_cnt;
    input [9:0]v_cnt;
    input [2:0]num;
    output reg [11:0]pixel;
    output reg en;
    
    wire [5:0]row;
    reg en_temp;
    reg [5:0]count;
    reg [5:0]count_temp;
    reg [11:0]pixel_temp;
    
    assign row = (num == 3'd0)? 6'd1 : 6'd2;
    
    always@*
        if (count + row == 6'd48) begin
            en_temp = 1'b1;
            count_temp = 6'd0;
        end
        else begin
            en_temp = 1'b0;
            count_temp = count + 1;
        end
    always@(posedge clk_1hz or posedge rst)
        if (rst) begin
            en <= 1'b1;
            count <= 0;
        end
        else begin
            en <= en_temp;
            count <= count_temp; 
        end
        
    always@*
        if (count + row != 6'd48 && valid) begin
            case(num)
                3'd0: begin
                    if (h_cnt >= 290 && h_cnt < 330 && v_cnt >= (row + count)*10 - 10 && v_cnt < (row + count)*10) pixel_temp = 12'hAFF;
                    else pixel_temp = 12'h0;
                end
                3'd1: begin
                    if (h_cnt >= 290 && h_cnt < 320 && v_cnt >= (row + count)*10 - 10 && v_cnt < (row + count)*10) pixel_temp = 12'h00F;
                    else if (h_cnt >= 290 && h_cnt < 300 && v_cnt >= (row + count)*10 - 20 && v_cnt < (row + count)*10 - 10) pixel_temp = 12'h00F;
                    else pixel_temp = 12'h0;
                end
                3'd2: begin
                    if (h_cnt >= 290 && h_cnt < 320 && v_cnt >= (row + count)*10 - 10 && v_cnt < (row + count)*10) pixel_temp = 12'hFA0;
                    else if (h_cnt >= 310 && h_cnt < 320 && v_cnt >= (row + count)*10 - 20 && v_cnt < (row + count)*10 - 10) pixel_temp = 12'hFA0;
                    else pixel_temp = 12'h0;
                end
                3'd3: begin
                    if (h_cnt >= 290 && h_cnt < 310 && v_cnt >= (row + count)*10 - 20 && v_cnt < (row + count)*10) pixel_temp = 12'hFF0;
                    else pixel_temp = 12'h0;
                end
                3'd4: begin
                    if (h_cnt >= 290 && h_cnt < 310 && v_cnt >= (row + count)*10 - 10 && v_cnt < (row + count)*10) pixel_temp = 12'h0F0;
                    else if (h_cnt >= 300 && h_cnt < 320 && v_cnt >= (row + count)*10 - 20 && v_cnt < (row + count)*10 - 10) pixel_temp= 12'h0F0;
                    else pixel_temp = 12'h0;
                end
                3'd5: begin
                    if (h_cnt >= 290 && h_cnt < 320 && v_cnt >= (row + count)*10 - 10 && v_cnt < (row + count)*10) pixel_temp = 12'hF0F;
                    else if (h_cnt >= 300 && h_cnt < 310 && v_cnt >= (row + count)*10 - 20 && v_cnt < (row + count)*10 - 10) pixel_temp = 12'hF0F;
                    else pixel_temp = 12'h0;
                end
                3'd6: begin
                    if (h_cnt >= 300 && h_cnt < 320 && v_cnt >= (row + count)*10 - 10 && v_cnt < (row + count)*10) pixel_temp = 12'h0F0;
                    else if (h_cnt >= 290 && h_cnt < 310 && v_cnt >= (row + count)*10 - 20 && v_cnt < (row + count)*10 - 10) pixel_temp = 12'h0F0;
                    else pixel_temp = 12'h0;
                end
                default: begin
                   pixel_temp = 12'h0;
                end
            endcase
        end
        else begin
            pixel_temp = 12'h0;
        end
        
    always@(posedge clk or posedge rst)
        if (rst) pixel <= 12'h0;
        else pixel <= pixel_temp;
      
endmodule