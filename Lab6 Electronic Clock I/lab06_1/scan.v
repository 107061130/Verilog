module scan(ssd_ctl, ssd_in, sec1, sec2, min1, min2, hour, control, change_mode, to_sec, PM);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    output reg PM;
    input to_sec;
    input [3:0]sec1;
    input [3:0]sec2;
    input [3:0]min1;
    input [3:0]min2;
    input [4:0]hour;
    input [1:0] control;
    input change_mode;
    
    reg [3:0] cnt1;
    reg [3:0] cnt2;
    reg [3:0] cnt3;
    reg [3:0] cnt4; 
    
    always@* 
        if (change_mode) begin
            if (hour > 5'd12) begin
                PM = 1'b1;
                cnt4 = (hour - 4'd12) / 6'd10;
                cnt3 = (hour - 4'd12) % 6'd10;
                cnt2 = min2;
                cnt1 = min1;
            end
            else if (hour == 5'd0) begin 
                cnt4 = 4'd1;
                cnt3 = 4'd2;
                PM = 1'b0;
                cnt2 = min2;
                cnt1 = min1;
            end
             else if (hour == 5'd12) begin 
                 cnt4 = 4'd1;
                 cnt3 = 4'd2;
                 PM = 1'b1;
                 cnt2 = min2;
                 cnt1 = min1;
            end
            else begin
                PM = 1'b0;
                cnt4 = hour / 4'd10;
                cnt3 = hour % 4'd10;
                cnt2 = min2;
                cnt1 = min1;
            end
        end 
        else begin
            cnt4 = hour / 4'd10;
            cnt3 = hour % 4'd10;
            cnt2 = min2;
            cnt1 = min1;
        end
    
    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b0111;
                      if (to_sec) ssd_in = sec2;
                      else ssd_in = cnt4;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1011;
                      if (to_sec) ssd_in = sec1;
                      else ssd_in = cnt3;
                  end
              2'b10:
                  begin
                      ssd_ctl = 4'b1101;
                      if (change_mode & to_sec & ~PM) ssd_in = 4'b1010;
                      else if (change_mode & to_sec & PM) ssd_in = 4'b1011;
                      else if (~change_mode & to_sec) ssd_in = 4'b1111;
                      else ssd_in = cnt2;
                  end
              2'b11:
                  begin
                      ssd_ctl = 4'b1110;
                      if (change_mode & to_sec) ssd_in = 4'b1100;
                      else if (~change_mode & to_sec) ssd_in = 4'b1111;
                      else ssd_in = cnt1;
                  end
              default:
                  begin
                      ssd_ctl = 4'b0000;
                      ssd_in = 4'b0000;
                  end
      endcase
      
 endmodule

