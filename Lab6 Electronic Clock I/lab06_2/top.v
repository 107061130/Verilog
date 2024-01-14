module top(clk, pb_in, change, ssd_ctl, D_ssd);
    input clk;
    input pb_in;
    input change;
    output [3:0]ssd_ctl;
    output [7:0]D_ssd;
    
    wire rst_h;
    wire pb_debounced_rst;
    wire pb_debounced; 
    wire clk_1hz;
    wire clk_100hz;
    wire [1:0]clk_scan;
    wire out_pulse;
    wire count_en;
    wire [4:0]date;
    wire [3:0]month;
    wire [6:0]year;
    wire [2:0]borrow;
    wire [3:0]ssd_ctl;
    wire [3:0]ssd_in;
    wire F;
    
    clk_generator U0(.clk(clk), .clk_1hz(clk_1hz), .clk_100hz(clk_100hz), .clk_scan(clk_scan), .F(F));
    debounce U1(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced));
    debounce U21(.clk(clk_100hz), .pb_in(pb_in), .pb_debounced(pb_debounced_rst));
    one_pulse U2(.clk(clk), .in_trig(pb_debounced), .out_pulse(out_pulse));
    one_pulse2 U22(.clk(clk_1hz), .in_trig(pb_debounced_rst), .out_pulse(rst_h));
    FSM U5(.count_en(count_en), .in(out_pulse), .rst_h(rst_h));
    BCD_UP U44(.limit(5'd31), .clk(clk_1hz), .rst_h(rst_h), .add(count_en), .q(date), .borrow(borrow[0]), .RETURN(month), .INITIAL(1'b1));
    BCD_UP U45(.limit(4'd12), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[0]), .q(month), .borrow(borrow[1]), .RETURN(4'd0), .INITIAL(1'b1));
    BCD_UP U46(.limit(7'd99), .clk(clk_1hz), .rst_h(rst_h), .add(borrow[1]), .q(year), .borrow(borrow[2]), .RETURN(4'd0), .INITIAL(1'b0));
    scan V4(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .date(date), .month(month), .year(year), .control(clk_scan), .change(change));
    display UU(.D_ssd(D_ssd), .in(ssd_in));
    

    
endmodule