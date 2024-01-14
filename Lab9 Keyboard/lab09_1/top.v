module top(clk, rst_n, ssd_ctl, D_ssd, PS2_DATA, PS2_CLK);
    input clk;
    input rst_n;
    inout PS2_DATA;
    inout PS2_CLK;
    output [3:0]ssd_ctl;
    output [7:0]D_ssd;
    
    wire [511:0]key_down;
    wire [3:0]value;
    wire key_valid;
    wire [8:0]last_change;
    wire [511:0]key_down;
    wire [3:0]ssd_in;
    wire [1:0]clk_scan;
    wire [3:0]ASM;
    
    KeyboardDecoder U0(.key_down(key_down), .last_change(last_change), .key_valid(key_valid), .PS2_DATA(PS2_DATA), 
                                   .PS2_CLK(PS2_CLK), .rst(~rst_n), .clk(clk));
    clk_generator U1(.clk_scan(clk_scan), .clk(clk));
    value U2(.clk(clk), .value(value), .ASM(ASM), .key_down(key_down), .key_valid(key_valid), .last_change(last_change), .rst_n(rst_n));
    scan U3(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .value(value), .ASM(ASM), .control(clk_scan));
    display U4(.D_ssd(D_ssd), .in(ssd_in));
    
endmodule