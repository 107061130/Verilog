module main(clk, rst_n, ssd, light);
    input clk;
    input rst_n;
    output [7:0]ssd;
    output [3:0]light;
    wire [2:0]word;
    wire [1:0]clk_scan;
    wire clk_d;
    wire [2:0]in0;
    wire [2:0]in1;
    wire [2:0]in2;
    wire [2:0]in3;
    
    f U0(.clk(clk), 
        .rst_n(rst_n), 
        .clk_out(clk_d), 
        .clk_out2(clk_scan)
        );
    rshifter U1(.clk(clk_d), 
                .rst_n(rst_n), 
                .q0(in0), 
                .q1(in1), 
                .q2(in2), 
                .q3(in3)
                );
    scan U2(.in0(in0), 
            .in1(in1), 
            .in2(in2), 
            .in3(in3), 
            .clk_scan(clk_scan), 
            .light(light), 
            .word(word)
            );
    display U3(.in(word), .D_ssd(ssd));
endmodule

module f(clk, rst_n, clk_out, clk_out2);
    reg [25:0]q;
    input clk;
    input rst_n;
    output reg clk_out;
    output reg [1:0]clk_out2;
    reg [26:0]q_temp;
    
    always @*
        q_temp = {clk_out, q} + 1'b1;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) q <= 0;
        else {clk_out, q} <= q_temp;
    end
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) clk_out2 <= 2'b00;
        else clk_out2 <= {q[15], q[14]};
    end
   
endmodule

module rshifter(clk, rst_n, q0, q1, q2, q3);
    input clk;
    input rst_n;
    output reg [2:0]q0;
    output reg [2:0]q1;
    output reg [2:0]q2; 
    output reg [2:0]q3;
    reg [2:0]q4;
    reg [2:0]q5;
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n) begin
            q0 <= 3'd0;
            q1 <= 3'd1;
            q2 <= 3'd2;
            q3 <= 3'd3;
            q4 <= 3'd4;
            q5 <= 3'd4;
        end
        else begin
            q0 <= q1;
            q1 <= q2;
            q2 <= q3;
            q3 <= q4;
            q4 <= q5;
            q5 <= q0;
        end
endmodule

module scan(in0, in1, in2, in3, clk_scan, light, word);
    input [2:0]in0;
    input [2:0]in1;
    input [2:0]in2;
    input [2:0]in3;
    input [1:0]clk_scan;
    output reg [3:0]light;
    output reg [2:0]word;
    
    always @*
        case (clk_scan)
        2'b00: begin
            light = 4'b0111;
            word = in0;
        end 
        2'b01: begin
            light = 4'b1011;
            word = in1;
        end 
        2'b10: begin
            light = 4'b1101;
            word = in2;
        end
        2'b11: begin
            light = 4'b1110;
            word = in3;
        end
        default: begin 
            light = 1111;
            word = 3'b111;
        end  
        endcase
endmodule

module display(in, D_ssd);
    input [2:0]in;
    output reg [7:0]D_ssd;
    always@*
        case(in)
            3'd0:D_ssd = 8'b11010101;   //N
            3'd1:D_ssd = 8'b11100001;   //T
            3'd2:D_ssd = 8'b10010001;   //H
            3'd3:D_ssd = 8'b10000011;   //U
            3'd4:D_ssd = 8'b01100001;   //E
            default:D_ssd=8'b00000000;
        endcase
        
endmodule

