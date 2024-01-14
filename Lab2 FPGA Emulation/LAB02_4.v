module LAB02_4(A, B, X, a, b);
    input [3:0]A, B;
    output reg X;
    output [3:0]a;
    output [3:0]b;
    
    always @* begin
        if (A > B) X = 1;
        else X = 0;
    end
    assign a = A;
    assign b = B;
    
endmodule