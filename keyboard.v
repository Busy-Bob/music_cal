// 位数按照从左到右,从上到下
// s0 起始状态
// s1 第一列 1 4 7 0（从上到下） 
// s2 第二列 2 5 8 =(F)
// s3 第三列 3 6 9 cmp(E)
// s4 第四列 +(A) -(B) and(C) or(D) 
// 
module keyboard(input IN_clk, input[3:0] IN_row,
					output reg [3:0] OUT_col, output reg [7:0] OUT_SRCH, output reg [7:0] OUT_SRCL, output reg [7:0] OUT_DSTH, output reg [7:0] OUT_SRCL, output reg [7:0] OUT_ALU_OP, output reg OUT_finish);

	// Declare state register
	reg	[2:0] state = 0;
	reg [3:0] data = 0;
	reg key = 0;
	
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;

	always @ (posedge IN_clk) 
	begin
			case (state)
				S0:
					begin
						if(IN_row[1])
						begin
							state = S1;
						end
						else if(IN_row[2])
						begin
							state = S2;
						end
						else if(IN_row[3])
						begin
							state = S3;
						end
						else if(IN_row[4])
						begin
							state = S4;
						end
						else
						begin
							state = S0;
							key = 1'b0;
							data = data;
							OUT_col = 4'b1111;
						end					
					end
				S1:
					begin
						key = 1'b0;
						if(IN_row[4])
							state = S1;
						else
							state = S0;
					end
				S2:
					begin
						key = 1'b0;
						if(IN_row[3])
							state = S2;
						else
							state = S0;
					end
				S3:
					begin
						key = 1'b0;
						if(IN_row[2])
							state = S3;
						else
							state = S0;
					end
				S4:
					begin
						key = 1'b0;
						if(IN_row[1])
							state = S4;
						else
							state = S0;
					end
				default:
					begin
						key = 1'b0;
						data = 4'b0000;
						OUT_col = 4'b1111;
						state = S0;
					end
			endcase
	end

	// Determine the output based only on the current state
	// and the input (do not wait for a clock edge).
	// always @ (state or IN_reset or IN_row)
	always @ (state)
	begin
		//OUT_value <= OUT_value;
		begin
			case (state)
				S0：
				begin
					key = 1'b0;
					OUT_col = 4'b1111;
				end
				S1:
					case(IN_row)
						4'b1000: begin OUT_value <= 1; OUT_key <= 1; flag <= 0; end
						4'b0100: begin OUT_value <= 4; OUT_key <= 1; flag <= 0; end
						4'b0010: begin OUT_value <= 7; OUT_key <= 1; flag <= 0; end
						4'b0001: begin OUT_value <= 0; OUT_key <= 1; flag <= 0; end
						default: begin 
							OUT_value <= OUT_value; 
							if(flag != 3)begin
								OUT_key <= OUT_key; 
								flag <= flag + 1;
							end
							else
							begin
								OUT_key <= 0;
								flag <= 0;
							end
						end
					endcase
				S1:
					case(IN_row)
						4'b1000: begin OUT_value <= 2; OUT_key <= 1; flag <= 0; end
						4'b0100: begin OUT_value <= 5; OUT_key <= 1; flag <= 0; end
						4'b0010: begin OUT_value <= 8; OUT_key <= 1; flag <= 0; end
						4'b0001: begin OUT_value <= 15; OUT_key <= 1; flag <= 0; end
						default: begin 
							OUT_value <= OUT_value; 
							if(flag != 3)begin
								OUT_key <= OUT_key; 
								flag <= flag + 1;
							end
							else
							begin
								OUT_key <= 0;
								flag <= 0;
							end
						end
					endcase
				S2:
					case(IN_row)
						4'b1000: begin OUT_value <= 3; OUT_key <= 1; flag <= 0; end
						4'b0100: begin OUT_value <= 6; OUT_key <= 1; flag <= 0; end
						4'b0010: begin OUT_value <= 9; OUT_key <= 1; flag <= 0; end
						4'b0001: begin OUT_value <= 14; OUT_key <= 1; flag <= 0; end
						default: begin 
							OUT_value <= OUT_value; 
							if(flag != 3)begin
								OUT_key <= OUT_key; 
								flag <= flag + 1;
							end
							else
							begin
								OUT_key <= 0;
								flag <= 0;
							end
						end
					endcase
					
				S3:
					case(IN_row)
						4'b0001: begin OUT_value <= 13; OUT_key <= 1; flag <= 0; end
						default: begin 
							OUT_value <= OUT_value; 
							if(flag != 3)begin
								OUT_key <= OUT_key; 
								flag <= flag + 1;
							end
							else
							begin
								OUT_key <= 0;
								flag <= 0;
							end
						end
					endcase
				default:
					begin OUT_value <= 0; OUT_key <= 0; end
			endcase
		end

/*
	always @(IN_reset)
	begin
	if(IN_reset)
		deassign OUT_value;
	else
		assign OUT_value = 0;
	end
*/
end
	endmodule
