module FSM_CAP(in, rst_n, state);
    input in;
    input rst_n;
    output reg state;
    
    always@(posedge in or negedge rst_n)
        if (~rst_n) state <= 0;
        else state <= ~state;

endmodule