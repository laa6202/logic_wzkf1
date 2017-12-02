onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_clk_rst/clk_sys
add wave -noupdate /tb/top_s1/u_clk_rst/clk_slow
add wave -noupdate /tb/top_s1/u_clk_rst/pluse_us
add wave -noupdate /tb/top_s1/u_clk_rst/rst_n
add wave -noupdate /tb/u_tx_ctrl/tx_ctrl
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/dev_id
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/mod_id
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/cmd_addr
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/cmd_data
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/cmd_vld
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/st_tx_mac
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/cnt_tx
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/fire_tx
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/data_tx
add wave -noupdate /tb/u_tx_ctrl/u_tx_mac/done_tx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2537 ns} 0}
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
WaveRestoreZoom {0 ns} {10500 ns}
