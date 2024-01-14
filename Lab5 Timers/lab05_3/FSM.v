module FSM(count_en, in, rst_h, current_state);
    output count_en;
    input in;
    input rst_h;
    output current_state;
    reg state;

    always@(posedge in or posedge rst_h)
    if(rst_h)
        state <= 1'b0;
    else
        state <= ~state;
    
    assign current_state = state;
    assign count_en = state;      
    
endmodule