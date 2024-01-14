module top(clk, SET, pb_start, rst, pb_pause, pb_mode, pb_add, ssd_ctl, D_ssd, led);
    input SET;
    input clk;
    input pb_pause;
    input pb_start;
    input pb_mode;
    input pb_add;
    input rst;
    output [3:0]ssd_ctl;
    output [7:0]D_ssd;
    output reg [15:0]led;
    
    wire pb_debounced_add;
    wire pb_debounced_start;
    wire pb_debounced_pause;
    wire pb_debounced_mode; 
    wire add;
    wire out_pulse_mode;
    wire out_pulse_start;
    wire out_pulse_pause;
    wire stop;
    wire pause_resume;
    wire mode;
    wire clk_1hz;
    wire clk_100hz;
    wire [1:0]clk_scan;
    wire [5:0]min;
    wire [4:0]hour;
    wire [1:0]borrow;
    wire [3:0]ssd_ctl;
    wire [3:0]ssd_in;
    wire [5:0]set_min;
    wire [4:0]set_hour;
    wire [5:0]NEW_LIMIT_min;
    wire [4:0]NEW_LIMIT_hour;
    
    clk_generator U0(.clk(clk), .clk_1hz(clk_1hz), .clk_100hz(clk_100hz), .clk_scan(clk_scan));
    debounce U1(.clk(clk_100hz), .pb_in(pb_add), .pb_debounced(pb_debounced_add), .rst_n(rst));
    debounce U2(.clk(clk_100hz), .pb_in(pb_mode), .pb_debounced(pb_debounced_mode), .rst_n(rst));
    debounce U3(.clk(clk_100hz), .pb_in(pb_start), .pb_debounced(pb_debounced_start), .rst_n(rst));
    debounce U4(.clk(clk_100hz), .pb_in(pb_pause), .pb_debounced(pb_debounced_pause), .rst_n(rst));
    one_pulse U5(.clk(clk_100hz), .in_trig(pb_debounced_add), .out_pulse(add), .rst_n(rst));
    one_pulse U6(.clk(clk_100hz), .in_trig(pb_debounced_mode), .out_pulse(out_pulse_mode), .rst_n(rst));
    one_pulse U7(.clk(clk_100hz), .in_trig(pb_debounced_start), .out_pulse(out_pulse_start), .rst_n(rst));
    one_pulse U8(.clk(clk_100hz), .in_trig(pb_debounced_pause), .out_pulse(out_pulse_pause), .rst_n(rst));
    FSM_pause_start U9(.clk(clk_100hz), .in(out_pulse_pause), .in2(out_pulse_start), .set(SET), .rst_n(rst), .count_en(pause_resume), .stop(stop));
    FSM_mode U11(.in(out_pulse_mode), .rst_n(rst), .state(mode));
    SETTING u16(.clk(clk_100hz), .min(min), .hour(hour), .set(SET), .add(add), .value_min(set_min), .mode(mode), .value_hour(set_hour));
    DOWN U12(.limit(6'd59), .clk(clk_1hz), .rst_n(rst), .decrease(pause_resume), .value(min), .borrow(borrow[0]) , .set(SET), .stop(stop), .set_value(set_min));
    DOWN U13(.limit(5'd23), .clk(clk_1hz), .rst_n(rst), .decrease(borrow[0]), .value(hour), .borrow(borrow[1]), .set(SET), .stop(stop), .set_value(set_hour));
    scan U14(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .min(min), .hour(hour), .control(clk_scan));
    display U15(.D_ssd(D_ssd), .in(ssd_in));
    
    always@*
        if (min == 0 && hour == 0) led = 16'b1111111111111111;
        else led = 16'd0;
    
endmodule