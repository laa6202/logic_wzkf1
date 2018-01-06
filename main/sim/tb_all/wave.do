onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/st_commu_main
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/fire_head
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/fire_push
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/fire_tail
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/done_head
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/done_push
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/done_tail
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/slot_rdy
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/slot_begin
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_head/st_commu_head
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_head/finish_head
add wave -noupdate -radix decimal /tb/top_s1/u_commu_top/u_commu_head/cnt_head
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_head/total_head
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_head/cnt_wait
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {218150 ns} 0}
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
WaveRestoreZoom {214241 ns} {218465 ns}
