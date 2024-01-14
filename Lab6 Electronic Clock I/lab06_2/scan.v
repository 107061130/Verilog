module scan(ssd_ctl, ssd_in, date, month, year, control, change);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input change;
    input [4:0]date;
    input [3:0]month;
    input [6:0]year;
    input [1:0] control;
    
    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b0111;
                      if (change) ssd_in = month / 4'd10;
                      else ssd_in = 4'b0000;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1011;
                      if (change) ssd_in = month % 4'd10;
                      else ssd_in = 4'b0000;
                  end
              2'b10:
                  begin
                      ssd_ctl = 4'b1101;
                      if (change) ssd_in = date / 4'd10;
                      else ssd_in = year / 4'd10;
                  end
              2'b11:
                  begin
                      ssd_ctl = 4'b1110;
                      if (change) ssd_in = date % 4'd10;
                      else ssd_in = year % 4'd10;
                  end
              default:
                  begin
                      ssd_ctl = 4'b0000;
                      ssd_in = 4'b0000;
                  end
      endcase
      
 endmodule




