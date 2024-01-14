module value(value, ASM, key_down, last_change, rst_n, key_valid, clk);
    output reg [3:0]value;
    output reg [3:0]ASM;
    input [511:0]key_down;
    input [8:0]last_change;
    input rst_n;
    input key_valid;
    input clk;
    reg [3:0]value_temp;
    reg [3:0]ASM_TEMP;
    
    
    always@*
        if (key_valid)
            case(last_change)
                9'h070: begin
                    value_temp = 4'd0;
                    ASM_TEMP = ASM;
                end
                9'h069: begin
                    value_temp = 4'd1;
                    ASM_TEMP = ASM;
                    ASM_TEMP = ASM;
                end
                9'h072: begin
                    value_temp = 4'd2;
                    ASM_TEMP = ASM;
                end
                9'h07A: begin
                    value_temp = 4'd3;
                    ASM_TEMP = ASM;    
                end       
                9'h06B: begin
                    value_temp = 4'd4;
                    ASM_TEMP = ASM;
                end
                9'h073: begin 
                    value_temp = 4'd5;
                    ASM_TEMP = ASM;
                end
                9'h074: begin
                    value_temp = 4'd7;    
                    ASM_TEMP = ASM;
                end
                9'h075: begin 
                    value_temp = 4'd8;
                    ASM_TEMP = ASM; 
                end 
                9'h07D: begin 
                    value_temp = 4'd9;
                    ASM_TEMP = ASM;
                end
                9'h079: begin 
                    value_temp = value;
                    ASM_TEMP = 4'd0;
                end
                9'h07B: begin
                    value_temp = value; 
                    ASM_TEMP = 4'd1;
                end
                9'h07C: begin 
                    value_temp = value;
                    ASM_TEMP = 4'd2;
                end
                9'h05A: begin
                    ASM_TEMP = 4'd15;
                    value_temp=4'd15;
                end
                default: begin 
                    value_temp = value;
                    ASM_TEMP = ASM;
                end    
        endcase
    else begin
        value_temp = value;
        ASM_TEMP = ASM;
    end
     
     always@(posedge clk or negedge rst_n)
            if(~rst_n) begin 
                value <=4'd15;
                ASM <= 4'd15;
            end
            else begin
                value <=value_temp;
                ASM <= ASM_TEMP;      
            end

endmodule