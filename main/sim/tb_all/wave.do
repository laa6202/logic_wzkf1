onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_top_m/u_syn_m/tx_syn
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_info/st_tx_info
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_info/tx_info
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_info/fire_tx
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_info/data_tx
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/st_rx_phy
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/syn_vld
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/rx_vld
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/rx_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65307 ns} 0}
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
WaveRestoreZoom {46952 ns} {82904 ns}
