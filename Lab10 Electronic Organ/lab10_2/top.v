module top(clk, rst_n, LED_CAP, PS2_DATA, PS2_CLK, ssd_ctl, D_ssd, mclk, lrck, sck, sdin);
    input clk;
    input rst_n;
    inout PS2_DATA;
    inout PS2_CLK;
    output LED_CAP;
    output [3:0]ssd_ctl;
    output [7:0]D_ssd;
    output mclk;
    output lrck;
    output sck;
    output sdin;
    
    wire [8:0]last_change;
    wire [511:0]key_down;
    //wire key_valid;
    wire CAP;
    wire [21:0]DIV;
    wire [3:0]ssd_in;
    wire [15:0]audio_in_left;
    wire [15:0]audio_in_right;
    wire [1:0]clk_scan;
    wire [22:0]f;
    wire [3:0]num;
    
    clk_generator U0(.clk(clk), .clk_scan(clk_scan));
    KeyboardDecoder U1(.key_down(key_down), .last_change(last_change), .key_valid(), .PS2_DATA(PS2_DATA), 
                                   .PS2_CLK(PS2_CLK), .rst(~rst_n), .clk(clk));
    FSM_CAP U2(.in(key_down[9'h058]), .rst_n(rst_n), .state(CAP));
    F_choose U3(.last_change(last_change), .key_down(key_down), .CAP(CAP), .clk(clk), .rst_n(rst_n), .f(f), .num(num));
    buzzer U4(.clk(clk), .rst_n(rst_n), .note_div(f), .audio_left(audio_in_left), .audio_right(audio_in_right));
    speaker U5(.clk(clk), .rst_n(rst_n), .audio_mclk(mclk), .audio_lrck(lrck), .audio_sck(sck), .audio_sdin(sdin), .audio_in_left(audio_in_left), .audio_in_right(audio_in_right));
    scan U6(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .control(clk_scan), .rank(num));
    display U7(.D_ssd(D_ssd), .in(ssd_in));
    assign LED_CAP = CAP;
    
endmodule