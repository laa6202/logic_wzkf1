onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/cnt_sck
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/mcu_csn
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/mcu_sck
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/mcu_mosi
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/mcu_miso
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/spi_data
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/spi_vld
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/dev_id
add wave -noupdate /tb/top_s1/u_control_top/u_mcu_inf/lock_gset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16300 ns} 0}
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
WaveRestoreZoom {4 us} {11 us}
