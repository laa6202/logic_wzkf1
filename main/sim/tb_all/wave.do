onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_main/st_pack_main
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_main/utc_sec_change
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_head/fire_head
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_head/done_head
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_head/head_data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_head/head_vld
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_base/pk_frm
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_load/load_data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_load/load_vld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13999 ns} 0}
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
WaveRestoreZoom {13698 ns} {14274 ns}
