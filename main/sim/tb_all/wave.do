onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb/u_top_m/u_syn_m/u_syn_m_main/cnt_us
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_main/clk_sys
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_main/pluse_us
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_main/rst_n
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_sync/tx_sync
add wave -noupdate /tb/u_top_m/u_syn_m/u_syn_m_sync/fire_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {586 ns} 0}
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
WaveRestoreZoom {0 ns} {21056 ns}
