onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_main/st_commu_main
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/tx
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/fire_tx
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/done_tx
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/data_tx
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/tbit_period
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/data
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/send_bit
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/finish_bit
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/st_tx_phy
add wave -noupdate /tb/top_s1/u_commu_top/u_commu_tx_inf/cnt_cycle
add wave -noupdate /tb/top_s1/u_commu_top/tx_a
add wave -noupdate /tb/top_s1/u_commu_top/de_a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {216604 ns} 0}
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
WaveRestoreZoom {213433 ns} {220681 ns}
