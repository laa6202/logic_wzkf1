onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/clk_sys
add wave -noupdate /tb/dut/rst_n
add wave -noupdate /tb/dut/u_commu/tbit_fre
add wave -noupdate /tb/dut/u_commu/tbit_period
add wave -noupdate /tb/dut/u_commu/tx_total
add wave -noupdate /tb/dut/u_commu/cnt_tx
add wave -noupdate /tb/dut/u_commu/tbit_vld
add wave -noupdate /tb/dut/u_commu/cnt_cycle
add wave -noupdate /tb/dut/tx
add wave -noupdate /tb/dut/u_commu/rx
add wave -noupdate /tb/dut/u_commu/rx_vld
add wave -noupdate /tb/dut/u_commu/rx_total
add wave -noupdate /tb/dut/led
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1611 ns} 0}
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
WaveRestoreZoom {0 ns} {811 ns}
