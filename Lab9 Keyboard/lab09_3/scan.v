module scan(ssd_ctl, ssd_in, value1, value2, value3, control, state, clk, rst_n);
    output reg [3:0] ssd_in;
    output reg [3:0] ssd_ctl;
    input [13:0]value1;
    input [6:0]value2;
    input [13:0]value3;
    input [1:0] control;
    input [1:0]state;
    input clk;
    input rst_n;
    
    reg [3:0]cnt1;
    reg [3:0]cnt1_temp;
    reg [3:0]cnt2;
    reg [3:0]cnt2_temp;
    reg [3:0]cnt3;
    reg [3:0]cnt3_temp;
    reg [3:0]cnt4;
    reg [3:0]cnt4_temp;
    
    always@*
        case(state)
            2'b00: begin
                cnt4_temp = 4'd0;
                cnt3_temp = 4'd0;
                cnt2_temp = value1 / 4'd10;
                cnt1_temp = value1 % 4'd10; 
            end
            2'b01: begin
                cnt4_temp = 4'd0;
                cnt3_temp = 4'd0;
                cnt2_temp = value2 / 4'd10;
                cnt1_temp = value2 % 4'd10; 
            end
            2'b10: begin
               cnt4_temp = value3 / 10'd1000;
               cnt3_temp = (value3 % 10'd1000) / 10'd100;
               cnt2_temp = (value3 % 10'd100) / 4'd10;
               cnt1_temp = value3 % 4'd10; 
            end
            default: begin
                cnt1_temp = 4'd15;
                cnt2_temp = 4'd15;
                cnt3_temp = 4'd15;
                cnt4_temp = 4'd15; 
            end
        endcase
        
    always@(posedge clk or negedge rst_n)
        if (~rst_n) begin
            cnt1 = 4'd15;
            cnt2 = 4'd15;
            cnt3 = 4'd15;
            cnt4 = 4'd15; 
        end
        else begin
            cnt1 = cnt1_temp;
            cnt2 = cnt2_temp;
            cnt3 = cnt3_temp;
            cnt4 = cnt4_temp;
        end
   
    always@*
        case(control)
              2'b00:
                  begin
                      ssd_ctl = 4'b1110;
                      ssd_in = cnt1;
                  end
              2'b01:
                  begin
                      ssd_ctl = 4'b1101;
                      ssd_in = cnt2;
                  end
              2'b10:
                  begin
                      ssd_ctl = 4'b1011;
                      ssd_in = cnt3;
                  end
              2'b11:
                  begin
                      ssd_ctl = 4'b0111;
                      ssd_in = cnt4;
                  end
              default:
                  begin
                      ssd_ctl = 4'b1111;
                      ssd_in = 4'b1111;
                  end
      endcase
      
 endmodule
