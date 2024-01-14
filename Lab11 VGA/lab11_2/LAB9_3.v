module caculator(clk, rst_n, PS2_DATA, PS2_CLK, value1_1, value1_2, value1_3, value1_4, value2_1, value2_2, value3_1, value3_2, value3_3, value3_4, neg, state, ASD);
    input clk;
    input rst_n;
    inout PS2_DATA;
    inout PS2_CLK;
    output neg;
    output [1:0]state;
    output [1:0]ASD;
    output [3:0]value1_1, value1_2, value1_3, value1_4;
    output [3:0]value2_1, value2_2;
    output [3:0]value3_1, value3_2, value3_3, value3_4;
    
    //wire key_valid;
    wire [8:0]last_change;
    wire [511:0]key_down;
    wire [1:0]state;
    wire pulse;
    wire [13:0]value1;
    wire [6:0]value2;
    wire [13:0]value3;
    
    KeyboardDecoder U0(.key_down(key_down), .last_change(last_change), .key_valid(), .PS2_DATA(PS2_DATA), 
                                   .PS2_CLK(PS2_CLK), .rst(~rst_n), .clk(clk));
    one_pulse U2(.clk(clk), .in_trig(key_down[last_change]), .out_pulse(pulse), .rst_n(rst_n));
    FSM U3(.clk(clk), .value1(value1),  .value2(value2),  .value3(value3), .key_down(key_down), .press(pulse), 
                .last_change(last_change), .rst_n(rst_n), .state(state), .neg(neg), .ASD(ASD));
    
    assign value1_4 = value1 / 10'd1000; 
    assign value1_3 = (value1 % 10'd1000) / 10'd100; 
    assign value1_2 = (value1 % 10'd100) / 4'd10;
    assign value1_1 = value1 % 4'd10; 
    assign value2_2 = value2 / 4'd10; 
    assign value2_1 = value2 % 4'd10; 
    assign value3_4 = value3 / 10'd1000; 
    assign value3_3 = (value3 % 10'd1000) / 10'd100; 
    assign value3_2 = (value3 % 10'd100) / 4'd10; 
    assign value3_1 = value3 % 4'd10; 
    
endmodule