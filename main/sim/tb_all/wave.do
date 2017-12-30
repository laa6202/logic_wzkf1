onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/buf_waddr
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_main/fire_head
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_main/fire_load
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_main/fire_tail
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_main/utc_sec
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_main/st_pack_main
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_main/utc_sec_change
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1010 ns} 0}
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
WaveRestoreZoom {913 ns} {1105 ns}
