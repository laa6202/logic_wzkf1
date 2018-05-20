onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_commu_top/pk_data
add wave -noupdate /tb/top_s1/u_commu_top/pk_vld
add wave -noupdate /tb/top_s1/u_commu_top/pk_frm
add wave -noupdate /tb/top_s1/u_commu_top/tx_commu
add wave -noupdate /tb/top_s1/u_hub_top/tx_a
add wave -noupdate /tb/top_s1/u_hub_top/rx_a
add wave -noupdate /tb/top_s1/u_hub_top/re_a
add wave -noupdate /tb/top_s1/u_hub_top/tx_a_local
add wave -noupdate /tb/top_s1/u_hub_top/clk_sys
add wave -noupdate /tb/top_s1/u_hub_top/rst_n
add wave -noupdate /tb/top_s2/u_commu_top/tx_a
add wave -noupdate /tb/top_s1/u_hub_top/rx_data
add wave -noupdate /tb/top_s1/u_hub_top/rx_vld
add wave -noupdate /tb/top_s1/u_hub_top/u_hub_tx/tx
add wave -noupdate /tb/top_s1/u_hub_top/u_hub_tx/fire_tx
add wave -noupdate /tb/top_s1/u_hub_top/u_hub_tx/done_tx
add wave -noupdate /tb/top_s1/u_hub_top/u_hub_tx/data_tx
add wave -noupdate /tb/top_s1/u_hub_top/tx_recovry
add wave -noupdate /tb/top_s2/u_hub_top/tx_recovry
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {132757 ns} 0}
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
WaveRestoreZoom {123177 ns} {134768 ns}
