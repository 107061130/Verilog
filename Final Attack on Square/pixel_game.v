module pixel_game(clk, clk_speed, clk_2hz, clk_10hz, clk_speed2, valid, rst, h_cnt, v_cnt, pixel, position, image_pixel, pixel_addr, left, right, LOSE, sec, tile_color, COLOR);
    input clk;
    input clk_10hz;
    input clk_speed;
    input clk_speed2;
    input clk_2hz;
    input rst;
    input valid;
    input [9:0]h_cnt;
    input [9:0]v_cnt;
    input [11:0]position;
    input [11:0]image_pixel;
    input left;
    input right;
    input [9:0]sec;
    input [11:0]tile_color;
    output reg [11:0]pixel;
    output reg [16:0]pixel_addr;
    output LOSE;
    output [11:0]COLOR;
    
    wire in;
    wire [5:0]row;
    wire [5:0]col;
    reg [143:0]board;
    reg [143:0]board_temp;
    reg [479:0]lastline;
    reg count, count_temp;
    reg gg, gg_temp;
    reg [9:0]start, start_temp;
    reg [11:0]pixel_temp;
    reg [16:0]pixel_addr_temp;
    reg [4:0]HP, HP_TEMP;
    reg [11:0]color, color_temp;
    reg bonus, bonus_temp;
    reg good, good_temp;
    
    assign COLOR = color;
    assign LOSE = gg;
    assign in = (valid && h_cnt >= 80 && h_cnt < 560 && v_cnt < 480) ? 1:0;
    assign row = (in) ? v_cnt / 40 : 0;
    assign col = (in) ? (h_cnt - 80) / 40 : 0;

    
    always@* // end & HP
        if (HP == 0) begin
            gg_temp = 1;
            HP_TEMP = HP;
        end
        else if (board[132 + (start - 80) / 40] == 1 || board[132 + (start + 20 - 80) / 40] == 1) begin
            gg_temp = gg;
            HP_TEMP = HP >> 1;
        end
        else begin 
            gg_temp = gg;
            HP_TEMP = HP;
        end
    always@(posedge clk_2hz or posedge rst or posedge good)
        if (rst || good) begin
            gg <= 12'h0;
            HP <= 5'b11111;
        end
        else begin 
            gg <= gg_temp;
            HP <= HP_TEMP;
        end
        
    always@* // bonus color
        if (sec % 30 == 29) color_temp = position;
        else color_temp = color;
    always@(posedge clk or posedge rst)
        if (rst) color = 12'hFFF;
        else color = color_temp;
    
    always@* // bonus effect
        if (sec % 30 == 29 && tile_color == color) begin
            bonus_temp = 0;
            good_temp = 1;
        end
        else if (tile_color == color) begin
            bonus_temp = 0;
            good_temp = 0;
        end
        else begin 
            bonus_temp = 1;
            good_temp = 0;
         end
    always@(posedge clk or posedge rst)
        if (rst) begin
            bonus <= 0;
            good <= 0;
        end
        else begin
            bonus <= bonus_temp;
            good <= good_temp;
        end
        
    always@* // tile move
        if (~count) begin
            count_temp = count + 1;
            if (bonus) board_temp[143:12] = board[143:12] << 13;
            else board_temp[143:12] = board[143:12] << 12;
            board_temp[11:0] = position;
        end
        else begin
            count_temp = count + 1;
            if (bonus) board_temp = board  << 13;
            else board_temp = board  << 12;
        end      
    always@(posedge clk_speed or posedge rst or posedge good)
            if (rst  || good) begin
                count <= 0;
                board <= 0; 
            end
           else begin
                count <= count_temp;
                board <= board_temp;
            end        
            
        always@* // move
            if (right && left) start_temp = start;
            else if (right && start != 539) start_temp = start + 1;
            else if (left && start != 80) start_temp = start - 1;
            else start_temp = start;   
        always@(posedge clk_speed2 or posedge rst)
            if (rst) start <= 10'd320;
            else start <= start_temp;
          
        always@* // addr
             if (h_cnt > start && h_cnt <= start + 20 && v_cnt >= 450 && v_cnt < 480) 
                if (right || left) 
                    if (clk_2hz)pixel_addr_temp = 8600 + (v_cnt - 450)*20 + (h_cnt - start);
                    else pixel_addr_temp = 9200 + (v_cnt - 450)*20;
                else pixel_addr_temp = 8000 + (v_cnt - 450)*20 + (h_cnt - start);
             else if (h_cnt > 10 && h_cnt <= 30 && v_cnt > 40 && v_cnt <= 80) pixel_addr_temp = (sec / 100)*800 + (v_cnt - 40)*20 + (h_cnt - 10);
             else if (h_cnt > 30 && h_cnt <= 50 && v_cnt > 40 && v_cnt <= 80) pixel_addr_temp = ((sec % 100) / 10)*800 + (v_cnt - 40)*20 + (h_cnt - 30);
             else if (h_cnt > 50 && h_cnt <= 70 && v_cnt > 40 && v_cnt <= 80) pixel_addr_temp = (sec % 10)*800 + (v_cnt - 40)*20 + (h_cnt - 50);
             else pixel_addr_temp = 796;
        always@(posedge clk or posedge rst)
            if (rst) pixel_addr <= 0;
            else pixel_addr <= pixel_addr_temp;
            
        always@* // pixel
            if (gg) pixel_temp = 0;
            else if (h_cnt > 10 && h_cnt <= 70 && v_cnt >= 40 && v_cnt < 80) pixel_temp = image_pixel;
            else if (h_cnt > start && h_cnt <= start + 20 && v_cnt > 450 && v_cnt <= 480) pixel_temp = image_pixel;
            else if (h_cnt > 10 && h_cnt <= 70 && v_cnt > 300 && v_cnt <= 360) pixel_temp = color;
            else if (h_cnt > 580 && h_cnt <= 620 && v_cnt > 120 && v_cnt <= 140) pixel_temp = (HP[4]) ? 12'h0F0 : 12'hF00;
            else if (h_cnt > 580 && h_cnt <= 620 && v_cnt > 145 && v_cnt <= 165) pixel_temp = (HP[3]) ? 12'h0F0 : 12'hF00;
            else if (h_cnt > 580 && h_cnt <= 620 && v_cnt > 170 && v_cnt <= 190) pixel_temp = (HP[2]) ? 12'h0F0 : 12'hF00;
            else if (h_cnt > 580 && h_cnt <= 620 && v_cnt > 195 && v_cnt <= 215) pixel_temp = (HP[1]) ? 12'h0F0 : 12'hF00;
            else if (h_cnt > 580 && h_cnt <= 620 && v_cnt > 220 && v_cnt <= 240) pixel_temp = (HP[0]) ? 12'h0F0 : 12'hF00;   
            else if (in && board[row*12 + col]) pixel_temp = tile_color;
            else pixel_temp = 0;          
         always@(posedge clk or posedge rst)
            if (rst) pixel <= 0;
            else pixel <= pixel_temp;
            
endmodule