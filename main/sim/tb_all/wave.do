onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dp_data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dp_vld
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dp_utc
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dp_ns
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/clk_sys
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/rst_n
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkX/data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkX/wren
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkY/data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkY/wren
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkZ/data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkZ/wren
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkUTC/data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkUTC/wren
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkNS/data
add wave -noupdate /tb/top_s1/u_pack_top/u_pack_buf/dram_pkNS/wren
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
