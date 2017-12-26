onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_dsp_top/ad1_data
add wave -noupdate /tb/top_s1/u_dsp_top/ad1_vld
add wave -noupdate /tb/top_s1/u_dsp_top/ad2_data
add wave -noupdate /tb/top_s1/u_dsp_top/ad2_vld
add wave -noupdate /tb/top_s1/u_dsp_top/ad3_data
add wave -noupdate /tb/top_s1/u_dsp_top/ad3_vld
add wave -noupdate /tb/top_s1/u_dsp_top/dp_data
add wave -noupdate /tb/top_s1/u_dsp_top/dp_vld
add wave -noupdate /tb/top_s1/u_dsp_top/dp_utc
add wave -noupdate /tb/top_s1/u_dsp_top/dp_ns
add wave -noupdate /tb/top_s1/u_dsp_top/mod_id
add wave -noupdate /tb/top_s1/u_dsp_top/utc_sec
add wave -noupdate /tb/top_s1/u_dsp_top/now_ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10972 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 309
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {21 us}
