module top(
  input clk,
  input rst,
  input rst_n,
  inout PS2_DATA,
  inout PS2_CLK,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync
);
    wire [3:0]value1_1, value1_2, value1_3, value1_4;
    wire [3:0]value2_1, value2_2;
    wire [3:0]value3_1, value3_2, value3_3, value3_4;
    wire neg;
    wire [1:0]state;
    wire [1:0]ASD;
    wire clk_25MHz;
    wire [11:0] data;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480 
    
    clk_generator U0(.clk(clk), .clk1(clk_25MHz));
    vga_controller  U1(.pclk(clk_25MHz), .reset(rst), .hsync(hsync), .vsync(vsync), .valid(valid), .h_cnt(h_cnt), .v_cnt(v_cnt));
    caculator U2(.clk(clk), .rst_n(rst_n), .PS2_DATA(PS2_DATA), .PS2_CLK(PS2_CLK), .neg(neg), .state(state), .ASD(ASD), 
                       .value1_1(value1_1), .value1_2(value1_2), .value1_3(value1_3), .value1_4(value1_4), .value2_1(value2_1), 
                       .value2_2(value2_2), .value3_1(value3_1), .value3_2(value3_2), .value3_3(value3_3), .value3_4(value3_4));
    addr_assign U3(.clk(clk), .rst(rst), .valid(valid), .ASD(ASD), .neg(neg), .h_cnt(h_cnt), .v_cnt(v_cnt), .value1_1(value1_1), 
                           .value1_2(value1_2), .value1_3(value1_3), .value1_4(value1_4), .value2_1(value2_1), .value2_2(value2_2), 
                           .value3_1(value3_1), .value3_2(value3_2), .value3_3(value3_3), .value3_4(value3_4), .addr(pixel_addr));
    blk_mem_gen_0 U17(.clka(clk_25MHz), .wea(0), .addra(pixel_addr), .dina(data[11:0]), .douta(pixel));  
    assign {vgaRed, vgaGreen, vgaBlue} = pixel;
    
               
endmodule