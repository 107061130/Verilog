module FSM(pixel_game, pixel_addr_game, pixel_over, pixel_addr_over, pixel_recorder, pixel_addr_recorder, pixel_title, pixel_addr_title, clk, rst, pixel_addr, pixel, select, LOSE, enter, restart, record, music);
    input [11:0]pixel_game;
    input [16:0]pixel_addr_game;
    input [11:0]pixel_title;
    input [16:0]pixel_addr_title;
    input [11:0]pixel_recorder;
    input [16:0]pixel_addr_recorder;
    input [11:0]pixel_over;
    input [16:0]pixel_addr_over;
    input clk;
    input rst;
    input enter;
    input LOSE;
    input select;
    output reg [16:0]pixel_addr;
    output reg [11:0]pixel;
    output reg restart;
    output reg record;
    output reg music;
    
    reg [1:0]state;
    reg [1:0]next_state;
    reg [16:0]pixel_addr_temp ;
    reg [11:0]pixel_temp ;
    reg restart_temp;
    
    always@*
        case(state)
            2'b00: begin
                if (enter & ~select) begin
                    next_state = 2'b10;
                    restart_temp = 1;
                end
                else if (enter & select) begin 
                    next_state = 2'b01;
                    restart_temp = 1;
                end
                else begin 
                    next_state = state;
                    restart_temp = 1;
                end
                pixel_temp = pixel_title;
                pixel_addr_temp = pixel_addr_title;
                music = 0;
                record = 0;
            end
            2'b01: begin
                if (enter) next_state = 2'b00;
                else next_state = state;
                pixel_temp = pixel_recorder;
                pixel_addr_temp = pixel_addr_recorder;
                restart_temp = 1;
                record = 0;
                music = 0;
            end
            2'b10: begin
                if (LOSE) begin 
                    next_state = 2'b11;
                    record = 1;
                    music = 1; 
                end
                else next_state = state;
                pixel_temp = pixel_game;
                pixel_addr_temp = pixel_addr_game;
                restart_temp = 0;
            end
            2'b11: begin
                if (enter) next_state = 2'b00;
                else next_state = state;
                pixel_temp = pixel_over;
                pixel_addr_temp = pixel_addr_over;  
                record = 0;
                music = 0;              
            end
            default: begin
                next_state = 0;
                pixel_temp = 0;
                pixel_addr_temp = 0;
                restart_temp = 0;
            end
        endcase
    always@(posedge clk or posedge rst)
        if (rst) begin
            state <= 0;
            pixel <= 0;
            pixel_addr <= 0;
            restart <= 1;
        end
        else begin
            state <= next_state;
            pixel = pixel_temp;
            pixel_addr = pixel_addr_temp;
            restart <= restart_temp;
        end
    
endmodule