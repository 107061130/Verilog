module top(clk, pb_in, pb_lap, ssd_ctl, D_ssd, rst);
    input clk;
    input pb_in;
    input rst;
    input pb_lap;
    output [3:0]ssd_ctl;
    output [7:0]D_ssd;
    
    wire rst_h;
    wire pb_debounced_rst;
    wire pb_debounced; 
    wire pb_debounced_lap;
    wire out_pulse_lap;
    wire clk_1hz;
    wire clk_100hz;
    wire [1:0]clk_scan;
    wire out_pulse;
    wire count_en;
    wire [3:0]sec1;
    wire [3:0]sec2;
    wire [3:0]min2;
    wire [3:0]min1;
    wire [3:0]borrow;
    wire LAP;
    wire [3:0]ssd_ctl;
    wire [3:0]ssd_in;
    
    clk_generator U0(.clk(clk), .clk_1hz(clk_1hz), .clk_100hz(clk_100hz), .clk_scan(clk_scan));
    debounce U1(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced), .rst_n(rst));
    debounce U21(.clk(clk_1hz), .pb_in(pb_lap), .pb_debounced(pb_debounced_rst), .rst_n(rst));
    debounce U8(.clk(clk_100hz), .pb_in(pb_lap), .pb_debounced(pb_debounced_lap), .rst_n(rst));
    one_pulse U2(.clk(clk), .in_trig(pb_debounced), .out_pulse(out_pulse), .rst_n(rst));
    one_pulse U22(.clk(clk_100hz), .in_trig(pb_debounced_rst), .out_pulse(rst_h), .rst_n(rst));
    one_pulse U52(.clk(clk), .in_trig(pb_debounced_lap), .out_pulse(out_pulse_lap), .rst_n(rst));
    FSM U5(.count_en(count_en), .in(out_pulse), .rst_h(rst_h));
    FSM2 u11(.in(out_pulse_lap), .rst_h(rst_h), .state(LAP));
    BCD_UP digit1(.limit(4'b1001), .clk(clk_1hz), .rst_h(rst_h), .add(count_en), .q(sec1), .borrow(borrow[0]));
    BCD_UP digit2(.limit(4'b0101), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[0]), .q(sec2), .borrow(borrow[1]));
    BCD_UP digit3(.limit(4'b1001), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[1]), .q(min1), .borrow(borrow[2]));
    BCD_UP digit4(.limit(4'b0101), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[2]), .q(min2), .borrow(borrow[3]));
    scan U4(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .min1(min1), .min2(min2), .sec1(sec1), .sec2(sec2),
    .control(clk_scan), .enable(LAP), .rst_h(rst_h));
    display(.D_ssd(D_ssd), .in(ssd_in));
    

endmodule