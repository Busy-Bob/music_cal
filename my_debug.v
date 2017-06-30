// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.0 Build 156 04/24/2013 SJ Full Version"
// CREATED		"Fri Jun 30 23:19:55 2017"

module my_debug(
	clk,
	music,
	key,
	reset,
	control,
	value,
	neg,
	less,
	zero,
	music_on,
	off_number,
	state
);


input wire	clk;
input wire	music;
input wire	key;
input wire	reset;
input wire	control;
input wire	[3:0] value;
output wire	neg;
output wire	less;
output wire	zero;
output wire	music_on;
output wire	[2:0] off_number;
output wire	[1:0] state;

wire	[15:0] SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	[3:0] SYNTHESIZED_WIRE_5;
wire	[7:0] SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	[1:0] SYNTHESIZED_WIRE_8;
wire	[7:0] SYNTHESIZED_WIRE_9;
wire	[7:0] SYNTHESIZED_WIRE_10;
wire	[7:0] SYNTHESIZED_WIRE_11;
wire	[1:0] SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	[3:0] SYNTHESIZED_WIRE_14;
wire	[7:0] SYNTHESIZED_WIRE_15;
wire	[7:0] SYNTHESIZED_WIRE_16;





key_out	b2v_inst(
	.IN_clk(clk),
	.IN_key(key),
	.IN_reset(reset),
	.IN_control(control),
	.IN_ans(SYNTHESIZED_WIRE_0),
	.IN_value(value),
	.OUT_finish(SYNTHESIZED_WIRE_2),
	.OUT_calculating(SYNTHESIZED_WIRE_4),
	.OUT_ALU_OP(SYNTHESIZED_WIRE_5),
	.OUT_DSTH(SYNTHESIZED_WIRE_6),
	.OUT_DSTL(SYNTHESIZED_WIRE_7),
	.OUT_flag(SYNTHESIZED_WIRE_8),
	.OUT_SRCH(SYNTHESIZED_WIRE_10),
	.OUT_SRCL(SYNTHESIZED_WIRE_11),
	.OUT_state(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst.s0 = 0;
	defparam	b2v_inst.s1 = 1;
	defparam	b2v_inst.s2 = 2;
	defparam	b2v_inst.s3 = 3;


Core_unit	b2v_inst2(
	.IN_clk(clk),
	.IN_carry_in(SYNTHESIZED_WIRE_1),
	.IN_finish(SYNTHESIZED_WIRE_2),
	.IN_zero(SYNTHESIZED_WIRE_3),
	.IN_music_on(music),
	.IN_calculating(SYNTHESIZED_WIRE_4),
	.IN_ALU_OP(SYNTHESIZED_WIRE_5),
	.IN_DSTH(SYNTHESIZED_WIRE_6),
	.IN_DSTL(SYNTHESIZED_WIRE_7),
	.IN_flag(SYNTHESIZED_WIRE_8),
	.IN_S(SYNTHESIZED_WIRE_9),
	.IN_SRCH(SYNTHESIZED_WIRE_10),
	.IN_SRCL(SYNTHESIZED_WIRE_11),
	.IN_state(SYNTHESIZED_WIRE_12),
	.OUT_carry_out(SYNTHESIZED_WIRE_13),
	.OUT_neg_ans(neg),
	.OUT_less_than(less),
	.OUT_zero(zero),
	.OUT_music_on(music_on),
	.OUT_ALU_OP(SYNTHESIZED_WIRE_14),
	.OUT_data_a(SYNTHESIZED_WIRE_15),
	.OUT_data_b(SYNTHESIZED_WIRE_16),
	.OUT_off_number(off_number),
	.OUT_value(SYNTHESIZED_WIRE_0),
	.state(state));
	defparam	b2v_inst2.s0 = 0;
	defparam	b2v_inst2.s1 = 1;
	defparam	b2v_inst2.s2 = 2;
	defparam	b2v_inst2.s3 = 3;


alu	b2v_inst3(
	.IN_carry_in(SYNTHESIZED_WIRE_13),
	.IN_CS(SYNTHESIZED_WIRE_14),
	.IN_data_a(SYNTHESIZED_WIRE_15),
	.IN_data_b(SYNTHESIZED_WIRE_16),
	.OUT_zero(SYNTHESIZED_WIRE_3),
	.OUT_carry_out(SYNTHESIZED_WIRE_1),
	.OUT_S(SYNTHESIZED_WIRE_9));


endmodule
