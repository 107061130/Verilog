module buzzer(clk, rst_n, note_div, audio_left, audio_right, amplitude);
    input clk; 
    input rst_n; 
    input [21:0]note_div; 
    input [3:0]amplitude;
    output reg [15:0]audio_left; 
    output reg [15:0]audio_right; 

    reg [21:0]clk_cnt_next;
    reg [21:0]clk_cnt;
    reg b_clk, b_clk_next;
    reg [15:0]voice;
    reg [15:0]voice_temp;
    
    always @*
         if (clk_cnt == note_div) begin
            clk_cnt_next = 22'd0;
            b_clk_next = ~b_clk;
        end
        else begin
            clk_cnt_next = clk_cnt + 1'b1;
            b_clk_next = b_clk;
        end
        
        always @(posedge clk or negedge rst_n)
            if (~rst_n) begin
                clk_cnt <= 22'd0;
                b_clk <= 1'b0;
            end
            else begin
                clk_cnt <= clk_cnt_next;
                b_clk <= b_clk_next;
            end
    
    always@* voice_temp = 16'd200 + (16'd100*amplitude);
    always@(posedge clk or negedge rst_n)
        if (~rst_n) voice <= 15'd0;
        else voice = voice_temp;
        
    always@*
        if (b_clk == 1) begin
            audio_left = voice;
            audio_right = voice;
        end
        else begin
            audio_left = ~voice;
            audio_right = ~voice;
        end
    
endmodule