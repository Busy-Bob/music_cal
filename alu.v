// s0 第一列 1 4 7 0（从上到下） 
// s1 第二列 2 5 8 =(F)
// s2 第三列 3 6 9 cmp(E)
// s3 第四列 +(A) -(B) and(C) or(D) 

//carry_in是carry_out回来的值，和运算上次有进位的时候为1，差运算上一次有借位的时候为0
//carry_out  小于是1，进位是1，借位是0，其他0
//OUT_zero比较时候0，其他时候为0就是为1
//比较时候s是减法结果结果

module alu(input [3:0] IN_CS, input [7:0] IN_data_a, input [7:0] IN_data_b, input IN_carry_in,
			output reg [7:0] OUT_S, output reg OUT_zero, output reg OUT_carry_out);
	
	always @(*)
	begin
	if(IN_CS == 4'hA)
	begin
		{OUT_carry_out,OUT_S} = IN_data_a + IN_data_b + IN_carry_in;
		if(OUT_S == 0)
			OUT_zero = 1'b1;
		else
			OUT_zero = 1'b0;
	end
	else if(IN_CS == 4'hB)
	begin
		{OUT_carry_out,OUT_S} = IN_data_a - IN_data_b - !IN_carry_in;
		OUT_carry_out = ~OUT_carry_out;
		if(OUT_S == 0)
			OUT_zero = 1'b1;
		else
			OUT_zero = 1'b0;
	end
	else if(IN_CS == 4'hC)
	begin
		OUT_S = IN_data_a & IN_data_b;
		OUT_carry_out = 0;
		if(OUT_S == 0)
			OUT_zero = 1'b1;
		else
			OUT_zero = 1'b0;
	end
	else if(IN_CS == 4'hD)
	begin
		OUT_S = IN_data_a | IN_data_b;
		OUT_carry_out = 0;
		if(OUT_S == 0)
			OUT_zero = 1'b1;
		else
			OUT_zero = 1'b0;
	end
	else if(IN_CS == 4'hE)
		begin
		{OUT_carry_out,OUT_S} = IN_data_a - IN_data_b;
		OUT_zero = 1'b0;
		end
	else
		begin
			OUT_carry_out = 0;
			OUT_S = 0;
			OUT_zero = 0;
		end
	end
	
endmodule 