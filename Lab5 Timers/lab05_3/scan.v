module scan(ssd_ctl, ssd_in, cnt1, cnt2, control);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input [3:0] cnt1;
    input [3:0] cnt2;
    input [1:0] control;
    
    reg [3:0]one;
    reg [3:0]tenth;
    reg min;
    
    always@* 
        if (cnt1 == 4'b0000 && cnt2 == 4'b0110) begin
            one = 4'b0000;
            tenth = 4'b0000;
            min = 1'b1; 
        end
        else begin
            one = cnt1;
            tenth = cnt2;
            min = 1'b0; 
        end
    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b0111;
                      ssd_in = min;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1011;
                      ssd_in = 4'b1111;
                  end
              2'b10:
                  begin
                      ssd_ctl = 4'b1101;
                      ssd_in = tenth;
                  end
              2'b11:
                  begin
                      ssd_ctl = 4'b1110;
                      ssd_in = one;
                  end
              default:
                  begin
                      ssd_ctl = 4'b0000;
                      ssd_in = 4'b0000;
                  end
      endcase
 endmodule

