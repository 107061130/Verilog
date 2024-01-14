module scan(ssd_ctl, ssd_in, control, R, G, B);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input [3:0]R;
    input [3:0]G;
    input [3:0]B;
    input [1:0] control;

    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b1111;
                      ssd_in = 0;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1011;
                      ssd_in = R;
                  end
              2'b10:
                  begin
                      ssd_ctl = 4'b1101;
                      ssd_in = G;
                  end
              2'b11:
                  begin
                      ssd_ctl = 4'b1110;
                      ssd_in = B;
                  end
              default:
                  begin
                      ssd_ctl = 4'b0000;
                      ssd_in = 4'b0000;
                  end
      endcase
      
 endmodule

