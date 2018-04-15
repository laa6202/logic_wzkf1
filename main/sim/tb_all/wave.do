onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_main/cnt_repk_frm
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_main/repk_frm
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_main/buf_frm
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_main/rst_n
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_inf/rx
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_inf/rx_vld
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_inf/rx_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5806 ns} 0}
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
WaveRestoreZoom {0 ns} {10500 ns}
