onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb/u_top_m/u_syn_m/u_syn_m_main/cnt_us
add wave -noupdate /tb/top_s1/rx_syn
add wave -noupdate /tb/top_s2/rx_syn
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/rx_data
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/rx_vld
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/syn_vld
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/utc_sec
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/now_ns
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/clk_sys
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/rst_n
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/cnt_times
add wave -noupdate -radix decimal /tb/top_s1/u_syn_top/u_syn_dec/cnt_ns
add wave -noupdate /tb/top_s1/u_syn_top/u_syn_dec/utc_org
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13799 ns} 0}
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
WaveRestoreZoom {13799 ns} {13841 ns}
