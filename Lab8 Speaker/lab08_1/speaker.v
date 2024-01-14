module speaker(clk, rst_n, audio_mclk, audio_lrck, audio_sck, audio_sdin, audio_in_left, audio_in_right);
    input clk; 
    input rst_n; 
    input [15:0]audio_in_left;
    input [15:0]audio_in_right;
    output reg audio_mclk; 
    output reg audio_lrck; 
    output reg audio_sck; 
    output reg audio_sdin; 

    reg mclk_next;
    reg lrck_next;
    reg sck_next;
    reg [8:0]L;
    reg [8:0]L_TEMP;
    reg [3:0]S;
    reg [3:0]S_TEMP;
    reg [1:0]M;
    reg [1:0]M_TEMP;
    reg [3:0]count;
    reg [3:0]count_temp;
    
    always @*
        if (L == 9'D511) begin 
            L_TEMP = 9'd0;
            lrck_next = ~audio_lrck;
        end
        else begin 
            L_TEMP = L + 1'b1;
            lrck_next = audio_lrck;
        end
    always @*
        if (S == 4'd15) begin 
            S_TEMP = 4'd0;
            sck_next = ~audio_sck;
        end
        else begin 
            S_TEMP = S + 1'b1;
            sck_next = audio_sck;
        end
                    
      always @*
            if (M == 2'd3) begin 
                M_TEMP = 2'd0;
                mclk_next = ~audio_mclk;
            end
            else begin 
                M_TEMP = M + 1'b1;
                mclk_next = ~audio_mclk;
            end
                    
     always@(posedge clk or negedge rst_n)
        if (~rst_n) begin
            S = 0;
            M = 0;
            L = 0;
            audio_mclk = 0;
            audio_lrck = 0;
            audio_sck = 0;
        end 
        else begin
            S = S_TEMP;
            M = M_TEMP;
            L = L_TEMP;
            audio_mclk = mclk_next;
            audio_lrck = lrck_next;
            audio_sck = sck_next;
        end
     
    always @*
        if (count == 4'd15)  count_temp = 4'd0;
        else count_temp = count + 1'b1;
  
     always@(negedge audio_sck or negedge rst_n)
        if (~rst_n) count = 0;
        else count = count_temp;
     
     always@*
        if (~audio_lrck)
            case(count)
                4'd0: audio_sdin = audio_in_left[0];
                4'd1: audio_sdin = audio_in_left[1];
                4'd2: audio_sdin = audio_in_left[2];
                4'd3: audio_sdin = audio_in_left[3];
                4'd4: audio_sdin = audio_in_left[4];
                4'd5: audio_sdin = audio_in_left[5];
                4'd6: audio_sdin = audio_in_left[6];
                4'd7: audio_sdin = audio_in_left[7];
                4'd8: audio_sdin = audio_in_left[8];
                4'd9: audio_sdin = audio_in_left[9];
                4'd10: audio_sdin = audio_in_left[10];
                4'd11: audio_sdin = audio_in_left[11];
                4'd12: audio_sdin = audio_in_left[12];
                4'd13: audio_sdin = audio_in_left[13];
                4'd14: audio_sdin = audio_in_left[14];
                4'd15: audio_sdin = audio_in_left[15];
                default: audio_sdin = 1'b0;
            endcase
        else
            case(count)
                4'd0: audio_sdin = audio_in_right[0];
                4'd1: audio_sdin = audio_in_right[1];
                4'd2: audio_sdin = audio_in_right[2];
                4'd3: audio_sdin = audio_in_right[3];
                4'd4: audio_sdin = audio_in_right[4];
                4'd5: audio_sdin = audio_in_right[5];
                4'd6: audio_sdin = audio_in_right[6];
                4'd7: audio_sdin = audio_in_right[7];
                4'd8: audio_sdin = audio_in_right[8];
                4'd9: audio_sdin = audio_in_right[9];
                4'd10: audio_sdin = audio_in_right[10];
                4'd11: audio_sdin = audio_in_right[11];
                4'd12: audio_sdin = audio_in_right[12];
                4'd13: audio_sdin = audio_in_right[13];
                4'd14: audio_sdin = audio_in_right[14];
                4'd15: audio_sdin = audio_in_right[15];
                default: audio_sdin = 1'b0;
            endcase

endmodule