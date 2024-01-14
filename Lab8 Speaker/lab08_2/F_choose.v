module F_choose(DO, RE, MI, DIV);
    input DO;
    input RE;
    input MI;
    output reg [21:0]DIV;
    
    always@*
        if (DO) DIV = 22'd191131;
        else if (RE) DIV = 22'd170241;
        else if (MI) DIV = 22'd151699;
        else DIV = 22'd0;
    
endmodule