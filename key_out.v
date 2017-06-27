// s0等待输入
// s1前一个数
// s2符号
// s3后一个数字
// flag 表示数量
// 
module key_out(input IN_clk, input [3:0] IN_value, input IN_key, input IN_reset,
              output reg [7:0] OUT_SRCH, output reg [7:0] OUT_SRCL, output reg [7:0] OUT_DSTH, output reg [7:0] OUT_DSTL, output reg [3:0] OUT_ALU_OP, output reg OUT_finish, output reg [1:0] OUT_state);

	reg [15:0] temp1 = 0; //用于第一个数
	reg [15:0] temp2 = 0; //用于第二个数
	reg [1:0] flag = 0;
	reg [1:0] state = 0;
	parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3;
	
	always @(posedge IN_clk or negedge IN_reset)
	begin
		if(!IN_reset)
			begin
				state = s0;
				temp1 = 16'b0;
				temp2 = 16'b0;
				flag = 2'b0;
				OUT_finish = 1'b0;
				OUT_ALU_OP = 0;
			end
		else if(IN_key)
			case(state)
				s0: begin
					if(IN_value == 4'hF)
					begin
						state = s0;
						temp1 = 16'b0;
						temp2 = 16'b0;
						flag = 2'b0;
						OUT_finish = 1'b0;
						OUT_ALU_OP = 0;
					end
					else if(IN_value > 4'h9)
					begin
						temp1 = 16'b0;
						state = s2;
						OUT_ALU_OP = IN_value;
						flag = 2'b00;
						temp2 = 8'b0;
					end
					else
					begin
					if(flag < 2'd3)
					begin
						temp1 = temp1 * 4'd10+ IN_value;
						flag = flag + 2'b01;
					end
					else
					begin
						temp1 = temp1;
						flag = flag;
					end	
					state = s1;	
					end
						
						
				end
				s1: begin
					if(IN_value == 4'hF)
						state = s1;
					else if(IN_value > 4'h9)
					begin
						state = s2;
						OUT_ALU_OP = IN_value;
						flag = 2'b00;
						temp2 = 8'b0;
					end
					else
					begin
						state = s1;
						if(flag < 2'd3)
							begin
								temp1 = temp1 * 4'd10 + IN_value;
								flag = flag + 2'b01;
							end
							else
							begin
								temp1 = temp1;
								flag = flag;
							end		
					end
				end
				s2:begin
					if(IN_value == 4'hF)
						state = s2;
					else if(IN_value > 4'h9)
					begin
						OUT_ALU_OP = IN_value;
						state = s2;
					end
					else
						begin
						state = s3;
						if(flag < 2'd3)
						begin
							temp2 = temp2 * 4'd10 + IN_value;
							flag = flag + 2'b01;
						end
						else
						begin
							temp2 = temp2;
							flag = flag;
						end	
						end
				end
				s3:begin
				if(IN_value == 4'hF)
				begin
					OUT_finish = 1'b1;
					state = s0;
					OUT_ALU_OP = OUT_ALU_OP;
				end
				else if(IN_value > 4'h9)
					begin
						state = s3;
					end
				else
					if(flag < 2'd3)
					begin
						temp2 = temp2 * 4'd10 + IN_value;
						flag = flag + 2'b01;
					end
					else
					begin
						temp2 = temp2;
						flag = flag;
					end		
				end
			endcase
		else
		begin
			case(state)
			s0:begin state = s0; OUT_finish = 0; OUT_ALU_OP = 0; flag = 2'b0; temp1 = 16'b0; temp2 = 16'b0;end
			s1:state = s1;
			s2:state = s2;
			s3:state = s3;
			default:state = s0;
			endcase
		end
		{OUT_SRCH,OUT_SRCL} = temp1;
		{OUT_DSTH,OUT_DSTL} = temp2;
		OUT_state = state;
	end
	
	/*
	always @(state)
	begin
	case(state)
		s0:begin
			temp1 = 16'b0;
			temp2 = 16'b0;
		end
		s1:
		begin
		if(flag < 2'd3)
			begin
				temp1 = temp1 * 4'd10+ IN_value;
				flag = flag + 2'b01;
			end
			else
			begin
				temp1 = temp1;
				flag = flag;
			end		
		end
		s2:begin
			OUT_ALU_OP = IN_value;
			flag = 2'b00;
			temp2 = 8'b0;
		end
		s3:begin
		if(flag < 2'd3)
			begin
				temp2 = temp2 * 4'd10 + IN_value;
				flag = flag + 2'b01;
			end
			else
			begin
				temp2 = temp2;
				flag = flag;
			end		
		end
	endcase 
	end
	*/			  
endmodule 