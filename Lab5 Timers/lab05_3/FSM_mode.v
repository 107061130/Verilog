module FSM_mode(in, rst, out);
    input in;
    input rst;
    output reg [3:0]out;
    reg state;
    reg state_next; 
    
    always@* state = state_next;
    always@(posedge in) state_next <= ~state;
    
    always@*
        if (state) out = 4'b0110;
        else out = 4'b0011;
    
endmodule