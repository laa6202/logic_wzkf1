onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/bm_data
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/bm_vld
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/bm_q
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/bm_req
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/data
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/waddr
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/wren
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/raddr
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/q
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/tail_data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/tail_vld
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/st_pack_tail
add wave -noupdate -radix unsigned /tb/top_s1/u_pack_top/u_pack_tail/cnt_bm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {125190 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 318
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
WaveRestoreZoom {125100 ns} {125240 ns}
