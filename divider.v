//1 250HZ
//2 200HZ
//3 50HZ
//4 1HZ

module divider(input IN_clk, output reg OUT_clk1/*,output reg OUT_clk2,output reg OUT_clk3, output reg OUT_clk4*/);
	integer n1 = 0;
//	integer n2 = 0;
//	integer n3 = 0;
//	integer n4 = 0;
	
	initial                                                
begin                                                                       
   OUT_clk1 = 0;
//	OUT_clk2 = 0;
//	OUT_clk3 = 0;
//	OUT_clk4 = 0;
end
	always @(posedge IN_clk)
		begin
			n1 = n1 + 1;
//			n2 = n2 + 1;
//			n3 = n3 + 1;
//			n4 = n4 + 1;
			if(n1 >= 50000)
				begin
					OUT_clk1 = ~OUT_clk1;
					n1 = 0;
				end
			else
				OUT_clk1 = OUT_clk1;
/*
				if(n2 >= 62500)
				begin
					OUT_clk2 = ~OUT_clk2;
					n2 = 0;
				end
			else
				OUT_clk2 = OUT_clk2;				
			if(n3 >= 250000)
				begin
					OUT_clk3 = ~OUT_clk3;
					n3 = 0;
				end	
			else
				OUT_clk3 = OUT_clk3;			
			if(n4 >= 250000*50)
				begin
					OUT_clk4 = ~OUT_clk4;
					n4 = 0;
				end	
			else
				OUT_clk3 = OUT_clk3;	
*/				
		end
endmodule
		