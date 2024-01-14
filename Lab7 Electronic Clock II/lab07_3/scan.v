module scan(ssd_ctl, ssd_in, min, hour, control, enable, rst_n);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input [5:0]min;
    input [4:0]hour;
    input [1:0] control;
    input enable;
    input rst_n;
    
    reg [3:0] cnt1;
    reg [3:0] cnt2;
    reg [3:0] cnt3;
    reg [3:0] cnt4; 
    
    always@* 
        if (~rst_n || enable) begin 
            cnt1 = min % 4'd10;
            cnt2 = min / 4'd10;
            cnt3 = hour % 4'd10;
            cnt4 = hour / 4'd10;  
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

