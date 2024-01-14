module FSM_APM(in, rst_h, state);
    input in;
    input rst_h;
    output reg state;
  
    always@(posedge in or posedge rst_h) 
        if (rst_h) state <= 1'b0;
        else state <= ~state;
    
endmodule