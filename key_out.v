// s0绛夊緟杈撳叆
// s1鍓嶄竴涓暟
// s2绗﹀彿
// s3鍚庝竴涓暟瀛//OUT_flag 琛ㄧず鏁伴噺

module key_out(input IN_clk, input [3:0] IN_value, input IN_key, input IN_reset, input IN_control, input [15:0] IN_ans,
					output reg [7:0] OUT_SRCH, output reg [7:0] OUT_SRCL, output reg [7:0] OUT_DSTH, output reg [7:0] OUT_DSTL, 
					output reg [3:0] OUT_ALU_OP, output reg OUT_finish, output reg [1:0] OUT_state, output reg [1:0] OUT_flag, output reg [3:0] OUT_calculating);

	reg [15:0] temp1 = 0; //鐢ㄤ簬绗竴涓暟
	reg [15:0] temp2 = 0; //鐢ㄤ簬绗簩涓暟
	reg [3:0] temp_op = 0; //绗﹀彿
	reg [63:0] number_stack = 0;
	reg [31:0] op_stack =0;
	reg [3:0] number_flag = 0;
	reg [1:0] state = 0;
	reg [2:0] ans_delay = 0;
	parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3;
	// 寰呮坊鍔鏂板彉閲忔竻闆舵竻闆	
	always @(posedge IN_clk or negedge IN_reset)
	begin
	
		if(!IN_reset)
			begin
				state = s0;
				temp1 = 16'b0;
				temp2 = 16'b0;
				temp_op = 0;
				number_flag = 0;
				op_stack = 0;
				number_stack = 0;
				OUT_flag = 2'b11;
				OUT_finish = 1'b0;
				OUT_ALU_OP = 0;
				OUT_calculating = 0;
			end
		else if(IN_control)
		begin
			if(IN_key)
			case(state)
				s0: begin
					if(IN_value == 4'hF)
					begin
						state = s0;
						temp_op = 0;
						temp1 = 16'b0;
						temp2 = 16'b0;
						OUT_flag = 2'b0;
						OUT_finish = 1'b0;
						OUT_ALU_OP = 0;
					end
					else if(IN_value > 4'h9)
					begin
						temp1 = IN_ans;       //涓婁竴娆¤繍绠楃粨鏋滃彲鑳借繃鏉 debug
						OUT_ALU_OP = IN_value;
						OUT_flag = 2'b00;
						temp2 = 16'b0;
						state = s2;
					end
					else
					begin
					if(OUT_flag < 2'd3)
					begin
						temp1 = temp1 * 4'd10+ IN_value;
						OUT_flag =OUT_flag + 2'b01;
					end
					else
					begin
						temp1 = temp1;
						OUT_flag =OUT_flag;
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
						OUT_flag = 2'b00;
						temp2 = 16'b0;
					end
					else
					begin
						state = s1;
						if(OUT_flag < 2'd3)
							begin
								temp1 = temp1 * 4'd10 + IN_value;
								OUT_flag =OUT_flag + 2'b01;
							end
							else
							begin
								temp1 = temp1;
								OUT_flag =OUT_flag;
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
						if(OUT_flag < 2'd3)
						begin
							temp2 = temp2 * 4'd10 + IN_value;
							OUT_flag =OUT_flag + 2'b01;
						end
						else
						begin
							temp2 = temp2;
							OUT_flag =  OUT_flag;
						end	
						end
				end
				s3:begin
				if(IN_value == 4'hF)
				begin
					OUT_finish = 1'b1;
					state = s0;
					OUT_flag = 0;
					OUT_ALU_OP = OUT_ALU_OP;
					ans_delay = 4;
					OUT_calculating = 1;
				end
				else if(IN_value > 4'h9)
					begin
						state = s3;
					end
				else
					if(OUT_flag < 2'd3)
					begin
						temp2 = temp2 * 4'd10 + IN_value;
						OUT_flag =OUT_flag + 2'b01;
					end
					else
					begin
						temp2 = temp2;
						OUT_flag =OUT_flag;
					end		
				end
			endcase
			else
			begin
				case(state)
				s0:begin 
					state = s0; 
					OUT_finish = 0; 
					OUT_ALU_OP = 0;
					OUT_flag = 2'b0; 
					temp1 = 16'b0; 
					temp2 = 16'b0;
					number_flag = 0;
					op_stack = 0;
					temp_op = 0;
					number_stack = 0;
					ans_delay = 0;
				end
				s1:state = s1;
				s2:state = s2;
				s3:begin
					if(ans_delay >= 2)
					begin
						ans_delay = ans_delay - 1;
						state = s3;
					end
					else if(ans_delay == 1)
					begin
						state = s0;
						OUT_calculating = 0;
						ans_delay = 0;
					end
					else
						state = s3;
				end
				default:state = s0;
				endcase
			end
		{OUT_SRCH,OUT_SRCL} = temp1;  //杩欎釜鏀惧湪杩欏効鑲畾鏈夐棶棰debug fixing
		{OUT_DSTH,OUT_DSTL} = temp2;
		end
		else
		begin
			if(IN_key)
			case(state)
				s0: begin
				if(IN_value == 4'hF)
					begin
						state = s0;
						temp1 = 16'b0;
						temp2 = 16'b0;
						OUT_flag = 2'b0;
						OUT_finish = 1'b0;
						OUT_ALU_OP = 0;
					end
					else if(IN_value > 4'h9)
					begin
						temp1 = 16'b0;
						OUT_ALU_OP = IN_value;
						OUT_flag = 2'b00;
						temp2 = 16'b0;
						state = s2;
					end
					else
					begin
					if(OUT_flag < 2'd3)
					begin
						temp1 = temp1 * 4'd10+ IN_value;
						OUT_flag =OUT_flag + 2'b01;
					end
					else
					begin
						temp1 = temp1;
						OUT_flag =OUT_flag;
					end
					state = s1;	
					{OUT_SRCH,OUT_SRCL} = temp1; 
					{OUT_DSTH,OUT_DSTL} = temp2;
					end
				end
				s1:begin
					if(IN_value == 4'hF)
						state = s1;
					else if(IN_value > 4'h9)
					begin
						state = s2;
						temp_op = IN_value;
						number_flag = 2'b01;
						number_stack[15:0] = temp1;
						OUT_flag = 2'b00;
						temp2 = 16'b0;
					end
					else
					begin
						state = s1;
						if(OUT_flag < 2'd3)
							begin
								temp1 = temp1 * 4'd10 + IN_value;
								OUT_flag =OUT_flag + 2'b01;
							end
							else
							begin
								temp1 = temp1;
								OUT_flag =OUT_flag;
							end		
					end
					{OUT_SRCH,OUT_SRCL} = temp1; 
					{OUT_DSTH,OUT_DSTL} = temp2;
				end
				s2:begin
					if(IN_value == 4'hF)
						state = s2;
					else if(IN_value > 4'h9)
					begin 					
						temp_op = IN_value;
						state = s2;
					end
					else
					//娌℃湁鑰冭檻涓ゆ寮瑰嚭鎯呭喌锛鍛ㄦ湡杈撳嚭缁撴灉涓嶅厑璁革級 鑰冭檻杩橀渶瑕佸湪璇ユ潯浠朵笅璁℃暟寤惰繜涓ゅ懆鏈鎴栬€呭湪IN_key鐨別lse鍚庡鍔犱竴浜涗笢瑗(debug ok)
					begin
						// if(state3tostate2_flag)
						// begin
							// {number_stack,temp2} = {number_stack,temp2} << 16;
							// number_flag = number_flag + 1;
						// end
						if(number_flag >= 4'b0010)
						begin
							if(priority(op_stack[3:0]) >= priority(temp_op))
							begin
								{number_stack,OUT_DSTH,OUT_DSTL} = {number_stack,OUT_DSTH,OUT_DSTL} >> 16;
								{number_stack,OUT_SRCH,OUT_SRCL} = {number_stack,OUT_SRCH,OUT_SRCL} >> 16;
								{op_stack,OUT_ALU_OP} = {op_stack,OUT_ALU_OP} >> 4;
								OUT_finish = 1;      // 寰呰В鍐抽棶棰橈紝缃洖鏉ok),绗﹀彿鍔犲叆
								OUT_calculating = number_flag - 1;
								number_flag = number_flag - 2;
								ans_delay = 4;
							end
						end

						temp2 =  IN_value;
						OUT_flag =  2'b01;

						if(ans_delay != 4)
						begin
							{op_stack,temp_op} = {op_stack,temp_op} << 4;
//							state = s3;
							state = s3;
						end
						else
						begin
							state = s2;
						end
					end
						

				end
				s3:begin			
				if(IN_value == 4'hF)
				begin
					{number_stack,temp2} = {number_stack,temp2} << 16;
					OUT_flag = 0;
					number_flag = number_flag + 1;
		
					{number_stack,OUT_DSTH,OUT_DSTL} = {number_stack,OUT_DSTH,OUT_DSTL} >> 16;
					{number_stack,OUT_SRCH,OUT_SRCL} = {number_stack,OUT_SRCH,OUT_SRCL} >> 16; 
		//鎹竴绉嶅啓娉		//			{OUT_DSTH,OUT_DSTL} = temp2;
		//						{OUT_SRCH,OUT_SRCL} = number_stack[15:0];   //锛燂紵锛燂紵
		//						number_stack = number_stack >> 5'd16;    //???
					{op_stack,OUT_ALU_OP} = {op_stack,OUT_ALU_OP} >> 4;
					OUT_finish = 1;
					OUT_calculating = number_flag - 1;
					number_flag = number_flag - 2;
					ans_delay = 4;
					
		//						state = s3;
					state = s3;
					
				end
				else if(IN_value > 4'h9)
					begin
						state = s2;
						{number_stack,temp2} = {number_stack,temp2} << 16;
						temp_op = IN_value;
						number_flag = number_flag + 1;
					end
				else
					if(OUT_flag < 2'd3)
					begin
						temp2 = temp2 * 4'd10 + IN_value;
						OUT_flag =OUT_flag + 2'b01;
					end
					else
					begin
						temp2 = temp2;
						OUT_flag = OUT_flag;
					end
				//{OUT_DSTH,OUT_DSTL} = temp2;
				end
			endcase
			else
			begin
				case(state)
				s0:begin 
					state = s0; 
					OUT_finish = 0; 
					OUT_ALU_OP = 0;
					OUT_flag = 2'b0; 
					temp1 = 16'b0; 
					temp2 = 16'b0;
					number_flag = 0;
					op_stack = 0;
					temp_op = 0;
					number_stack = 0;
					ans_delay = 0;
					OUT_calculating = 0;
				end
				s1:state = s1;
				s2:begin
					if(ans_delay >= 2)
					begin
						ans_delay = ans_delay - 1;
						state = s2;
						OUT_finish = 0;
					end
					else if(ans_delay == 1)
					begin
						ans_delay = 0;
						OUT_calculating = 0;
						{number_stack,temp1} = {number_stack,IN_ans} << 16;
						number_flag = number_flag + 1;
						if(number_flag >= 4'b0010)
						begin
							if(priority(op_stack[3:0]) >= priority(temp_op))
							begin
								{number_stack,OUT_DSTH,OUT_DSTL} = {number_stack,OUT_DSTH,OUT_DSTL} >> 16;
								{number_stack,OUT_SRCH,OUT_SRCL} = {number_stack,OUT_SRCH,OUT_SRCL} >> 16;
//								{OUT_DSTH,OUT_DSTL} = IN_ans;
								{op_stack,OUT_ALU_OP} = {op_stack,OUT_ALU_OP} >> 4;
								OUT_finish = 1;      // 寰呰В鍐抽棶棰橈紝缃洖鏉ok)
								OUT_calculating = number_flag - 1;
								number_flag = number_flag - 2; // 
								ans_delay = 4;
							end
						end
//						{number_stack,temp1} = {number_stack,IN_ans} << 16;
						if(ans_delay != 4)
						begin
							state = s3;
							{op_stack,temp_op} = {op_stack,temp_op} << 4;
						end
					end
					else
					begin
						state = s2;
						OUT_finish = 0;
					end
				end
				s3:
				begin
					{OUT_DSTH,OUT_DSTL} = temp2;
					if(ans_delay == 0)
					begin
						state = s3;
						OUT_finish = 0;
						OUT_calculating = 0;
//						if(OUT_flag == 0)
//							OUT_flag = 1;
					end
					else if(ans_delay >= 2)
					begin
						OUT_finish = 0;
						state = s3;
						ans_delay = ans_delay - 1;
					end
					else
					begin
	//					ans_delay = 0;
						{number_stack,temp1} = {number_stack,IN_ans} << 16;
						number_flag = number_flag + 1;
						if(number_flag >= 2)  //if涓槸闃诲鐨						
						begin
							{number_stack,OUT_DSTH,OUT_DSTL} = {number_stack,OUT_DSTH,OUT_DSTL} >> 16;
							{number_stack,OUT_SRCH,OUT_SRCL} = {number_stack,OUT_SRCH,OUT_SRCL} >> 16;
							//{OUT_DSTH,OUT_DSTL} = IN_ans;
							{op_stack,OUT_ALU_OP} = {op_stack,OUT_ALU_OP} >> 4;
							OUT_finish = 1;
							OUT_calculating = number_flag - 1;
							number_flag = number_flag - 2;
							ans_delay = 4;
							state = s3;
						end
						else
						begin
							OUT_finish = 0;
							state = s0;
						end
					end
				
				end
				default:state = s0;
				endcase
			end
			
		end

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
		if(OUT_flag < 2'd3)
			begin
				temp1 = temp1 * 4'd10+ IN_value;
				OUT_flag =OUT_flag + 2'b01;
			end
			else
			begin
				temp1 = temp1;
				OUT_flag =OUT_flag;
			end		
		end
		s2:begin
			OUT_ALU_OP = IN_value;
			OUT_flag = 2'b00;
			temp2 = 8'b0;
		end
		s3:begin
		if(OUT_flag < 2'd3)
			begin
				temp2 = temp2 * 4'd10 + IN_value;
				OUT_flag =OUT_flag + 2'b01;
			end
			else
			begin
				temp2 = temp2;
				OUT_flag =OUT_flag;
			end		
		end
	endcase 
	end
	*/		

	function [1:0] priority;
	input [3:0] op;
	begin
		if(op == 4'hE)
			priority = 2'h3;
		else if(op == 4'hC || op == 4'hD)
			priority = 2'h2;
		else
			priority = 2'h1;
	end
	endfunction
endmodule 