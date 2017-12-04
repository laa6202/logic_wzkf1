onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_clk_rst/clk_sys
add wave -noupdate /tb/top_s1/u_clk_rst/clk_slow
add wave -noupdate /tb/top_s1/u_clk_rst/pluse_us
add wave -noupdate /tb/top_s1/u_clk_rst/rst_n
add wave -noupdate /tb/top_s1/u_control_top/u_factory_ctrl/cmdr_dev
add wave -noupdate /tb/top_s1/u_control_top/u_factory_ctrl/cmdr_mod
add wave -noupdate /tb/top_s1/u_control_top/u_factory_ctrl/cmdr_addr
add wave -noupdate /tb/top_s1/u_control_top/u_factory_ctrl/cmdr_data
add wave -noupdate /tb/top_s1/u_control_top/u_factory_ctrl/cmdr_vld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8282 ns} 0}
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
WaveRestoreZoom {0 ns} {18900 ns}
