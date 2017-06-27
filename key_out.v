// s0等待输入
// s1前一个数
// s2符号
// s3后一个数字
// flag 表示数量
module key_out(input IN_clk, input [3:0] IN_value, input IN_key, input IN_reset,
              output reg [7:0] OUT_SRCH, output reg [7:0] OUT_SRCL, output reg [7:0] OUT_DSTH, output reg [7:0] OUT_DSTL, output reg [3:0] OUT_ALU_OP, output reg OUT_finish);


	reg [15:0] temp = 0;
	reg [1:0] flag = 0;
	
	always @(posedge IN_clk or negedge IN_reset)
	begin
		if(!IN_reset)
			state = s0;
		else if(IN_key)
			case(state)
				s0: begin
					if(IN_value > 4'h9)
					begin
						OUT_SRCL = 
					end
					state = s1;
				end
				s1: begin
					if(IN_value > 4'h9)
					begin
						state = s2;
						OUT_ALU_OP = IN_value;
					end
					else
					begin
					if(flag < 2'd3)
					begin
						temp = temp * 3'd10 + IN_value;
						flag = flag + 2'b01;
					end
					else
					begin
						temp = temp;
						flag = flag;
					end
					end
				end
		else
		
			endcase
		
	end
				  
endmodule 