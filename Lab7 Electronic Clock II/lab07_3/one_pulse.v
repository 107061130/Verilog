module one_pulse(out_pulse, clk, in_trig, rst_n);
    output reg out_pulse; 
    input clk;  
    input in_trig;  
    input rst_n;
    
    reg in_trig_delay;
    wire one_pulse_next;
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n) in_trig_delay <= 0;
        else in_trig_delay <= in_trig;
               
    assign one_pulse_next = in_trig & (~in_trig_delay);
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n) out_pulse <= 0;
        else out_pulse <= one_pulse_next;
 endmodule
