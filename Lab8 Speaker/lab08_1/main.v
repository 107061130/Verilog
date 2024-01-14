module main(clk, rst_n, audio_mclk, audio_lrck, audio_sck, audio_sdin, audio_in_left, audio_in_right);
    input clk; 
    input rst_n; 
    input [15:0]audio_in_left;
    input [15:0]audio_in_right;
    output audio_mclk; 
    output audio_lrck; 
    output audio_sck; 
    output audio_sdin;
    
    speaker U0(.clk(clk), .rst_n(rst_n), .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck), .audio_sdin(audio_sdin), .audio_in_right(audio_in_right), .audio_in_left(audio_in_left));
endmodule 