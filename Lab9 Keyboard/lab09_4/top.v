module top(clk, rst_n, LED, LED_CAP, PS2_DATA, PS2_CLK, key_valid);
    input clk;
    input rst_n;
    inout PS2_DATA;
    inout PS2_CLK;
    output [6:0]LED;
    output LED_CAP;
    output wire key_valid;
    
    wire [8:0]last_change;
    wire [511:0]key_down;
    //wire key_valid;
    wire CAP;
    
    KeyboardDecoder U0(.key_down(key_down), .last_change(last_change), .key_valid(key_valid), .PS2_DATA(PS2_DATA), 
                                   .PS2_CLK(PS2_CLK), .rst(~rst_n), .clk(clk));
    FSM_CAP U1(.in(key_down[9'h058]), .rst_n(rst_n), .state(CAP));
    DECORDER U2(.clk(clk), .rst_n(rst_n), .LED(LED), .last_change(last_change), .key_down(key_down), .CAP(CAP));
    assign LED_CAP = CAP;
    
endmodule