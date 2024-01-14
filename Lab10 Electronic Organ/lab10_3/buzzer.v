module buzzer(clk, rst_n, f, f2, audio_left, audio_right);
    input clk; 
    input rst_n; 
    input [21:0]f; 
    input [21:0]f2;
    output wire [15:0]audio_left; 
    output wire [15:0]audio_right; 

    reg [21:0]clk_cnt_next;
    reg [21:0]clk_cnt;
    reg [21:0]clk_cnt2_next;
    reg [21:0]clk_cnt2;
    reg b_clk, b_clk_next;
    reg b_clk2, b_clk2_next;

    always @*
         if (clk_cnt == f) begin
            clk_cnt_next = 22'd0;
            b_clk_next = ~b_clk;
        end
        else begin
            clk_cnt_next = clk_cnt + 1'b1;
            b_clk_next = b_clk;
        end
        
        always @*
             if (clk_cnt2 == f2) begin
                clk_cnt2_next = 22'd0;
                b_clk2_next = ~b_clk2;
            end
            else begin
                clk_cnt2_next = clk_cnt2 + 1'b1;
                b_clk2_next = b_clk2;
            end    
        
        always @(posedge clk or negedge rst_n)
            if (~rst_n) begin
                clk_cnt <= 22'd0;
                b_clk <= 1'b0;
                clk_cnt2 <= 22'd0;
                b_clk2 <= 1'b0;
            end
            else begin
                clk_cnt <= clk_cnt_next;
                b_clk <= b_clk_next;
                clk_cnt2 <= clk_cnt2_next;
                b_clk2 <= b_clk2_next;
            end
          
        assign audio_left = (b_clk == 1'b0) ? 16'hFE00 : 16'h01FF;
        assign audio_right = (b_clk2 == 1'b0) ? 16'hFE00 : 16'h01FF;
    
endmodule