module BCD(input IN_clk, input  [15:0] IN_hex, input [2:0] IN_off_number,
          output [15:0] OUT_dec, output reg [2:0] OUT_off_number);

wire [15:0] rrhex;
reg [3:0] rhex[3:0];

reg [17:0] rhexd;
reg [13:0] rhexc;
reg [9:0] rhexb;
reg [4:0] rhexa;

reg [5:0] resa,resb,resc,resd; //这儿选用6位的原因是h40是6位的
//reg [3:0] rese;

assign rrhex = IN_hex[15] ? ~IN_hex[15:0]+1'b1 : IN_hex[15:0];         //去符号
assign OUT_dec = {/*rese,*/resd[3:0],resc[3:0],resb[3:0],resa[3:0]};

always @(OUT_dec)
	OUT_off_number = IN_off_number;
	

always @(posedge IN_clk)                  //第一级寄存器
begin
    rhex[3] <= rrhex[15:12];
    rhex[2] <= rrhex[11:8];
    rhex[1] <= rrhex[7:4];
    rhex[0] <= rrhex[3:0];
end

always @(posedge IN_clk)                  //第二级寄存器,千
begin
    case(rhex[3])
        4'h0: rhexd <= 18'h00000;
        4'h1: rhexd <= 18'h04096;
        4'h2: rhexd <= 18'h08192;
        4'h3: rhexd <= 18'h12288;
        4'h4: rhexd <= 18'h16384;
        4'h5: rhexd <= 18'h20480;
        4'h6: rhexd <= 18'h24576;
        4'h7: rhexd <= 18'h28672;    //后面用不上了 所以不写了
        default: rhexd <= 10'h00000;
    endcase
end

always @(posedge IN_clk)
begin
    case(rhex[2])
        4'h0: rhexc <= 14'h0000;
        4'h1: rhexc <= 14'h0256;
        4'h2: rhexc <= 14'h0512;
        4'h3: rhexc <= 14'h0768;
        4'h4: rhexc <= 14'h1024;
        4'h5: rhexc <= 14'h1280;
        4'h6: rhexc <= 14'h1536;
        4'h7: rhexc <= 14'h1792;
        4'h8: rhexc <= 14'h2048;
        4'h9: rhexc <= 14'h2304;
        4'ha: rhexc <= 14'h2560;
        4'hb: rhexc <= 14'h2816;
        4'hc: rhexc <= 14'h3072;
        4'hd: rhexc <= 14'h3328;
        4'he: rhexc <= 14'h3584;
        4'hf: rhexc <= 14'h3840;
        default: rhexc <= 14'h0000;
    endcase
end 

always @(posedge IN_clk)
begin
    case(rhex[1])
        4'h0: rhexb <= 10'h000;
        4'h1: rhexb <= 10'h016;
        4'h2: rhexb <= 10'h032;
        4'h3: rhexb <= 10'h048;
        4'h4: rhexb <= 10'h064;
        4'h5: rhexb <= 10'h080;
        4'h6: rhexb <= 10'h096;
        4'h7: rhexb <= 10'h112;
        4'h8: rhexb <= 10'h128;
        4'h9: rhexb <= 10'h144;
        4'ha: rhexb <= 10'h160;
        4'hb: rhexb <= 10'h176;
        4'hc: rhexb <= 10'h192;
        4'hd: rhexb <= 10'h208;
        4'he: rhexb <= 10'h224;
        4'hf: rhexb <= 10'h240;
        default: rhexb <= 10'h000;
    endcase
end 

always @(posedge IN_clk)
begin
		case(rhex[0])
        4'h0: rhexa <= 5'h00;
        4'h1: rhexa <= 5'h01;
        4'h2: rhexa <= 5'h02;
        4'h3: rhexa <= 5'h03;
        4'h4: rhexa <= 5'h04;
        4'h5: rhexa <= 5'h05;
        4'h6: rhexa <= 5'h06;
        4'h7: rhexa <= 5'h07;
        4'h8: rhexa <= 5'h08;
        4'h9: rhexa <= 5'h09;
        4'ha: rhexa <= 5'h10;
        4'hb: rhexa <= 5'h11;
        4'hc: rhexa <= 5'h12;
        4'hd: rhexa <= 5'h13;
        4'he: rhexa <= 5'h14;
        4'hf: rhexa <= 5'h15;
		  default: rhexc <= 5'h00;
		  endcase
end

always @(posedge IN_clk)
begin   
    resa = addbcd4(rhexa[3:0],rhexb[3:0],rhexc[3:0],  rhexd[3:0], 4'h0);
    resb = addbcd4(resa[5:4], rhexb[7:4],rhexc[7:4],  rhexd[7:4], rhexa[4]);
    resc = addbcd4(resb[5:4], rhexb[9:8],rhexc[11:8], rhexd[11:8], 4'h0);
    resd = addbcd4(resc[5:4], 4'h0,      rhexc[13:12],rhexd[15:12], 4'h0);
//  rese = resd[5:4] + rhexd[17:16];
end

function [5:0] addbcd4; 
input [3:0] add1,add2,add3,add4,add5;
begin
    addbcd4 = add1 + add2 + add3 + add4 + add5;
    if(addbcd4 > 6'h1d)               //>29 
        addbcd4 = addbcd4 + 5'h12;		// +18
    else if(addbcd4 > 5'h13)          //>19
        addbcd4 = addbcd4 + 4'hc;		// +12
    else if(addbcd4 > 4'h9)           //>9
        addbcd4 = addbcd4 + 4'h6;     // +6
end
endfunction

endmodule
