//IN_clk 为25Mhz
//低电平触发

module music(input IN_clk, input IN_neg_ans, input IN_music_on, 
				output OUT_music);
	reg [31:0] n_interval = 0;
	reg [19:0] n[20:0];
	reg [5:0] k = 0;
	reg clk_interval = 0;
	reg clk [21:0];
	reg [19:0] MAX_n [20:0]; 
	reg [31:0] MAX_n_interval = 1562500; //8Hz
	
	reg [31:0] MAX_song1 = 515; //未定
	reg [31:0] MAX_song2 = 351; //未定
	reg [31:0] song1 = 0;
	reg [31:0] song2 = 0;
	reg [5:0] content1 [514:0]; //未定
	reg [5:0] content2 [350:0]; //未定	
	reg [5:0] now_Hz = 0;
	
	assign OUT_music = clk[now_Hz];
	
	always @(posedge IN_clk)
	begin
	//低音
		MAX_n[0] = 47710;
		MAX_n[1] = 42157;
		MAX_n[2] = 37879;
		MAX_n[3] = 35816;
		MAX_n[4] = 31888;
		MAX_n[5] = 28409;
		MAX_n[6] = 25303;
	//中音	
		MAX_n[7] = 23900;
		MAX_n[8] = 21295;
		MAX_n[9] = 18968;
		MAX_n[10] = 17908;
		MAX_n[11] = 15944;
		MAX_n[12] = 14205;
		MAX_n[13] = 12651;
	//高音
		MAX_n[14] = 11938;
		MAX_n[15] = 10638;
		MAX_n[16] = 9484;
		MAX_n[17] = 8948;
		MAX_n[18] = 7972;
		MAX_n[19] = 7102;
		MAX_n[20] = 6355;
		
		
		MAX_n_interval = 1562500;
		clk[21] = 1;
		
		n_interval = n_interval + 1;
		k = 0;
		repeat(21)
		begin
			n[k] = n[k] + 1;
			if(n[k] >= MAX_n[k])
			begin
				clk[k] = ~clk[k];
				n[k] = 0;
			end
			k = k + 1;
		end
		if(n_interval >= MAX_n_interval)
		begin
			clk_interval = ~clk_interval;
			n_interval = 0;
		end
	end
	
	
	always @(posedge clk_interval)
	begin
		if(!IN_music_on)
		begin
			song1 = 0;
			song2 = 0;
			now_Hz = 21;
		end
		else if(IN_neg_ans)
		begin
			if(song1 >= MAX_song1)
				song1 = 0;
			else
				song1 = song1;
			now_Hz = content1[song1];
			song1 = song1 + 1;
		end
		else
		begin
			if(song2 >= MAX_song2)
				song2 = 0;
			else
				song2 = song2;
			now_Hz = content2[song2];
			song2 = song2 + 1;
		end
	end
	
	// 歌曲内容，最大长度
	always @(posedge IN_clk)
	begin
		MAX_song1 = 515;
		MAX_song2 = 351;
		//每个内容占时1/16s
		//下划线是2个重复（简谱）
		//双下划线1个
		//点6个
		//普通4个
	/*
		content1[0] = 5;
		content1[1] = 5;
		content1[2] = 6;
		content1[3] = 6;
		// 1
		content1[4] = 7;
		content1[5] = 7;
		content1[6] = 7;
		content1[7] = 7;
		content1[8] = 7;
		content1[9] = 7;
		content1[10] = 6;
		content1[11] = 6;
		content1[12] = 7;
		content1[13] = 7;
		content1[14] = 7;
		content1[15] = 7;
		content1[16] = 9;
		content1[17] = 9;
		content1[18] = 9;
		content1[19] = 9;
		// 2 
		content1[20] = 6;
		content1[21] = 6;
		content1[22] = 6;
		content1[23] = 6;
		content1[24] = 6;
		content1[25] = 6;
		content1[26] = 6;
		content1[27] = 6;
		content1[28] = 6;
		content1[29] = 6;
		content1[30] = 6;
		content1[31] = 6;
		content1[32] = 2;
		content1[33] = 2;
		content1[34] = 2;
		content1[35] = 2;
		//3
		content1[36] = 5;
		content1[37] = 5;
		content1[38] = 5;
		content1[39] = 5;
		content1[40] = 5;
		content1[41] = 5;
		content1[42] = 4;
		content1[43] = 4;
		content1[44] = 5;
		content1[45] = 5;
		content1[46] = 5;
		content1[47] = 5;
		content1[48] = 7;
		content1[49] = 7;
		content1[50] = 7;
		content1[51] = 7;
		// 4
		content1[52] = 4;
		content1[53] = 4;
		content1[54] = 4;
		content1[55] = 4;
		content1[56] = 4;
		content1[57] = 4;
		content1[58] = 4;
		content1[59] = 4;
		content1[60] = 4;
		content1[61] = 4;
		content1[62] = 4;
		content1[63] = 4;
		content1[64] = 2;
		content1[65] = 2;
		content1[66] = 2;
		content1[67] = 2;
		// 5
		content1[68] = 3;
		content1[69] = 3;
		content1[70] = 3;
		content1[71] = 3;
		content1[72] = 3;
		content1[73] = 3;
		content1[74] = 2;
		content1[75] = 2;
		content1[76] = 3;
		content1[77] = 3;
		content1[78] = 7;
		content1[79] = 7;
		content1[80] = 7;
		content1[81] = 7;
		content1[82] = 7;
		content1[83] = 7;
		// 6
		content1[84] = 2;
		content1[85] = 2;
		content1[86] = 2;
		content1[87] = 2;
		content1[88] = 2;
		content1[89] = 2;
		content1[90] = 2;
		content1[91] = 2;
		content1[92] = 2;
		content1[93] = 2;
		content1[94] = 2;
		content1[95] = 2;
		content1[96] = 7;
		content1[97] = 7;
		content1[98] = 7;
		content1[99] = 7;
		// 7
		content1[100] = 6;
		content1[101] = 6;
		content1[102] = 6;
		content1[103] = 6;
		content1[104] = 6;
		content1[105] = 6;
		content1[106] = 3;
		content1[107] = 3;
		content1[108] = 3;
		content1[109] = 3;
		content1[110] = 3;
		content1[111] = 3;
		content1[112] = 6;
		content1[113] = 6;
		content1[114] = 6;
		content1[115] = 6;
		// 8
		content1[116] = 6;
		content1[117] = 6;
		content1[118] = 6;
		content1[119] = 6;
		content1[120] = 6;
		content1[121] = 6;
		content1[122] = 6;
		content1[123] = 6;
		content1[124] = 21;
		content1[125] = 21;
		content1[126] = 21;
		content1[127] = 21;
		content1[128] = 5;
		content1[129] = 5;
		content1[130] = 6;
		content1[131] = 6;
		// 9
		content1[132] = 7;
		content1[133] = 7;
		content1[134] = 7;
		content1[135] = 7;
		content1[136] = 7;
		content1[137] = 7;
		content1[138] = 6;
		content1[139] = 6;
		content1[140] = 7;
		content1[141] = 7;
		content1[142] = 7;
		content1[143] = 7;
		content1[144] = 9;
		content1[145] = 9;
		content1[146] = 9;
		content1[147] = 9;
		// 10
		*/
		$readmemh("3.txt",content1);
		$readmemh("1.txt",content2);
		
		// content2[0] = 12;
		// content2[1] = 15;
		// content2[2] = 12;
		// content2[3] = 15;
		// content2[4] = 12;
		// content2[5] = 12;
		// content2[6] = 15;
		// content2[7] = 12;
		// content2[8] = 15;
		// content2[9] = 12;
		// content2[10] = 12;
		// content2[11] = 15;
		// content2[12] = 12;
		// content2[13] = 15;
		// content2[14] = 12;

	end


	
		
endmodule 