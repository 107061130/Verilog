module top(
    input clk,
    input rst,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync
);
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480 
    wire clk_25MHz;
    wire clk_1hz;
    wire [2:0]num;
    wire en;
    wire [11:0]pixel;
    
    clk_generator U0(.clk(clk), .clk1(clk_25MHz), .clk_1hz(clk_1hz));
    vga_controller  U1(.pclk(clk_25MHz), .reset(rst), .hsync(hsync), .vsync(vsync), .valid(valid), .h_cnt(h_cnt), .v_cnt(v_cnt));
    random U2(.clk(clk_1hz), .num(num), .rst(rst), .en(en));
    pixel_generator U3(.clk(clk), .clk_1hz(clk_1hz), .valid(valid), .rst(rst), .h_cnt(h_cnt), .v_cnt(v_cnt), .num(num), .pixel(pixel), .en(en));
    assign {vgaRed, vgaGreen, vgaBlue} = pixel;
    
endmodule