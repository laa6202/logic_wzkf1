onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/fire_tail
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/done_tail
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/bm_q
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/bm_req
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/exp_data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/tail_data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/tail_vld
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/st_pack_tail
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_tail/cnt_bm
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/data
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/waddr
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/wren
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/raddr
add wave -noupdate /tb/top_s1/u_pack_top/u_bm_buf/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {167931 ns} 0}
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
WaveRestoreZoom {33621 ns} {33703 ns}
