onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_buf/cnt_buf
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_buf/pk_data
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_buf/pk_vld
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_buf/pk_frm
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_buf/len_pkg
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/st_commu_main
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/slot_begin
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/slot_rdy
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/mode_numDev
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/dev_id
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/cmd_retry
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/cmd_re
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {214494 ns} 0}
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
WaveRestoreZoom {207851 ns} {218409 ns}
