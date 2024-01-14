module top(clk, rst_n, , mclk, lrck, sck, sdin);
    input clk;
    input rst_n;
    output mclk;
    output lrck;
    output sck;
    output sdin;
    
    wire [22:0]DIV;
    wire [15:0]audio_in_left;
    wire [15:0]audio_in_right;
    
    clk_generator U0(.clk(clk), .clk_1hz(clk_1hz), .rst_n(rst_n));
    F_choose U1(.clk(clk_1hz), .rst_n(rst_n), .DIV(DIV));
    buzzer U2(.clk(clk), .rst_n(rst_n), .note_div(DIV), .audio_left(audio_in_left), .audio_right(audio_in_right));
    speaker U3(.clk(clk), .rst_n(rst_n), .audio_mclk(mclk), .audio_lrck(lrck), .audio_sck(sck), .audio_sdin(sdin), .audio_in_left(audio_in_left), .audio_in_right(audio_in_right));
    
endmodule