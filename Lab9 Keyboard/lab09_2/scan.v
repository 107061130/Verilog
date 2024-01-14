module scan(ssd_ctl, ssd_in, value1, value2, value3, control);
    output reg [6:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input [6:0]value1;
    input [3:0]value2;
    input [6:0]value3;
    input [1:0] control;
    
    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b1110;
                      ssd_in = value3 % 4'd10;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1101;
                      ssd_in = value3 / 4'd10;
                  end
              2'b10:
                  begin
                      ssd_ctl = 4'b1011;
                      ssd_in = value2;
                  end
              2'b11:
                  begin
                      ssd_ctl = 4'b0111;
                      ssd_in = value1;
                  end
              default:
                  begin
                      ssd_ctl = 4'b1111;
                      ssd_in = 4'b1111;
                  end
      endcase
      
 endmodule
