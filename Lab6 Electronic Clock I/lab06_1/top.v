module top(clk, pb_in, pb_mode, to_sec, ssd_ctl, D_ssd);
    input clk;
    input pb_in;
    input pb_mode;
    input to_sec;
    output [3:0]ssd_ctl;
    output reg [7:0]D_ssd;
    
    wire rst_h;
    wire pb_debounced_rst;
    wire pb_debounced; 
    wire pb_debounced_mode;
    wire out_pulse_mode;
    wire clk_1hz;
    wire clk_100hz;
    wire [1:0]clk_scan;
    wire out_pulse;
    wire count_en;
    wire [3:0]sec1;
    wire [3:0]sec2;
    wire [3:0]min2;
    wire [3:0]min1;
    wire [4:0]hour;
    wire [4:0]borrow;
    wire change_mode;
    wire [3:0]ssd_ctl;
    wire [3:0]ssd_in;
    wire PM;
    wire [7:0]D_ssd_temp;
    
    clk_generator U0(.clk(clk), .clk_1hz(clk_1hz), .clk_100hz(clk_100hz), .clk_scan(clk_scan));
    debounce U1(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced));
    debounce U21(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced_rst));
    debounce U8(.clk(clk_100hz), .pb_in(pb_mode), .pb_debounced(pb_debounced_mode));
    one_pulse U2(.clk(clk), .in_trig(pb_debounced), .out_pulse(out_pulse));
    one_pulse2 U22(.clk(clk_1hz), .in_trig(pb_debounced_rst), .out_pulse(rst_h));
    one_pulse U52(.clk(clk), .in_trig(pb_debounced_mode), .out_pulse(out_pulse_mode));
    FSM U5(.count_en(count_en), .in(out_pulse), .rst_h(rst_h));
    FSM_mode u11(.in(out_pulse_mode), .rst_h(rst_h), .state(change_mode));
    BCD_UP digit1(.limit(4'b0001), .clk(clk_1hz), .rst_h(rst_h), .add(count_en), .q(sec1), .borrow(borrow[0]));
    BCD_UP digit2(.limit(4'b0001), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[0]), .q(sec2), .borrow(borrow[1]));
    BCD_UP digit3(.limit(4'b0001), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[1]), .q(min1), .borrow(borrow[2]));
    BCD_UP digit4(.limit(4'b0001), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[2]), .q(min2), .borrow(borrow[3]));
    BCD_UP digit5(.limit(5'b10111), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[3]), .q(hour), .borrow(borrow[4]));   
    scan U4(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .min1(min1), .min2(min2), .hour(hour), .sec1(sec1), .sec2(sec2), 
    .control(clk_scan), .change_mode(change_mode), .to_sec(to_sec), .PM(PM));
    display(.D_ssd(D_ssd_temp), .in(ssd_in));
    
    always@*
        if (PM & change_mode) D_ssd = D_ssd_temp - 1'b1;
        else D_ssd = D_ssd_temp;
    
endmodule