onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/ad_clk_in
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/clk_2kHz
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/ad_din
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/ad_sync
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/st_ad_p1
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/ad_clk
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/ad_clk_vld
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/ad_cfg
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/cnt_config
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/ad_data
add wave -noupdate /tb/top_s1/ad1_top/u_ad_sample/ad_vld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {89718 ns} 0}
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
WaveRestoreZoom {0 ns} {315 us}
