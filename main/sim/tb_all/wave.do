onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_commu_top/pk_data
add wave -noupdate /tb/top_s1/u_commu_top/pk_vld
add wave -noupdate /tb/top_s1/u_commu_top/pk_frm
add wave -noupdate /tb/top_s1/u_commu_top/cfg_sample
add wave -noupdate /tb/top_s1/u_commu_top/dev_id
add wave -noupdate /tb/top_s1/u_commu_top/utc_sec
add wave -noupdate /tb/top_s1/u_commu_top/now_ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7020 ns} 0}
quietly wave cursor active 0
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
