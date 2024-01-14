module top(clk, rst_n, pb_do, pb_re, pb_mi, pb_add, pb_decrease, mclk, lrck, sck, sdin, ssd_ctl, D_ssd);
    input clk;
    input rst_n;
    input pb_do;
    input pb_re;
    input pb_mi;
    input pb_add;
    input pb_decrease;
    output mclk;
    output lrck;
    output sck;
    output sdin;
    output [3:0]ssd_ctl;
    output [7:0]D_ssd;
    
    wire [15:0]audio_in_left;
    wire [15:0]audio_in_right;
    wire clk_1hz;
    wire clk_100hz;
    wire clk_scan;
    wire pb_debounce_do;
    wire pb_debounce_re;
    wire pb_debounce_mi;
    wire pb_debounce_add;
    wire pb_debounce_decrease;
    wire add;
    wire decrease;
    wire [21:0]DIV;
    wire [3:0]amplitude;
    wire [3:0]ssd_in;
     
    clk_generator U0(.clk(clk), .clk_1hz(clk_1hz), .clk_100hz(clk_100hz), .clk_scan(clk_scan));
    debounce U1(.clk(clk_100hz), .pb_in(pb_do), .pb_debounced(pb_debounce_do), .rst_n(rst_n));
    debounce U2(.clk(clk_100hz), .pb_in(pb_re), .pb_debounced(pb_debounce_re), .rst_n(rst_n));
    debounce U3(.clk(clk_100hz), .pb_in(pb_mi), .pb_debounced(pb_debounce_mi), .rst_n(rst_n));
    debounce U4(.clk(clk_100hz), .pb_in(pb_add), .pb_debounced(pb_debounce_add), .rst_n(rst_n));
    debounce U5(.clk(clk_100hz), .pb_in(pb_decrease), .pb_debounced(pb_debounce_decrease), .rst_n(rst_n));
    one_pulse U6(.clk(clk_100hz), .in_trig(pb_debounce_add), .out_pulse(add), .rst_n(rst_n));
    one_pulse U7(.clk(clk_100hz), .in_trig(pb_debounce_decrease), .out_pulse(decrease), .rst_n(rst_n));
    F_choose U8(.DO(pb_debounce_do), .RE(pb_debounce_re), .MI(pb_debounce_mi), .DIV(DIV));
    UP_DOWN U9(.clk(clk_100hz), .rst_n(rst_n), .add(add), .decrease(decrease), .q(amplitude));
    buzzer U10(.clk(clk), .rst_n(rst_n), .note_div(DIV), .audio_left(audio_in_left), .audio_right(audio_in_right), .amplitude(amplitude));
    speaker U11(.clk(clk), .rst_n(rst_n), .audio_mclk(mclk), .audio_lrck(lrck), .audio_sck(sck), .audio_sdin(sdin), .audio_in_left(audio_in_left), .audio_in_right(audio_in_right));
    scan U12(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .control(clk_scan), .rank(amplitude));
    display U13(.D_ssd(D_ssd), .in(ssd_in));
    
endmodule