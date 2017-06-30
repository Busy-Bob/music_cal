vlog -work work C:/altera/13.0/EX_music_cal/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.test_vlg_vec_tst
onerror {resume}
add wave {test_vlg_vec_tst/i1/a}
add wave {test_vlg_vec_tst/i1/b}
add wave {test_vlg_vec_tst/i1/b[3]}
add wave {test_vlg_vec_tst/i1/b[2]}
add wave {test_vlg_vec_tst/i1/b[1]}
add wave {test_vlg_vec_tst/i1/b[0]}
add wave {test_vlg_vec_tst/i1/c}
run -all
