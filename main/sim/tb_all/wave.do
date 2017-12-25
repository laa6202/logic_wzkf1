onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/tp_data
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/tp_vld
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/cfg_sample
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/cfg_ad_tp
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/cfg_tp_base
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/cfg_tp_step
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/rst_n
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/cfg_tp_change
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/tp_period
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/cnt_cycle
add wave -noupdate /tb/top_s1/ad1_top/u_ad_tp/period_vld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10972 ns} 0}
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
