module top(
    input clk,
    input rst,
    input pb_r,
    input pb_g,
    input pb_b,
    inout PS2_DATA,
    inout PS2_CLK,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync,
    output [3:0]ssd_ctl,
    output [7:0]D_ssd,
    output [11:0]LED_RGB,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin    
);
    //wire key_valid;
    wire [8:0]last_change;
    wire [511:0]key_down;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480 
    wire clk_25MHz;
    wire clk_1hz;
    wire clk_23;
    wire clk_10hz;
    wire clk_100hz;
    wire clk_speed2; // character speed
    wire clk_speed; // tile speed
    wire [1:0]clk_scan;
    wire [11:0]position;
    wire [11:0]pixel_game;
    wire [16:0]pixel_addr_game;
    wire [11:0]pixel_recorder;
    wire [16:0]pixel_addr_recorder;
    wire [11:0]pixel_title;
    wire [16:0]pixel_addr_title;
    wire [11:0]pixel_over;
    wire [16:0]pixel_addr_over;
    wire [11:0]data;
    wire [11:0]image_pixel;
    wire [11:0]pixel;
    wire [16:0]pixel_addr;
    wire LOSE;
    wire [9:0]sec;
    wire [3:0]ssd_in;
    wire [11:0]tile_color;
    wire select;
    wire pulse;
    wire enter;
    wire restart;
    wire R, G, B;
    wire [11:0]COLOR;
    wire [15:0]audio_in_left;
    wire [15:0]audio_in_right;
    wire record;
    wire [21:0]DIV;
    wire clk_2hz;
    wire music;
      
    KeyboardDecoder U0(.key_down(key_down), .last_change(last_change), .key_valid(), .PS2_DATA(PS2_DATA), 
                                   .PS2_CLK(PS2_CLK), .rst(rst), .clk(clk));
    clk_generator U1(.clk(clk), .rst(rst), .clk1(clk_25MHz), .clk_1hz(clk_1hz), .clk_speed2(clk_speed2), .sec(sec), .clk_speed(clk_speed), .clk_scan(clk_scan), .clk_10hz(clk_10hz), .clk_100hz(clk_100hz), .clk23(clk_23), .half(clk_2hz));
    debounce U2(.clk(clk_100hz), .pb_in(pb_r), .pb_debounced(R), .rst_n(~rst));
    debounce U3(.clk(clk_100hz), .pb_in(pb_g), .pb_debounced(G), .rst_n(~rst));
    debounce U4(.clk(clk_100hz), .pb_in(pb_b), .pb_debounced(B), .rst_n(~rst));
    one_pulse U5(.out_pulse(pulse), .clk(clk), .in_trig(key_down[9'h029]), .rst_n(~rst));
    one_pulse U6(.out_pulse(enter), .clk(clk), .in_trig(key_down[9'h05A]), .rst_n(~rst));
    RGB U10(.in(R), .rst(rst), .clk(clk_2hz), .count(tile_color[11:8]));
    RGB U11(.in(G), .rst(rst), .clk(clk_2hz), .count(tile_color[7:4]));
    RGB U12(.in(B), .rst(rst), .clk(clk_2hz), .count(tile_color[3:0]));
    vga_controller  U13(.pclk(clk_25MHz), .reset(rst), .hsync(hsync), .vsync(vsync), .valid(valid), .h_cnt(h_cnt), .v_cnt(v_cnt));
    random U14(.clk(clk_1hz), .rst(rst), .position(position));
    counter U15(.clk_1hz(clk_1hz), .rst(rst || restart), .LOSE(LOSE), .sec(sec));
    pixel_title U16(.clk(clk), .rst(rst), .pulse(pulse), .h_cnt(h_cnt), .v_cnt(v_cnt), .image_pixel(image_pixel), .pixel_addr(pixel_addr_title), .pixel(pixel_title), .a(select));
    pixel_game U17(.clk(clk), .clk_2hz(clk_2hz), .clk_speed(clk_speed), .clk_speed2(clk_speed2), .clk_10hz(clk_10hz), .valid(valid), .rst(rst || restart), .h_cnt(h_cnt), .v_cnt(v_cnt), .pixel(pixel_game), .position(position),
                          .tile_color(tile_color), .pixel_addr(pixel_addr_game), .image_pixel(image_pixel), .left(key_down[9'h01C]), .right(key_down[9'h023]), .LOSE(LOSE), .sec(sec), .COLOR(COLOR));
    pixel_gameover U18(.h_cnt(h_cnt),.v_cnt(v_cnt), .pixel_addr(pixel_addr_over), .clk(clk), .rst(rst), .clk23(clk_23), .pixel(pixel_over), .image_pixel(image_pixel));
    recorder U19(.sec(sec), .lose(record), .clk(clk), .rst(rst), .pixel_addr(pixel_addr_recorder), .pixel(pixel_recorder), .image_pixel(image_pixel), .h_cnt(h_cnt), .v_cnt(v_cnt));
    FSM U20(.pixel_over(pixel_over), .pixel_addr_over(pixel_addr_over), .pixel_game(pixel_game), .pixel_addr_game(pixel_addr_game), .pixel_recorder(pixel_recorder), 
                 .pixel_addr_recorder(pixel_addr_recorder), .pixel_title(pixel_title), .pixel_addr_title(pixel_addr_title), .clk(clk), .rst(rst), .pixel_addr(pixel_addr), .pixel(pixel), .select(select), .LOSE(LOSE), .enter(enter), .restart(restart), .record(record), .music(music));
    gameover_music U21(.clk(clk), .clk_05Hz(clk_2hz), .rst(rst || music), .note_div(DIV)); 
    buzzer U22(.clk(clk), .rst_n(~rst), .note_div(DIV), .audio_left(audio_in_left), .audio_right(audio_in_right));
    speaker U23(.clk(clk), .rst_n(~rst), .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck), .audio_sdin(audio_sdin), .audio_in_left(audio_in_left), .audio_in_right(audio_in_right));
    blk_mem_gen_0 U24(.clka(clk_25MHz), .wea(0), .addra(pixel_addr), .dina(data[11:0]), .douta(image_pixel));
    scan U25(.ssd_ctl(ssd_ctl), .ssd_in(ssd_in), .R(COLOR[11:8]), .G(COLOR[7:4]), .B(COLOR[3:0]), .control(clk_scan));
    display U26(.D_ssd(D_ssd), .in(ssd_in));
    assign {vgaRed, vgaGreen, vgaBlue} = pixel;
    assign LED_RGB = tile_color;
    
endmodule