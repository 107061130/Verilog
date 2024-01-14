module scan(ssd_ctl, ssd_in, hour, min, control);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input [4:0]hour;
    input [5:0]min;
    input [1:0] control;
    
    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b0111;
                      ssd_in = hour / 4'd10;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1011;
                      ssd_in = hour % 4'd10;
                  end
              2'b10:
                  begin
                      ssd_ctl = 4'b1101;
                      ssd_in = min / 4'd10;
                  end
              2'b11:
                  begin
                      ssd_ctl = 4'b1110;
                      ssd_in = min % 4'd10;
                  end
              default:
                  begin
                      ssd_ctl = 4'b0000;
                      ssd_in = 4'b0000;
                  end
      endcase
      
 endmodule

