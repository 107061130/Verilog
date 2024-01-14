module FSM_mode(in, rst_h, state);
    input in;
    input rst_h;
    output reg [1:0]state;
  
    always@(posedge in or posedge rst_h) 
        if (rst_h) state <= 2'b00;
        else state <= state + 1'b1;
    
endmodule