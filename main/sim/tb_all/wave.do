onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_arm_ctrl/cspi_csn
add wave -noupdate /tb/u_arm_ctrl/cspi_sck
add wave -noupdate /tb/u_arm_ctrl/cspi_miso
add wave -noupdate /tb/u_arm_ctrl/cspi_mosi
add wave -noupdate /tb/u_arm_ctrl/dev_id
add wave -noupdate /tb/u_arm_ctrl/mod_id
add wave -noupdate /tb/u_arm_ctrl/cmd_addr
add wave -noupdate /tb/u_arm_ctrl/cmd_data
add wave -noupdate /tb/u_arm_ctrl/cmd_vld
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
