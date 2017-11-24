onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/clk_sys
add wave -noupdate /tb/dut/rst_n
add wave -noupdate /tb/dut/led_commu
add wave -noupdate /tb/dut/led_ok
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_mac/st_tx_mac
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/tx
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/fire_tx
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/done_tx
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/data_tx
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/tbit_period
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/st_tx_phy
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/finish_bit
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/send_bit
add wave -noupdate /tb/dut/u_commu/u_tx_top/u_tx_phy/cnt_cycle
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {850 ns} 0}
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
WaveRestoreZoom {0 ns} {2100 ns}
