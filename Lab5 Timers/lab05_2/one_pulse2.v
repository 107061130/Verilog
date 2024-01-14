module one_pulse2(out_pulse, clk,  in_trig);
    output reg out_pulse; 
    input clk;  
    input in_trig;  
    
    reg in_trig_delay;
    wire one_pulse_next;
    
    always@(posedge clk)
     in_trig_delay <= in_trig;
               
    assign one_pulse_next = in_trig & in_trig_delay;
    
    always@(posedge clk)
        out_pulse <= one_pulse_next;
 endmodule
