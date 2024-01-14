module top(clk, rst_n, ssd_ctl, D_ssd, PS2_DATA, PS2_CLK);
    input clk;
    input rst_n;
    inout PS2_DATA;
    inout PS2_CLK;
    output [3:0]ssd_ctl;
    output reg [7:0]D_ssd;
    
    wire [13:0]value1;
    wire [6:0]value2;
    wire [13:0]value3;
    //wire key_valid;
    wire [8:0]last_change;
    wire [511:0]key_down;
    wire [3:0]ssd_in;
    wire [1:0]clk_scan;
    wire [1:0]state;
    wire pulse;
    wire neg;
    wire [7:0]D_ssd_temp;
    
    KeyboardDecoder U0(.key_down(key_down), .last_change(last_change), .key_valid(), .PS2_DATA(PS2_DATA), 
                                   .PS2_CLK(PS2_CLK), .rst(~rst_n), .clk(clk));
    clk_generator U1(.clk_scan(clk_scan), .clk(clk));
    one_pulse U2(.clk(clk), .in_trig(key_down[last_change]), .out_pulse(pulse), .rst_n(rst_n));
    FSM U3(.clk(clk), .value1(value1),  .value2(value2),  .value3(value3), .key_down(key_down), .press(pulse), 
                .last_change(last_change), .rst_n(rst_n), .state(state), .neg(neg), .key_valid(key_valid));
    scan U4(.clk(clk), .rst_n(rst_n), .ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .value1(value1), .value2(value2),  
                .value3(value3), .control(clk_scan), .state(state));
    display U5(.D_ssd(D_ssd_temp), .in(ssd_in));
    
    always@*
        if (neg && state == 2'd2) D_ssd = D_ssd_temp - 1'b1;
        else D_ssd = D_ssd_temp;
    
endmodule