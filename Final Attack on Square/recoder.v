module recorder(sec, lose, clk, rst, pixel_addr, pixel, image_pixel, h_cnt, v_cnt);
    input clk;
    input rst;
    input [9:0]sec;
    input lose;
    input [9:0]h_cnt;
    input [9:0]v_cnt;
    input [11:0]image_pixel;
    output reg [16:0] pixel_addr;
    output reg [11:0]pixel;
    
    reg[9:0]recoder1;
    reg[9:0]recoder2;
    reg[9:0]recoder3;
    reg [9:0]recoder1_tmp;
    reg [9:0]recoder2_tmp;
    reg [9:0]recoder3_tmp;
    reg [16:0] pixel_addr_temp;
    reg [11:0]pixel_temp;
    reg [9:0]grade;
    reg [9:0]grade_temp;
    
    always@*
        if (~lose) grade_temp = sec;
        else grade_temp = grade;
    always@(posedge clk or posedge rst)
        if (rst) grade <= 0;
       else grade <= grade_temp;
        
    always@*
        if(lose)
            if(grade >= recoder1)
                begin
                    recoder1_tmp = grade;
                    recoder2_tmp = recoder1;
                    recoder3_tmp = recoder2;
                end
            else if(grade < recoder1 && grade >= recoder2)
                begin
                    recoder1_tmp = recoder1;
                    recoder2_tmp = grade;
                    recoder3_tmp = recoder2;
                end
            else if(grade < recoder2 && grade>= recoder3)
                begin
                    recoder1_tmp = recoder1;
                    recoder2_tmp = recoder2;
                    recoder3_tmp = grade;
                end
            else
                begin
                    recoder3_tmp = recoder3;
                    recoder2_tmp = recoder2;
                    recoder1_tmp = recoder1;
                end
       else
            begin
               recoder3_tmp = recoder3;
               recoder2_tmp = recoder2;
               recoder1_tmp = recoder1;
           end         
          
    always@(posedge clk or posedge rst)
        if(rst)
            begin
                recoder3 <= 0;
                recoder2 <= 0;
                recoder1 <= 0;
            end
        else
            begin
                recoder3 <= recoder3_tmp;
                recoder2 <= recoder2_tmp;
                recoder1 <= recoder1_tmp;
            end
        
    always@*  // addr
           if( h_cnt >= 210 && h_cnt < 430 && v_cnt >= 100 && v_cnt < 180)  //record word
                pixel_addr_temp = 9800 + ((((h_cnt-210)>>1)+110*((v_cnt-100)>>1))% 4400);
           else if( h_cnt >= 270 && h_cnt < 290 )
                begin
                    if(v_cnt >= 220 && v_cnt < 260) //1
                        pixel_addr_temp = 800*1 + (v_cnt-220)*20+(h_cnt-270);
                    else if(v_cnt >= 300 && v_cnt < 340) //2
                        pixel_addr_temp = 800*2 + (v_cnt-300)*20+(h_cnt-270);
                    else if(v_cnt >= 380 && v_cnt < 420) //3
                        pixel_addr_temp = 800*3 + (v_cnt-380)*20+(h_cnt-270);
                    else pixel_addr_temp = 53;
                end
           else if( h_cnt >= 310 && h_cnt < 330 && v_cnt >= 220 && v_cnt < 260) //a2
                pixel_addr_temp = 800*(recoder1 / 100) + (v_cnt-220)*20+(h_cnt-310);
           else if( h_cnt >= 330 && h_cnt < 350 && v_cnt >= 220 && v_cnt < 260) //a1
                pixel_addr_temp = 800*((recoder1 % 100) / 10) + (v_cnt-220)*20+(h_cnt-330);
           else if( h_cnt >= 350 && h_cnt < 370 && v_cnt >= 220 && v_cnt < 260) //a0
                pixel_addr_temp = 800*(recoder1 % 10) + (v_cnt-220)*20+(h_cnt-350);
           else if( h_cnt >= 310 && h_cnt < 330 && v_cnt >= 300 && v_cnt < 340) //b2
                pixel_addr_temp = 800*(recoder2 / 100) + (v_cnt-300)*20+(h_cnt-310);
           else if( h_cnt >= 330 && h_cnt < 350 && v_cnt >= 300 && v_cnt < 340) //b1
                pixel_addr_temp = 800*((recoder2 % 100) / 10) + (v_cnt-300)*20+(h_cnt-330);
           else if( h_cnt >= 350 && h_cnt < 370 && v_cnt >= 300 && v_cnt < 340) //b0
                pixel_addr_temp = 800*(recoder2 % 10) + (v_cnt-300)*20+(h_cnt-350);
           else if( h_cnt >= 310 && h_cnt < 330 && v_cnt >= 380 && v_cnt < 420) //c2
                pixel_addr_temp = 800*(recoder3 / 100) + (v_cnt-380)*20+(h_cnt-310);
           else if( h_cnt >= 330 && h_cnt < 350 && v_cnt >= 380 && v_cnt < 420) //c1
                pixel_addr_temp = 800*((recoder3 % 100) / 10) + (v_cnt-380)*20+(h_cnt-330);
           else if( h_cnt >= 350 && h_cnt < 370 && v_cnt >= 380 && v_cnt < 420) //c0
                pixel_addr_temp = 800*(recoder3 % 10) + (v_cnt-380)*20+(h_cnt-350);
           else pixel_addr_temp = 3;         
        always@(posedge clk or posedge rst)
            if (rst) pixel_addr <= 0;
            else pixel_addr <= pixel_addr_temp;
            
    always@* // pixel
        if( h_cnt >= 210 && h_cnt < 430 && v_cnt >= 100 && v_cnt < 180) pixel_temp = image_pixel;                          
        else if( h_cnt >= 270 && h_cnt < 290 ) 
            if(v_cnt >= 220 && v_cnt < 260) pixel_temp = image_pixel;                           
            else if(v_cnt >= 300 && v_cnt < 340) pixel_temp = image_pixel;                               
            else if(v_cnt >= 380 && v_cnt < 420) pixel_temp = image_pixel;     
            else pixel_temp = 0;                         
        else if( h_cnt >= 310 && h_cnt < 370 && v_cnt >= 220 && v_cnt < 260) pixel_temp = image_pixel;
        else if( h_cnt >= 310 && h_cnt < 370 && v_cnt >= 300 && v_cnt < 340) pixel_temp = image_pixel;                       
        else if( h_cnt >= 310 && h_cnt < 370 && v_cnt >= 380 && v_cnt < 420) pixel_temp = image_pixel;
        else pixel_temp = 0;      

    always@(posedge clk or posedge rst)
        if (rst) pixel <= 0;
        else pixel <= pixel_temp; 

endmodule  
