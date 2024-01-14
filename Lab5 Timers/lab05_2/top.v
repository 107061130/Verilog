module main(clk, pb_in, led, D_ssd, ssd_ctl);
    input clk; 
    input pb_in; 
    output reg [15:0] led;
    output [7:0] D_ssd;
    output [3:0] ssd_ctl;
    
    wire rst_h;
    wire pb_debounced_rst;
    wire pb_debounced; 
    wire clk_1hz,clk_100hz;
    wire [1:0]clk_scan;
    wire out_pulse;
    wire [3:0] ssd_in;
    wire [3:0] value0;
    wire [3:0] value1;
    wire check;
    wire count_en;
    wire END;
    wire [1:0]borrow;
    wire current_state;

    clk_generator U0(.clk(clk), .clk_1hz(clk_1hz), .clk_100hz(clk_100hz), .clk_scan(clk_scan));
    debounce U1(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced));
    debounce U21(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced_rst));
    one_pulse U2(.clk(clk), .in_trig(pb_debounced), .out_pulse(out_pulse));
    one_pulse2 U22(.clk(clk_1hz), .in_trig(pb_debounced_rst), .out_pulse(rst_h));
    display U3(.D_ssd(D_ssd), .in(ssd_in));
    scan U4(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .cnt1(value0), .cnt2(value1), .control(clk_scan));
    FSM U5(.count_en(count_en), .in(out_pulse), .rst_h(rst_h), .current_state(current_state));
    BCD_DOWN digit1(.limit(4'b0000), .clk(clk_1hz), .rst_h(rst_h), .decrease(count_en & ~END), .q(value0), .borrow(borrow[0]));
    BCD_DOWN digit2(.limit(4'b0011), .clk(clk_1hz), .rst_h(rst_h), .decrease(borrow[0]), .q(value1), .borrow(borrow[1]));
    check U222(.in1(value1), .in2(value0), .out(END));
    
    always@*    
        if(END == 1'b1)
            led = 16'b1111111111111111;
        else if(current_state == 1'b1)
            led = 16'b0000000000000001;
        else
            led = 16'b0000000000000000;
endmodule



