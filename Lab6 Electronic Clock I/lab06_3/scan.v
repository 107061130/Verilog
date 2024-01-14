module scan(ssd_ctl, ssd_in, PM, sec1, sec2, min1, min2, hour, date, month, year, control, mode, APM);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    output reg PM;
    input APM;
    input [1:0]mode;
    input [3:0]sec1;
    input [3:0]sec2;
    input [3:0]min1;
    input [3:0]min2;
    input [4:0]hour;
    input [4:0]date;
    input [3:0]month;
    input [7:0]year;
    input [1:0] control;
    
    reg [3:0] cnt1;
    reg [3:0] cnt2;
    reg [3:0] cnt3;
    reg [3:0] cnt4; 
    
    always@*
        case(mode)
            2'b00: begin
                cnt4 = 4'b0010;
                cnt3 = year / 7'd100;
                cnt2 = (year % 100) / 4'd10;
                cnt1 = year % 4'd10;
            end
            2'b01: begin
                 cnt4 = month / 4'd10;
                 cnt3 = month % 4'd10;
                 cnt2 = date / 4'd10;
                 cnt1 = date % 4'd10;   
            end
            2'b10: begin
                if (APM) begin
                    if (hour > 5'd12) begin
                        PM = 1'b1;
                        cnt4 = (hour - 4'd12) / 5'd10;
                        cnt3 = (hour - 4'd12) % 5'd10;
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
                        cnt4 = hour / 4'd10;
                        cnt3 = hour % 4'd10;
                        PM = 1'b1;
                        cnt2 = min2;
                        cnt1 = min1;     
                    end 
                end
                else begin
                    cnt4 = hour / 4'd10;
                    cnt3 = hour % 4'd10;   
                    PM = 1'b0;
                    cnt2 = min2;
                    cnt1 = min1;      
                end 
            end
            2'b11: begin
                cnt4 = 4'b0000;
                cnt3 = 4'b0000;
                cnt2 = sec2;
                cnt1 = sec1;    
            end
            default: begin
                cnt4 = 4'b0010;
                cnt3 = year / 7'd100;
                cnt2 = (year % 100) / 4'd10;
                cnt1 = year % 4'd10;     
            end
    endcase
      
    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b0111;
                      ssd_in = cnt4;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1011;
                      ssd_in = cnt3;
                  end
              2'b10:
                  begin
                      ssd_ctl = 4'b1101;
                      ssd_in = cnt2;
                  end
              2'b11:
                  begin
                      ssd_ctl = 4'b1110;
                      ssd_in = cnt1;
                  end
              default:
                  begin
                      ssd_ctl = 4'b0000;
                      ssd_in = 4'b0000;
                  end
      endcase
      
 endmodule

