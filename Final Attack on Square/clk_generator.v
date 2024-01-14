module clk_generator(clk1, clk, rst, clk_1hz, clk_speed2, clk_speed, sec, clk_scan, clk_10hz, clk_100hz, clk23, half);
    input clk;
    input rst;
    input [10:0]sec;
    output reg clk_100hz;
    output clk1;
    output reg clk_speed2;
    output reg clk_1hz;
    output reg clk_speed;
    output reg clk_10hz;
    output [1:0]clk_scan;
    output reg half;
    output clk23;

    reg [26:0] Q;
    reg [26:0] Q_TEMP;
    reg [26:0] K;
    reg [26:0] K_TEMP;
    reg [26:0] C;
    reg [26:0] C_TEMP;
    reg [26:0] H;
    reg [26:0] H_TEMP;
    reg [26:0] A;
    reg [26:0] A_TEMP;
   reg [26:0] S;
    reg [26:0] S_TEMP;
    reg next_half;
    reg next_1;
    reg next_10;
    reg next_speed2;
    reg next_speed;
    reg next_100;

    always @*
        if (Q == 27'd50000000 - 1) begin 
            Q_TEMP = 27'd0;
            next_1 = ~clk_1hz;
        end
        else begin 
            Q_TEMP = Q + 1'b1;
            next_1 = clk_1hz;
        end
        
    always @*
        if (K == 500000 - (2500*sec) - 1) begin 
            K_TEMP = 27'd0;
            next_speed2 = ~clk_speed2;
        end
        else begin 
            K_TEMP = K + 1'b1;
            next_speed2 = clk_speed2;
        end       
    always @*
        if (C == 50000000 - (250000*sec) - 1) begin 
            C_TEMP = 27'd0;
            next_speed = ~clk_speed;
        end
        else begin 
            C_TEMP = C + 1'b1;
            next_speed = clk_speed;
        end           
    always @*
        if (H == 5000000) begin 
            H_TEMP = 27'd0;
            next_10 = ~clk_10hz;
        end
        else begin 
            H_TEMP = H + 1'b1;
            next_10 = clk_10hz;
        end
    always @*
     if (S == 25000000) begin 
            S_TEMP = 27'd0;
          next_half = ~half;
       end
      else begin 
          S_TEMP = S+ 1'b1;
          next_half = half;
       end
    always @*
        if (H == 500000) begin 
            A_TEMP = 27'd0;
            next_100 = ~clk_100hz;
        end
        else begin 
            A_TEMP = A + 1'b1;
            next_100 = clk_100hz;
        end
        
    always@(posedge clk or posedge rst) begin
       if (rst) begin
            Q <= 0;
            K <= 0;
            C <= 0;
            H <= 0;
            A <= 0;
            S <= 0;
            half <= 0;
            clk_1hz <= 0;
            clk_10hz <= 0;
           clk_100hz <= 0;
            clk_speed2 <= 0;
            clk_speed <= 0;
        end
        else begin
            Q <= Q_TEMP;
            K <= K_TEMP;
           S <= S_TEMP;
           half <= next_half;
            C <= C_TEMP;
            H <= H_TEMP;
            A <= A_TEMP;
            clk_1hz <= next_1;;
            clk_10hz <= next_10;
            clk_100hz <= next_100;
            clk_speed2 <= next_speed2;
            clk_speed <= next_speed;
        end
    end
    assign clk1 = Q[1];   
    assign clk_scan = {Q[15],Q[14]};
    assign clk23 = Q[21] && Q[20] && Q[19] && Q[18]&& Q[17]&& Q[16]&& Q[15]&& Q[14]&& Q[13]&& Q[12];

endmodule