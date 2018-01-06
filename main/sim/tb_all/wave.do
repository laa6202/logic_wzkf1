onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/st_commu_main
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/slot_begin
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/slot_rdy
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/mode_numDev
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/dev_id
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/cmd_retry
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/cmd_re
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/st_commu_slot
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/finish_slot
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/finish_all
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/slot_head
add wave -noupdate -radix unsigned /tb/top_s1/u_commu_top/u_commu_slot/cnt_slot_cycle
add wave -noupdate -radix decimal /tb/top_s1/u_commu_top/u_commu_slot/cnt_slot_id
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/cmd_slot_id
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/lock_cmd_re
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/slot_fix
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_slot/slot_cmd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {161520 ns} 0}
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
WaveRestoreZoom {0 ns} {644096 ns}
