module gameover_music(clk, clk_05Hz, rst, note_div);
    input clk;
    input clk_05Hz;
    input rst;
    output reg [21:0]note_div;    
parameter None = 4'b0000;
parameter E5 = 4'b0001;
parameter G4 = 4'b0010;
parameter E4 = 4'b0011;
parameter B4 = 4'b0100;
parameter A4 = 4'b0101;
parameter A4b = 4'b0110;
parameter B4b = 4'b0111;
parameter D4 = 4'b1000;
wire [21:0] note_None = 22'd0;
wire [21:0] note_E5 = 22'd95556;//50000000/523.25
wire [21:0] note_G4 = 22'd127551;//50000000/392
wire [21:0] note_E4 = 22'd191109;//50000000/261.63
wire [21:0] note_A4 = 22'd113636;//50000000/440
wire [21:0] note_B4 = 22'd101239;//50000000/493.88
wire [21:0] note_A4b = 22'd120394;//50000000/415.3
wire [21:0] note_B4b = 22'd107259;//50000000/466.16
wire [21:0] note_D4 = 22'd170264;//50000000/293.66
reg [4:0]count;
reg [4:0]count_temp;
reg [3:0]state_temp;
reg [3:0]state;
reg [21:0]note_div_temp;

always @*
    if(count != 20) count_temp = count + 1;
    else count_temp = count;
always@*    
    case(state)
        None:
        begin
            note_div_temp = note_None;
            if (count == 3) state_temp = G4;
            else if (count == 6) state_temp = E4;
            else state_temp = state; 
        end
        E5:
        begin
            note_div_temp = note_E5;
            if (count == 1) state_temp = None;
            else state_temp = state;
        end
        G4:
        begin
            note_div_temp = note_G4;
            if (count == 4) state_temp = None;
            else state_temp = state;
        end
        E4:
        begin
            note_div_temp = note_E4;
            if (count == 8) state_temp = A4;
            else if (count == 18) state_temp = D4;
            else if (count == 20) state_temp = None;
            else state_temp = state;
        end
        A4:
        begin
            note_div_temp = note_A4;
            if (count == 9) state_temp = B4;
            else if (count == 12) state_temp = A4b;
            else state_temp = state;
        end
        B4:
        begin
            note_div_temp = note_B4;
            if (count == 10) state_temp = A4;
            else state_temp = state;
        end
        A4b:
        begin
            note_div_temp = note_A4b;
            if (count == 14) state_temp = B4b;
            else if(count == 17) state_temp = E4;
            else state_temp = state;
        end
        B4b:
        begin
            note_div_temp = note_B4b;
            if (count == 16) state_temp = A4b;
            else state_temp = state;
        end
        D4:
        begin
            note_div_temp = note_D4;
            if (count == 19) state_temp = E4;
            else state_temp = state;
        end
        default:
        begin
           note_div_temp = 0;
           state_temp = None;  
        end
   endcase  
   always@(posedge clk or posedge rst)
     if (rst) begin
        state <= E5;
        note_div <= note_E5;
     end
     else begin
        state <= state_temp;
        note_div <= note_div_temp;
    end    
    always@(posedge clk_05Hz or posedge rst)
        if(rst) count <= 0;
        else count = count_temp;
                             
endmodule