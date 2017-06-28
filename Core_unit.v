// s0: 还在输入中，没有按下等于
// s1: 第一次alu运算
// s2: 第二次alu运算
// s3: 算出结果值暂存

// 对于IN_state而言
// s0等待输入
// s1前一个数
// s2符号
// s3后一个数字

// s0 第一列 1 4 7 0（从上到下） 
// s1 第二列 2 5 8 =(F)
// s2 第三列 3 6 9 cmp(E)
// s3 第四列 +(A) -(B) and(C) or(D) 

// debug 比较的时候不显示数字
// 回去s0的条件是输入状态非s0；
module Core_unit(input IN_clk, input IN_carry_in, input [7:0] IN_SRCH, input [7:0] IN_SRCL, input [7:0] IN_DSTH, input [7:0] IN_DSTL, 
						input [7:0] IN_S, input [3:0] IN_ALU_OP, input IN_finish, input [1:0] IN_state, input [1:0] IN_flag, input IN_zero,
						output reg [15:0] OUT_value, output reg [2:0] OUT_off_number, output reg [7:0] OUT_data_a, output reg [7:0] OUT_data_b,
						output reg [3:0] OUT_ALU_OP, output reg OUT_carry_out, output reg OUT_neg_ans, output reg OUT_less_than, output reg OUT_zero, output reg [1:0] OUT_state);

	reg [7:0] temp_h1 = 0;
	reg [7:0] temp_h2 = 0;
	reg [3:0] temp_op = 0;
	reg [15:0] temp_ans = 0;
	reg temp_zero = 0;
	reg [1:0] state = 0;
	reg flag = 0; // 用于检测是否在结果之后再次按了一个符号
	parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3;
	// 输出变量清零 waiting
	always @(posedge IN_clk)
	begin
	OUT_state = state;
	case(state)
		s0:begin
			if(IN_finish)
			begin
				if(IN_ALU_OP == 4'hB || IN_ALU_OP == 4'hE)
					OUT_carry_out = 1'b1;
				else
					OUT_carry_out = 1'b0;
				temp_op = IN_ALU_OP;
				OUT_ALU_OP = IN_ALU_OP;
				state = s1;
				if(!flag)
				begin
					OUT_data_a = IN_SRCL;
					OUT_data_b = IN_DSTL;
					temp_h1 = IN_SRCH;
					temp_h2 = IN_DSTH;
				end
				else
				begin
					OUT_data_a = temp_ans[7:0];
					OUT_data_b = IN_DSTL;
					temp_h1 = temp_ans[15:8];
					temp_h2 = IN_DSTH;
				end

			end
			else
/*			begin
				if(flag)
				begin
				case(IN_state)
					s0:begin
						OUT_off_number = 3'b100;
					end
					s1:begin
						OUT_value = {IN_SRCH,IN_SRCL};
						OUT_off_number = 3'b100 - IN_flag;
					end
					s2:begin
						OUT_value = temp_ans;
						OUT_off_number = OUT_off_number;
					end
					s3:begin
						OUT_value = {IN_DSTH,IN_DSTL};
						OUT_off_number = 3'b100 - IN_flag;
					end
				endcase
				OUT_data_a = 0;
				OUT_data_b = 0;
				OUT_ALU_OP = 0;
				OUT_carry_out = 0;
				OUT_neg_ans = 0;
				OUT_less_than = 0;
				OUT_zero = 0;
				temp_ans = 0;
				temp_h1 = 0;
				temp_h2 = 0;
				temp_op = 0;
				temp_zero = 0;
				temp_carry_in = 0;
				state = s0;
				end
				else */
				begin
				case(IN_state)
					s0:begin
						OUT_off_number = 3'b100;
					end
					s1:begin
						OUT_value = {IN_SRCH,IN_SRCL};
						OUT_off_number = 3'b100 - IN_flag;
					end
					s2:begin
						OUT_value = OUT_value;
						OUT_off_number = OUT_off_number;
					end
					s3:begin
						OUT_value = {IN_DSTH,IN_DSTL};
						OUT_off_number = 3'b100 - IN_flag;
					end
				endcase
				OUT_data_a = 0;
				OUT_data_b = 0;
				OUT_ALU_OP = 0;
				OUT_carry_out = 0;
				OUT_neg_ans = 0;
				OUT_less_than = 0;
				OUT_zero = 0;
				temp_h1 = 0;
				temp_h2 = 0;
				temp_op = 0;
				temp_zero = 0;
				state = s0;
			end
		end
		s1:begin
			case(temp_op)
				4'hA:begin
					OUT_carry_out = IN_carry_in;
					OUT_value[7:0] = IN_S;
				end
				4'hB:begin
					OUT_carry_out = IN_carry_in;
					OUT_value[7:0] = IN_S;
				end				
				4'hC:begin
					OUT_value[7:0] = IN_S;
				end		
				4'hD:begin
					OUT_value[7:0] = IN_S;
				end
				4'hE:begin
					OUT_carry_out = !IN_carry_in;
					OUT_value[7:0] = IN_S;
				end
				default:begin
					OUT_value[7:0] = IN_S;
				end
			endcase
			flag = 0;
			temp_ans = 0;
			temp_zero = IN_zero;
			OUT_data_a = temp_h1;
			OUT_data_b = temp_h2;
			OUT_ALU_OP = temp_op;
			state = s2;
		end
		s2:begin
			if(temp_zero && IN_zero)
				OUT_zero = 1'b1;
			else
				OUT_zero = 1'b0;
			case(temp_op)
				4'hA:begin
					OUT_value[15:8] = IN_S;
				end
				4'hB:begin
					OUT_value[15:8] = IN_S; //若为负数，输出结果为补码
					if(OUT_value[15])
						OUT_neg_ans = 1'b1;
					else
						OUT_neg_ans = 1'b0;
				end
				4'hC:begin
					OUT_value[15:8] = IN_S;
				end
				4'hD:begin
					OUT_value[15:8] = IN_S;
					if(OUT_value == 0)
						OUT_zero = 1'b1;
					else
						OUT_zero = 1'b0;
				end
				4'hE:begin
					OUT_value[15:8] = IN_S;
					if(IN_carry_in)
						OUT_less_than = 1'b1;
//					else if(IN_value == 0)
//						OUT_less_than = 1'b1;
					else
						OUT_less_than = 1'b0;
					if(OUT_value[15])   //由于有位运算，所以不能加在后面
						OUT_neg_ans = 1'b1;
					else
						OUT_neg_ans = 1'b0;
				end
				default:begin
				// 待加
				end
			endcase
			if(OUT_value[15])
				OUT_neg_ans = 1'b1;
			else
				OUT_neg_ans = 1'b0;
			temp_ans = OUT_value;
			if(OUT_value[15])
				OUT_value = ~OUT_value + 1;
			else
				OUT_value = OUT_value;
			if(OUT_value >= 1000)
				OUT_off_number = 0;
			else if(OUT_value >= 100)
				OUT_off_number = 3'd1;
			else if(OUT_value >= 10)
				OUT_off_number = 3'd2;
			else
				OUT_off_number = 3'd3;
			state = s3;
		end
		s3:begin
			OUT_value = OUT_value;
			OUT_off_number = OUT_off_number;
			OUT_carry_out = OUT_carry_out;
			OUT_neg_ans = OUT_neg_ans;
			OUT_less_than = OUT_less_than;
			OUT_zero = OUT_zero;
			if(IN_state == s2)
			begin
				state = s0;
				flag = 1'b1;
			end
			else if(IN_state != s0 || IN_flag != 0)
			begin
				state = s0;
				flag = 0;
			end
			else
				state = s3;
		end
		default:
		begin
			state = s0;
			flag = 0;
		end
	
	endcase 
	end
	
						
						
endmodule 