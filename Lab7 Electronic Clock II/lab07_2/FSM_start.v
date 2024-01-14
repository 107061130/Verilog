module FSM_start(in, rst_n, state);
    input in;
    input rst_n;
    output reg state;
  
    always@(posedge in or negedge rst_n) 
        if (~rst_n) state <= 1'b0;
        else state <= ~state;
    
endmodule