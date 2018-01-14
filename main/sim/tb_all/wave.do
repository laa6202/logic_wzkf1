onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_top_m/u_commu_m/repk_data
add wave -noupdate /tb/u_top_m/u_commu_m/repk_vld
add wave -noupdate /tb/u_top_m/u_commu_m/repk_frm
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/wdata
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/waddr
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/wren
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/wren_a
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/wren_b
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/raddr
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/q_a
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/q_b
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/whit_chip
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/buf_rd
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/buf_frm
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_buf/buf_q
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/fire_push
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/done_push
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/buf_rd
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/buf_frm
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/buf_q
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/real_rd
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/real_q
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/len_pkg
add wave -noupdate /tb/u_top_m/u_commu_m/u_commu_m_push/cnt_rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {416580 ns} 0}
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
WaveRestoreZoom {0 ns} {630 us}
