onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb/u_top_m/u_syn_m/u_syn_m_main/cnt_us
add wave -noupdate /tb/top_s1/rx_syn
add wave -noupdate /tb/top_s2/rx_syn
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/rx_vld
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/rx_data
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/syn_vld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5441 ns} 0}
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
WaveRestoreZoom {0 ns} {21 us}
