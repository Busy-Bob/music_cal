transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.0/EX_music_cal {C:/altera/13.0/EX_music_cal/key_out.v}

vlog -vlog01compat -work work +incdir+C:/altera/13.0/EX_music_cal/simulation/modelsim {C:/altera/13.0/EX_music_cal/simulation/modelsim/key_out.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  key_out_vlg_tst

add wave *
view structure
view signals
run 2 us
