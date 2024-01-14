module check(in1, in2, out);
    input [3:0]in1;
    input [3:0]in2;
    output reg out;
    
    always @*
        if (in1 == 4'b0000 && in2 == 4'b0000) out = 1;
        else out = 0;
    
endmodule