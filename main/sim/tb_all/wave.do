onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/ad1_top/u_ad_syn_gen/ad_sync_1sn
add wave -noupdate /tb/top_s1/ad1_top/u_ad_syn_gen/syn_vld
add wave -noupdate /tb/top_s1/ad1_top/u_ad_syn_gen/clk_sys
add wave -noupdate /tb/top_s1/ad1_top/u_ad_syn_gen/rst_n
add wave -noupdate /tb/top_s1/ad1_top/u_ad_syn_gen/st_ad_syn
add wave -noupdate /tb/top_s1/ad1_top/u_ad_syn_gen/finish_syn
add wave -noupdate /tb/top_s1/ad1_top/u_ad_syn_gen/cnt_syn
add wave -noupdate /tb/top_s1/u_syn_top/rx_syn
add wave -noupdate /tb/top_s1/u_syn_top/utc_sec
add wave -noupdate /tb/top_s1/u_syn_top/now_ns
add wave -noupdate /tb/top_s1/u_syn_top/syn_vld
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/st_rx_phy
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/rx_falling
add wave -noupdate /tb/top_s1/u_syn_top/u_rx_syn_phy/finish_bit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23364 ns} 0}
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
WaveRestoreZoom {15333 ns} {28305 ns}
