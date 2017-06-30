// s0等待输入
// s1前一个数
// s2符号
// s3后一个数字
//OUT_flag 表示数量

module key_out(input IN_clk, input [3:0] IN_value, input IN_key, input IN_reset, input IN_control, input [15:0] IN_ans,
					output reg [7:0] OUT_SRCH, output reg [7:0] OUT_SRCL, output reg [7:0] OUT_DSTH, output reg [7:0] OUT_DSTL, 
					output reg [3:0] OUT_ALU_OP, output reg OUT_finish, output reg [1:0] OUT_state, output reg [1:0] OUT_flag);

	reg [15:0] temp1 = 0; //用于第一个数
	reg [15:0] temp2 = 0; //用于第二个数
	reg [3:0] temp_op = 0; //符号
	reg [63:0] number_stack = 0;
	reg [31:0] op_stack =0;
	reg [3:0] number_flag = 0;
	reg [1:0] state = 0;
	reg [1:0] ans_delay = 0;
	parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3;
	// 待添加 新变量清零清零
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
						temp1 = IN_ans;       //上一次运算结果可能过来  debug
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
					ans_delay = 2;
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
						state = s0;
					else
						state = s3;
				end
				default:state = s0;
				endcase
			end
		{OUT_SRCH,OUT_SRCL} = temp1;  //这个放在这儿肯定有问题 debug fixing
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
						temp2 = 8'b0;
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
					//没有考虑两次弹出情况（2周期输出结果不允许） 考虑还需要在该条件下计数延迟两周期 或者在IN_key的else后增加一些东西 (debug ok)
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
								OUT_finish = 1;      // 待解决问题，置回来(ok),符号加入
								number_flag = number_flag - 2;
								ans_delay = 3;
							end
						end

						temp2 =  IN_value;
						OUT_flag =  2'b01;

						if(ans_delay != 3)
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
		//换一种写法
		//			{OUT_DSTH,OUT_DSTL} = temp2;
		//						{OUT_SRCH,OUT_SRCL} = number_stack[15:0];   //？？？？
		//						number_stack = number_stack >> 5'd16;    //???
					{op_stack,OUT_ALU_OP} = {op_stack,OUT_ALU_OP} >> 4;
					OUT_finish = 1;
					number_flag = number_flag - 2;
					ans_delay = 3;
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
						{number_stack,temp1} = {number_stack,IN_ans} << 16;
						number_flag = number_flag + 1;
						if(number_flag >= 4'b0010)
						begin
							if(priority(op_stack[3:0]) >= priority(temp_op))
							begin
//								{number_stack,OUT_DSTH,OUT_DSTL} = {number_stack,OUT_DSTH,OUT_DSTL} >> 16;
								{number_stack,OUT_SRCH,OUT_SRCL} = {number_stack,OUT_SRCH,OUT_SRCL} >> 16;
								{OUT_DSTH,OUT_DSTL} = IN_ans;
								{op_stack,OUT_ALU_OP} = {op_stack,OUT_ALU_OP} >> 4;
								OUT_finish = 1;      // 待解决问题，置回来(ok)
								number_flag = number_flag - 2; // 
								ans_delay = 3;
							end
						end
//						{number_stack,temp1} = {number_stack,IN_ans} << 16;
						if(ans_delay != 3)
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
						ans_delay = 0;
						{number_stack,temp1} = {number_stack,IN_ans} << 16;
						number_flag = number_flag + 1;
						if(number_flag != 1)  //if中是非阻塞的，错的
						begin
						//	{number_stack,OUT_DSTH,OUT_DSTL} = {number_stack,OUT_DSTH,OUT_DSTL} >> 16;
							{number_stack,OUT_SRCH,OUT_SRCL} = {number_stack,OUT_SRCH,OUT_SRCL} >> 16;
							{OUT_DSTH,OUT_DSTL} = IN_ans;
							{op_stack,OUT_ALU_OP} = {op_stack,OUT_ALU_OP} >> 4;
							OUT_finish = 1;
							number_flag = number_flag - 2;
							ans_delay = 3;
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