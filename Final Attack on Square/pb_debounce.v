module debounce(clk, pb_in, pb_debounced, rst_n);
    output reg pb_debounced;  
    input clk;  
    input pb_in;  
    input rst_n;
    
    reg [3:0]debounce_window;  
    wire pb_debounced_next;  
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n) debounce_window <= 0;
        else debounce_window <= {debounce_window[2:0],pb_in};
            
    assign pb_debounced_next = debounce_window[3] & debounce_window[2] & debounce_window[1] & debounce_window[0];
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n) pb_debounced <= 0;
        else pb_debounced <= pb_debounced_next;
     
endmodule

