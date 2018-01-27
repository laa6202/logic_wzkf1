onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb/u_arm_ctrl/u_actrl_mac/st_actrl_mac
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/fire_cspi
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/done_cspi
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/cspi_csn
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/cspi_sck
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/cspi_miso
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/cspi_mosi
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/set_data
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/set_vld
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/get_q
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/get_vld
add wave -noupdate /tb/u_arm_ctrl/u_actrl_phy/st_actrl_phy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19961 ns} 0}
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
