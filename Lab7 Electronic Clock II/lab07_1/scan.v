module scan(ssd_ctl, ssd_in, sec1, sec2, min1, min2, control, enable, rst_h);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input [3:0]sec1;
    input [3:0]sec2;
    input [3:0]min1;
    input [3:0]min2;
    input [1:0] control;
    input enable;
    input rst_h;
    
    reg [3:0] cnt1;
    reg [3:0] cnt2;
    reg [3:0] cnt3;
    reg [3:0] cnt4; 
    
    always@* 
        if (rst_h || enable) begin 
            cnt1 = sec1;
            cnt2 = sec2;
            cnt3 = min1;
            cnt4 = min2;  
        end
        else begin
            cnt1 = cnt1;
            cnt2 = cnt2;
            cnt3 = cnt3;
            cnt4 = cnt4;  
        end
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

