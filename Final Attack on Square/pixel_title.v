module pixel_title(
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  input clk,
  input rst,
  input pulse,
  input [11:0]image_pixel,
  output reg [16:0] pixel_addr,
  output reg [11:0]pixel,
  output reg a
);
    reg [16:0] pixel_addr_temp;
    reg [11:0]pixel_temp;
	reg a_temp;
	
	always@*
	   if (pulse) a_temp = ~a;
	   else a_temp = a;
    always@(posedge clk or posedge rst)
       if (rst) a <= 0;
       else a<= a_temp;
           	
	always@* // addr
	   if( h_cnt > (80+35) && h_cnt <= (80+445) && v_cnt > 80 && v_cnt <= 160)
			pixel_addr_temp = 9800 + (v_cnt-(80))*410+(h_cnt-(80+35));
        else if( h_cnt > 265 && h_cnt <= 355 && v_cnt > 240 && v_cnt <= 280)
            pixel_addr_temp = 42600 + (v_cnt-240)*90+(h_cnt-265);
        else if( h_cnt > 265 && h_cnt <= 375 && v_cnt > 300 && v_cnt <= 340)
            pixel_addr_temp = 46200 + (v_cnt-300)*110+(h_cnt-265);
		else pixel_addr_temp = 53;    
    always@(posedge clk or posedge rst)
        if (rst) pixel_addr <= 0;
        else pixel_addr <= pixel_addr_temp;
        
     always@* // pixel
        if( h_cnt > (80+35) && h_cnt <= (80+445) && v_cnt > 80 && v_cnt <= 160) pixel_temp = image_pixel;
        else if( h_cnt > 265 && h_cnt <= 355 && v_cnt > 240 && v_cnt <= 280)
            if (~a && image_pixel == 0) pixel_temp = 12'hAFF;
            else pixel_temp = image_pixel;
        else if( h_cnt > 265 && h_cnt <= 375 && v_cnt > 300 && v_cnt <= 340)
            if (a && image_pixel == 0) pixel_temp = 12'hAFF;
            else pixel_temp = image_pixel;
        else pixel_temp = 0;
    always@(posedge clk or posedge rst)
        if (rst) pixel <= 0;
        else pixel <= pixel_temp;    
                  
endmodule
