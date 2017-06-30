module test(input a,input c,output reg [3:0] b);
	initial
	begin
		b = 0;
	end
	
	always@(posedge a)
	begin
		b = b + 4'h1;
		if(b != 0)
			b = b + 4'h2;
		else
			b = b;
	end

endmodule 