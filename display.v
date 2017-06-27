//choice的分别从高到低对应高位数码管->低位数码管
//off 一般为0，为1时候不显示按键。
// IN_off_number: 
module display(input IN_clk, input [15:0] IN_value, input [2:0] IN_off_number, 
					output reg [3:0] OUT_choice, output reg [7:0] OUT_seg);
	reg		[1:0]state;
	reg		[31:0]temp_seg;
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
	parameter DNULL = 8'hFF, D0 = 8'b00000011, D1 = 8'b10011111, D2 = 8'b00100101, D3 = 8'b00001101, D4 = 8'b10011001, D5 = 8'b01001001, D6 = 8'b01000001, D7 = 8'b00011111, D8 = 8'b00000001, D9 = 8'b00001001, DA = 8'b00010001, DB = 8'b11000001, DC = 8'b01100011, DD = 8'b10000101, DE = 8'b01100001, DF = 8'b01110001;
	initial
	begin
		state = 0;
	end
	always @(IN_value or IN_off_number)
	begin
		case(IN_value[3:0])
			4'b0000: 
				begin
					temp_seg[7:0] = D0;
				end
			4'b0001: 
				begin
					temp_seg[7:0] = D1;				
				end
			4'b0010: 
				begin
					temp_seg[7:0] = D2;				
				end
			4'b0011: 
				begin
					temp_seg[7:0] = D3;				
				end
			4'b0100: 
				begin
					temp_seg[7:0] = D4;				
				end
			4'b0101: 
				begin
					temp_seg[7:0] = D5;				
				end
			4'b0110: 
				begin
					temp_seg[7:0] = D6;				
				end
			4'b0111: 
				begin
					temp_seg[7:0] = D7;				
				end
			4'b1000: 
				begin
					temp_seg[7:0] = D8;				
				end
			4'b1001: 
				begin
					temp_seg[7:0] = D9;				
				end
			4'b1010: 
				begin
					temp_seg[7:0] = DA;				
				end
			4'b1011: 
				begin
					temp_seg[7:0] = DB;				
				end
			4'b1100: 
				begin
					temp_seg[7:0] = DC;				
				end
			4'b1101:
				begin
					temp_seg[7:0] = DD;				
				end
			4'b1110: 
				begin
					temp_seg[7:0] = DE;				
				end
			4'b1111: 
				begin
					temp_seg[7:0] = DF;				
				end				
		endcase
		case(IN_value[7:4])
			4'b0000: 
				begin
					temp_seg[15:8] = D0;
				end
			4'b0001: 
				begin
					temp_seg[15:8] = D1;				
				end
			4'b0010: 
				begin
					temp_seg[15:8] = D2;				
				end
			4'b0011: 
				begin
					temp_seg[15:8] = D3;				
				end
			4'b0100: 
				begin
					temp_seg[15:8] = D4;				
				end
			4'b0101: 
				begin
					temp_seg[15:8] = D5;				
				end
			4'b0110: 
				begin
					temp_seg[15:8] = D6;				
				end
			4'b0111: 
				begin
					temp_seg[15:8] = D7;				
				end
			4'b1000: 
				begin
					temp_seg[15:8] = D8;				
				end
			4'b1001: 
				begin
					temp_seg[15:8] = D9;				
				end
			4'b1010: 
				begin
					temp_seg[15:8] = DA;				
				end
			4'b1011: 
				begin
					temp_seg[15:8] = DB;				
				end
			4'b1100: 
				begin
					temp_seg[15:8] = DC;				
				end
			4'b1101:
				begin
					temp_seg[15:8] = DD;				
				end
			4'b1110: 
				begin
					temp_seg[15:8] = DE;				
				end
			4'b1111: 
				begin
					temp_seg[15:8] = DF;				
				end				
		endcase
		case(IN_value[11:8])
			4'b0000: 
				begin
					temp_seg[23:16] = D0;
				end
			4'b0001: 
				begin
					temp_seg[23:16] = D1;				
				end
			4'b0010: 
				begin
					temp_seg[23:16] = D2;				
				end
			4'b0011: 
				begin
					temp_seg[23:16] = D3;				
				end
			4'b0100: 
				begin
					temp_seg[23:16] = D4;				
				end
			4'b0101: 
				begin
					temp_seg[23:16] = D5;				
				end
			4'b0110: 
				begin
					temp_seg[23:16] = D6;				
				end
			4'b0111: 
				begin
					temp_seg[23:16] = D7;				
				end
			4'b1000: 
				begin
					temp_seg[23:16] = D8;				
				end
			4'b1001: 
				begin
					temp_seg[23:16] = D9;				
				end
			4'b1010: 
				begin
					temp_seg[23:16] = DA;				
				end
			4'b1011: 
				begin
					temp_seg[23:16] = DB;				
				end
			4'b1100: 
				begin
					temp_seg[23:16] = DC;				
				end
			4'b1101:
				begin
					temp_seg[23:16] = DD;				
				end
			4'b1110: 
				begin
					temp_seg[23:16] = DE;				
				end
			4'b1111: 
				begin
					temp_seg[23:16] = DF;				
				end				
		endcase
		case(IN_value[15:12])
			4'b0000: 
				begin
					temp_seg[31:24] = D0;
				end
			4'b0001: 
				begin
					temp_seg[31:24] = D1;				
				end
			4'b0010: 
				begin
					temp_seg[31:24] = D2;				
				end
			4'b0011: 
				begin
					temp_seg[31:24] = D3;				
				end
			4'b0100: 
				begin
					temp_seg[31:24] = D4;				
				end
			4'b0101: 
				begin
					temp_seg[31:24] = D5;				
				end
			4'b0110: 
				begin
					temp_seg[31:24] = D6;				
				end
			4'b0111: 
				begin
					temp_seg[31:24] = D7;				
				end
			4'b1000: 
				begin
					temp_seg[31:24] = D8;				
				end
			4'b1001: 
				begin
					temp_seg[31:24] = D9;				
				end
			4'b1010: 
				begin
					temp_seg[31:24] = DA;				
				end
			4'b1011: 
				begin
					temp_seg[31:24] = DB;				
				end
			4'b1100: 
				begin
					temp_seg[31:24] = DC;				
				end
			4'b1101:
				begin
					temp_seg[31:24] = DD;				
				end
			4'b1110: 
				begin
					temp_seg[31:24] = DE;				
				end
			4'b1111: 
				begin
					temp_seg[31:24] = DF;				
				end				
		endcase
		case(IN_off_number)
		3'b000: 	temp_seg = temp_seg;
		3'b001:	temp_seg = {DNULL,temp_seg[23:0]};
		3'b010:	temp_seg = {DNULL,DNULL,temp_seg[15:0]};
		3'b011:	temp_seg = {DNULL,DNULL,DNULL,temp_seg[7:0]};
		default: temp_seg = {DNULL,DNULL,DNULL,DNULL};
		endcase
	end
	
	always @ (state or temp_seg) begin
		case (state)
			S0:
			begin
				OUT_choice = 4'b0001;
				OUT_seg = temp_seg[7:0];
			end
			S1:
			begin
				OUT_choice = 4'b0010;
				OUT_seg = temp_seg[15:8];
			end
			S2:
			begin
				OUT_choice = 4'b0100;
				OUT_seg = temp_seg[23:16];
			end
			S3:
			begin
				OUT_choice = 4'b1000;
				OUT_seg = temp_seg[31:24];
			end
			default:
				OUT_choice = 4'b0001;
		endcase
	end
	
	always @ (posedge IN_clk) begin
			case (state)
				S0:
					state <= S1;
				S1:
					state <= S2;
				S2:
					state <= S3;
				S3:
					state <= S0;
			endcase
	end

					
endmodule
