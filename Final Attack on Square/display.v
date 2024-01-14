`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_10 8'b00010001
`define SS_11 8'b11000001
`define SS_12 8'b11100101
`define SS_13 8'b10000101
`define SS_14 8'b01100001
`define SS_15 8'b01110001

module display(in, D_ssd);
    input [3:0]in;
    output reg [7:0]D_ssd;
    
    always @*
    case (in)
     4'd0: D_ssd = `SS_0;
     4'd1: D_ssd = `SS_1;
     4'd2: D_ssd = `SS_2;
     4'd3: D_ssd = `SS_3;
     4'd4: D_ssd = `SS_4;
     4'd5: D_ssd = `SS_5;
     4'd6: D_ssd = `SS_6;
     4'd7: D_ssd = `SS_7;
     4'd8: D_ssd = `SS_8;
     4'd9: D_ssd = `SS_9;
     4'd10: D_ssd = `SS_10;
     4'd11: D_ssd = `SS_11;
     4'd12: D_ssd = `SS_12;
     4'd13: D_ssd = `SS_13;
     4'd14: D_ssd = `SS_14;
     4'd15: D_ssd = `SS_15;  
     default: D_ssd = 8'b11111111;
    
    endcase
endmodule