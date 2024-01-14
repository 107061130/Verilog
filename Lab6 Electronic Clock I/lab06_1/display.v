module display(D_ssd, in);
    input [3:0] in;
    output reg [7:0] D_ssd;
    
    
    always @*
        case(in)
            4'd0: D_ssd = 8'b00000011;
            4'd1: D_ssd = 8'b10011111;
            4'd2: D_ssd = 8'b00100101;
            4'd3: D_ssd = 8'b00001101;
            4'd4: D_ssd = 8'b10011001;
            4'd5: D_ssd = 8'b01001001;
            4'd6: D_ssd = 8'b01000001;
            4'd7: D_ssd = 8'b00011111;
            4'd8: D_ssd = 8'b00000001;
            4'd9: D_ssd = 8'b00001001;
            4'd10: D_ssd = 8'b00010001;
            4'd11: D_ssd = 8'b00110001;
            4'd12: D_ssd = 8'b11010101;
            default: D_ssd = 8'b11111110;
    endcase
    
endmodule
