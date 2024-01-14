module DECORDER(LED, last_change, key_down, CAP, clk, rst_n);
    input clk;
    input rst_n;;
    input [8:0]last_change;
    input [511:0]key_down;
    input CAP;
    output reg [6:0]LED;
    reg [6:0]LED_TEMP;
    
    always@*
        if (CAP) begin
            if (key_down[9'h012] || key_down[9'h059])
                case (last_change) 
                    9'h01C: LED_TEMP = 7'd65 + 7'd32;
                    9'h032: LED_TEMP = 7'd66 + 7'd32;       
                    9'h021: LED_TEMP= 7'd67 + 7'd32;
                    9'h023: LED_TEMP = 7'd68 + 7'd32;
                    9'h024: LED_TEMP = 7'd69 + 7'd32;
                    9'h02B: LED_TEMP = 7'd70 + 7'd32;
                    9'h034: LED_TEMP = 7'd71 + 7'd32;
                    9'h033: LED_TEMP = 7'd72 + 7'd32;
                    9'h043: LED_TEMP = 7'd73 + 7'd32;
                    9'h03B: LED_TEMP = 7'd74 + 7'd32;
                    9'h042: LED_TEMP = 7'd75 + 7'd32;
                    9'h04B: LED_TEMP = 7'd76 + 7'd32;
                    9'h03A: LED_TEMP = 7'd77 + 7'd32;
                    9'h031: LED_TEMP = 7'd78 + 7'd32;
                    9'h044: LED_TEMP = 7'd79 + 7'd32;
                    9'h04D: LED_TEMP = 7'd80 + 7'd32;
                    9'h015: LED_TEMP = 7'd81 + 7'd32;
                    9'h02D: LED_TEMP = 7'd82 + 7'd32;
                    9'h01B: LED_TEMP = 7'd83 + 7'd32;
                    9'h02C: LED_TEMP = 7'd84 + 7'd32;
                    9'h03C: LED_TEMP = 7'd85 + 7'd32;
                    9'h02A: LED_TEMP = 7'd86 + 7'd32;
                    9'h01D: LED_TEMP = 7'd87 + 7'd32;
                    9'h022: LED_TEMP = 7'd88 + 7'd32;
                    9'h035: LED_TEMP = 7'd89 + 7'd32;
                    9'h01A: LED_TEMP = 7'd90 + 7'd32;
                    default: LED_TEMP = 7'd0;            
                endcase
            else begin
                case (last_change) 
                    9'h01C: LED_TEMP = 7'd65;
                    9'h032: LED_TEMP = 7'd66;       
                    9'h021: LED_TEMP = 7'd67;
                    9'h023: LED_TEMP = 7'd68;
                    9'h024: LED_TEMP = 7'd69;
                    9'h02B: LED_TEMP = 7'd70;
                    9'h034: LED_TEMP = 7'd71;
                    9'h033: LED_TEMP = 7'd72;
                    9'h043: LED_TEMP = 7'd73;
                    9'h03B: LED_TEMP = 7'd74;
                    9'h042: LED_TEMP = 7'd75;
                    9'h04B: LED_TEMP = 7'd76;
                    9'h03A: LED_TEMP = 7'd77;
                    9'h031: LED_TEMP = 7'd78;
                    9'h044: LED_TEMP = 7'd79;
                    9'h04D: LED_TEMP = 7'd80;
                    9'h015: LED_TEMP = 7'd81;
                    9'h02D: LED_TEMP = 7'd82;
                    9'h01B: LED_TEMP = 7'd83;
                    9'h02C: LED_TEMP = 7'd84;
                    9'h03C: LED_TEMP = 7'd85;
                    9'h02A: LED_TEMP = 7'd86;
                    9'h01D: LED_TEMP = 7'd87;
                    9'h022: LED_TEMP = 7'd88;
                    9'h035: LED_TEMP = 7'd89;
                    9'h01A: LED_TEMP = 7'd90;
                    default: LED_TEMP = 7'd0;            
                endcase
            end
        end
        else begin
            if (key_down[9'h012] || key_down[9'h059]) begin
                case (last_change) 
                    9'h01C: LED_TEMP = 7'd65;
                    9'h032: LED_TEMP = 7'd66;       
                    9'h021: LED_TEMP = 7'd67;
                    9'h023: LED_TEMP = 7'd68;
                    9'h024: LED_TEMP = 7'd69;
                    9'h02B: LED_TEMP = 7'd70;
                    9'h034: LED_TEMP = 7'd71;
                    9'h033: LED_TEMP = 7'd72;
                    9'h043: LED_TEMP = 7'd73;
                    9'h03B: LED_TEMP = 7'd74;
                    9'h042: LED_TEMP = 7'd75;
                    9'h04B: LED_TEMP = 7'd76;
                    9'h03A: LED_TEMP = 7'd77;
                    9'h031: LED_TEMP = 7'd78;
                    9'h044: LED_TEMP = 7'd79;
                    9'h04D: LED_TEMP = 7'd80;
                    9'h015: LED_TEMP = 7'd81;
                    9'h02D: LED_TEMP = 7'd82;
                    9'h01B: LED_TEMP = 7'd83;
                    9'h02C: LED_TEMP = 7'd84;
                    9'h03C: LED_TEMP = 7'd85;
                    9'h02A: LED_TEMP = 7'd86;
                    9'h01D: LED_TEMP = 7'd87;
                    9'h022: LED_TEMP = 7'd88;
                    9'h035: LED_TEMP = 7'd89;
                    9'h01A: LED_TEMP = 7'd90;
                    default: LED_TEMP = 7'd0;            
                endcase
            end
            else begin
                case (last_change) 
                    9'h01C: LED_TEMP = 7'd65 + 7'd32;
                    9'h032: LED_TEMP = 7'd66 + 7'd32;       
                    9'h021: LED_TEMP = 7'd67 + 7'd32;
                    9'h023: LED_TEMP = 7'd68 + 7'd32;
                    9'h024: LED_TEMP = 7'd69 + 7'd32;
                    9'h02B: LED_TEMP = 7'd70 + 7'd32;
                    9'h034: LED_TEMP = 7'd71 + 7'd32;
                    9'h033: LED_TEMP = 7'd72 + 7'd32;
                    9'h043: LED_TEMP = 7'd73 + 7'd32;
                    9'h03B: LED_TEMP = 7'd74 + 7'd32;
                    9'h042: LED_TEMP = 7'd75 + 7'd32;
                    9'h04B: LED_TEMP = 7'd76 + 7'd32;
                    9'h03A: LED_TEMP = 7'd77 + 7'd32;
                    9'h031: LED_TEMP = 7'd78 + 7'd32;
                    9'h044: LED_TEMP = 7'd79 + 7'd32;
                    9'h04D: LED_TEMP = 7'd80 + 7'd32;
                    9'h015: LED_TEMP = 7'd81 + 7'd32;
                    9'h02D: LED_TEMP = 7'd82 + 7'd32;
                    9'h01B: LED_TEMP = 7'd83 + 7'd32;
                    9'h02C: LED_TEMP = 7'd84 + 7'd32;
                    9'h03C: LED_TEMP = 7'd85 + 7'd32;
                    9'h02A: LED_TEMP = 7'd86 + 7'd32;
                    9'h01D: LED_TEMP = 7'd87 + 7'd32;
                    9'h022: LED_TEMP = 7'd88 + 7'd32;
                    9'h035: LED_TEMP = 7'd89 + 7'd32;
                    9'h01A: LED_TEMP = 7'd90 + 7'd32;
                    default: LED_TEMP = 7'd0;
                endcase
            end
        end
        
        always@(posedge clk or negedge rst_n)
            if (~rst_n || ~key_down[last_change]) LED <= 7'd0;
            else LED <= LED_TEMP;
endmodule
