module addr_assign(clk, rst, valid, ASD, neg, h_cnt, v_cnt, value1_1, value1_2, value1_3, value1_4, value2_1, value2_2, value3_1, value3_2, value3_3, value3_4, addr);
    input clk;
    input rst;
    input valid;
    input [1:0]ASD;
    input neg; 
    input [9:0]h_cnt;
    input [9:0]v_cnt;
    input [3:0]value1_1, value1_2, value1_3, value1_4;
    input [3:0]value2_1, value2_2;
    input [3:0]value3_1, value3_2, value3_3, value3_4;
    output reg [16:0]addr;
    reg [16:0]addr_temp;
    
    always@*
        if (h_cnt >= 10'd50 && h_cnt < 10'd100 && v_cnt >= 10'd50 && v_cnt < 10'd150) addr_temp = value1_4 * 5000 + (h_cnt - 50) + 50*(v_cnt - 50);
        else if (h_cnt >= 10'd125 && h_cnt < 10'd175 && v_cnt >= 10'd50 && v_cnt < 10'd150) addr_temp = value1_3 * 5000 + (h_cnt - 125) + 50*(v_cnt - 50);
        else if (h_cnt >= 10'd200 && h_cnt < 10'd250 && v_cnt >= 10'd50 && v_cnt < 10'd150) addr_temp = value1_2 * 5000 + (h_cnt - 200) + 50*(v_cnt - 50);
        else if (h_cnt >= 10'd275 && h_cnt < 10'd325 && v_cnt >= 10'd50 && v_cnt < 10'd150) addr_temp = value1_1 * 5000 + (h_cnt - 275) + 50*(v_cnt - 50);
        else if (h_cnt >= 10'd350 && h_cnt < 10'd450 && v_cnt >= 10'd50 && v_cnt < 10'd150) addr_temp = 50000 + 10000*ASD + (h_cnt - 350) + 100*(v_cnt - 50);
        else if (h_cnt >= 10'd475 && h_cnt < 10'd525 && v_cnt >= 10'd50 && v_cnt < 10'd150) addr_temp = value2_2 * 5000 + (h_cnt - 475) + 50*(v_cnt - 50);
        else if (h_cnt >= 10'd550 && h_cnt < 10'd600 && v_cnt >= 10'd50 && v_cnt < 10'd150) addr_temp = value2_1 * 5000 + (h_cnt - 550) + 50*(v_cnt - 50);
        else if (h_cnt >= 10'd50 && h_cnt < 10'd150 && v_cnt >= 10'd200 && v_cnt < 10'd300) addr_temp = 80000 + (h_cnt - 50) + 100*(v_cnt - 200);
        else if (h_cnt >= 10'd175 && h_cnt < 10'd275 && v_cnt >= 10'd200 && v_cnt < 10'd300 && neg) addr_temp = 60000 + (h_cnt - 175) + 100*(v_cnt - 200);
        else if (h_cnt >= 10'd300 && h_cnt < 10'd350 && v_cnt >= 10'd200 && v_cnt < 10'd300) addr_temp = value3_4 * 5000 + (h_cnt - 300) + 50*(v_cnt - 200);
        else if (h_cnt >= 10'd375 && h_cnt < 10'd425 && v_cnt >= 10'd200 && v_cnt < 10'd300) addr_temp = value3_3 * 5000 + (h_cnt - 375) + 50*(v_cnt - 200);
        else if (h_cnt >= 10'd450 && h_cnt < 10'd500 && v_cnt >= 10'd200 && v_cnt < 10'd300) addr_temp = value3_2 * 5000 + (h_cnt - 450) + 50*(v_cnt - 200);
        else if (h_cnt >= 10'd525 && h_cnt < 10'd575 && v_cnt >= 10'd200 && v_cnt < 10'd300) addr_temp = value3_1 * 5000 + (h_cnt - 525) + 50*(v_cnt - 200);
        else addr_temp = 16'd1995;
        
        always@(posedge clk)
            if (rst || !valid) addr <= 16'd0;
            else addr <= addr_temp;
endmodule