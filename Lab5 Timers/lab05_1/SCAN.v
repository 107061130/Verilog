module scan(ssd_ctl, ssd_in, cnt1, cnt2, control);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input [3:0] cnt1;
    input [3:0] cnt2;
    input [1:0] control;
    
    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b0111;
                      ssd_in = 4'b0000;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1011;
                      ssd_in = 4'b0000;
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

