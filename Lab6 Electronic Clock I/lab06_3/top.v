module top(clk, pb_in, pb_APM, pb_mode, ssd_ctl, D_ssd);
    input clk;
    input pb_in;
    input pb_APM;
    input pb_mode;
    output [3:0]ssd_ctl;
    output reg [7:0]D_ssd;
    
    wire rst_h;
    wire pb_debounced_rst;
    wire pb_debounced; 
    wire pb_debounced_mode;
    wire out_pulse_mode;
    wire [1:0]mode;
    wire pb_debounced_APM;
    wire out_pulse_APM;
    wire APM;
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
    wire [4:0]date;
    wire [3:0]month;
    wire [7:0]year;
    wire [7:0]borrow;
    wire [3:0]ssd_ctl;
    wire [3:0]ssd_in;
    wire PM;
    wire [7:0]D_ssd_temp;
    
    clk_generator U0(.clk(clk), .clk_1hz(clk_1hz), .clk_100hz(clk_100hz), .clk_scan(clk_scan));
    debounce U1(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced));
    debounce U21(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced_rst));
    debounce U8(.clk(clk_100hz), .pb_in(pb_mode), .pb_debounced(pb_debounced_mode));
    debounce U9(.clk(clk_100hz), .pb_in(pb_APM), .pb_debounced(pb_debounced_APM));
    one_pulse U2(.clk(clk), .in_trig(pb_debounced), .out_pulse(out_pulse));
    one_pulse2 U22(.clk(clk_1hz), .in_trig(pb_debounced_rst), .out_pulse(rst_h));
    one_pulse U52(.clk(clk), .in_trig(pb_debounced_mode), .out_pulse(out_pulse_mode));
    one_pulse U53(.clk(clk), .in_trig(pb_debounced_APM), .out_pulse(out_pulse_APM));
    FSM U5(.count_en(count_en), .in(out_pulse), .rst_h(rst_h));
    FSM_mode u11(.in(out_pulse_mode), .rst_h(rst_h), .state(mode));
    FSM_APM u12(.in(out_pulse_APM), .rst_h(rst_h), .state(APM));
    BCD_UP digit1(.limit(4'b1001), .clk(clk_1hz), .rst_h(rst_h), .add(count_en), .q(sec1), .borrow(borrow[0]), .INITIAL(1'b0));
    BCD_UP digit2(.limit(4'b0101), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[0]), .q(sec2), .borrow(borrow[1]), .INITIAL(1'b0));
    BCD_UP digit3(.limit(4'b1001), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[1]), .q(min1), .borrow(borrow[2]), .INITIAL(1'b0));
    BCD_UP digit4(.limit(4'b0101), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[2]), .q(min2), .borrow(borrow[3]), .INITIAL(1'b0));
    BCD_UP digit5(.limit(5'b10111), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[3]), .q(hour), .borrow(borrow[4]), .INITIAL(1'b0));   
    BCD_UP2 digit6(.limit(5'd31), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[4]), .q(date), .borrow(borrow[5]), .INITIAL(1'b1), .RETURN(month), .RETURN2(year));
    BCD_UP digit7(.limit(4'd12), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[5]), .q(month), .borrow(borrow[6]), .INITIAL(1'b1));
    BCD_UP digit8(.limit(8'd200), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[6]), .q(year), .borrow(borrow[7]), .INITIAL(8'd0));
    scan U4(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .min1(min1), .min2(min2), .hour(hour), .sec1(sec1), .sec2(sec2), .date(date), .month(month), .year(year), .control(clk_scan), .mode(mode), .APM(APM), .PM(PM));
    display U99(.D_ssd(D_ssd_temp), .in(ssd_in));
    
    always@*
        if (PM) D_ssd = D_ssd_temp - 1'b1;
        else D_ssd = D_ssd_temp;
    
endmodule