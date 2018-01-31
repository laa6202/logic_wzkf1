onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_control_top/u_fx_bm/fx_waddr
add wave -noupdate /tb/top_s1/u_control_top/u_fx_bm/fx_wr
add wave -noupdate /tb/top_s1/u_control_top/u_fx_bm/fx_data
add wave -noupdate /tb/top_s1/u_control_top/u_fx_bm/fx_rd
add wave -noupdate /tb/top_s1/u_control_top/u_fx_bm/fx_raddr
add wave -noupdate /tb/top_s1/u_control_top/u_fx_bm/fx_q
add wave -noupdate /tb/top_s1/u_control_top/bm_data
add wave -noupdate /tb/top_s1/u_control_top/bm_vld
add wave -noupdate /tb/top_s1/u_pack_top/bm_data
add wave -noupdate /tb/top_s1/u_pack_top/bm_vld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {53375 ns} 0}
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
WaveRestoreZoom {0 ns} {63 us}
