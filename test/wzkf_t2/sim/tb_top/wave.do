onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/clk_sys
add wave -noupdate /tb/dut/rst_n
add wave -noupdate /tb/dut/led_commu
add wave -noupdate /tb/dut/led_ok
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_phy/rx
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_phy/rx_vld
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_phy/rx_data
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_phy/send_bit
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_ctrl/rx_total
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_ctrl/tx_pattern
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_ctrl/rx_data
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_ctrl/rx_vld
add wave -noupdate /tb/dut/u_commu/u_rx_top/u_rx_ctrl/goldern
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4153 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 317
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
WaveRestoreZoom {0 ns} {12600 ns}
