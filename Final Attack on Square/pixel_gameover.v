module pixel_gameover(
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  input clk,
  input clk23,
  input rst,
  output reg [16:0] pixel_addr,
  output reg [11:0]pixel,
  input [11:0]image_pixel
);
reg [11:0]pixel_temp;
reg [16:0]pixel_addr_temp;
reg [8:0]start_temp;
reg a;
reg a_temp;
reg [4:0]n;
reg [4:0]n_temp;
reg [8:0]start;

always@*
    if (start_temp < 320-78 || start_temp > 320 ) begin
        n_temp = 0;
        a_temp = ~a;
    end
    else begin
        a_temp = a;
        n_temp = n + 1;
    end
    
always@*
    begin
        start_temp = start - (12 - n);
    end

always@*
   if( h_cnt >= (210) && h_cnt < (430) && v_cnt > 100 && v_cnt <= 160)
        pixel_addr_temp = 42600 + (v_cnt-(100))*220+(h_cnt-(210));
   else if ( a && ( h_cnt > (253) && h_cnt <= (388) && v_cnt > start && v_cnt <= start + 160))
        pixel_addr_temp = 55800 + (v_cnt-start)*135+(h_cnt-(253));
   else if ( (~a) && ( h_cnt > (253) && h_cnt <= (388) && v_cnt > start && v_cnt <= start+160)) //down
        pixel_addr_temp = 77400 + (v_cnt-start)*135+(h_cnt-(253));
   else pixel_addr_temp = 3;
    
always@(posedge clk or posedge rst)
    if (rst) pixel_addr <= 0;
    else pixel_addr <= pixel_addr_temp;
    
always@*
   if( h_cnt >= (210) && h_cnt < (430) && v_cnt > 100 && v_cnt <= 160)
        pixel_temp = image_pixel;
   else if (( h_cnt > (253) && h_cnt <= (388) && v_cnt > start && v_cnt <= start + 160))
        pixel_temp = image_pixel;
   else pixel_temp = 0;    
always@(posedge clk or posedge rst)
   if (rst) pixel <= 0;
   else pixel <= pixel_temp;
    
always@(posedge clk23 or posedge rst)
        if (rst)
            begin
                start <= 320;
                n <= 0;
            end
        else
            begin
                start <= start_temp;
                n <= n_temp;
            end
    
always@(posedge clk23 or posedge rst)
            if (rst)
                begin
                    a <= 0;
                end
            else
                begin
                    a <= a_temp;
                end
endmodule
