module SETTING(min, hour, set, add, value_min, mode, value_hour, clk);
    input [5:0]min;
    input [4:0]hour;
    input set;
    input add;
    input mode;
    input clk;
    output reg [5:0]value_min;
    output reg [4:0]value_hour;
    reg [5:0]value_min_temp;
    reg [4:0]value_hour_temp;
    
    always@*
        if (~set) begin
            value_min_temp = min;
            value_hour_temp = hour;
        end
        else if (set && add && mode == 0)
            if (value_min == 6'd59) value_min_temp = 0;
            else value_min_temp = value_min + 1'b1;
        else if (set && add && mode)
            if (value_hour == 5'd23) value_hour_temp = 0;
            else value_hour_temp = value_hour + 1'b1;
        else begin
            value_min_temp = value_min;
            value_hour_temp = value_hour;
        end
        
    always@(posedge clk) begin
        value_min = value_min_temp;
        value_hour = value_hour_temp;
    end
    
endmodule