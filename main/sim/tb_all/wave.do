onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_top_m/u_fetch_top/rx_a
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_inf/rx
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_inf/tbit_period
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_inf/rx_vld
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_inf/rx_data
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/tx
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/fire_tx
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/data_tx
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/st_tx_phy
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_inf/st_rx_phy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {190143 ns} 0}
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
WaveRestoreZoom {158170 ns} {202202 ns}
