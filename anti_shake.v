//s0 key = 0，但是值还是原来的值
//s1 key = 1，
// 将键盘输出的按键信号信号变成一个周期的，值信号超前

module anti_shake(input IN_clk, input [3:0] IN_value, input IN_key,
					output reg [3:0] OUT_value, output reg OUT_key);
	reg [3:0] temp_value;
	reg state;
	parameter s0 = 0, s1 = 1;
	
	always@(*)
	begin
		OUT_value = IN_value;
	end
	
	always @(posedge IN_clk)
	begin
		if(IN_key)
			state <= s1;
		else
			state <= s0;
	end
	
	always @(posedge IN_clk)
	begin
	case(state)
	s0:begin
		temp_value <= IN_value;
		//OUT_key <= IN_key;
		if(temp_value == IN_value)
		begin
//			OUT_value <= IN_value; 
			OUT_key <= IN_key; 
		end
		else
		begin
//			OUT_value <= IN_value;  // 可能修改
			OUT_key <= 1; 
		end
		end
	s1:begin
		temp_value <= IN_value;
		//OUT_key <= IN_key;
		if(temp_value == IN_value)
		begin
//			OUT_value <= IN_value; 
			OUT_key <= 0; 
		end
		else
		begin
//			OUT_value <= IN_value; // 可能修改
			OUT_key <= 1; 
		end
		end
	endcase
	end
	
	
endmodule
	