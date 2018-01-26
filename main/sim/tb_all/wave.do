onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/fire_cspi
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/done_cspi
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/set_data
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/set_vld
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/get_q
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/get_vld
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/dev_id
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/mod_id
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/cmd_addr
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/cmd_data
add wave -noupdate /tb/u_arm_ctrl/u_actrl_mac/cmd_vld
add wave -noupdate -radix unsigned /tb/u_arm_ctrl/u_actrl_mac/st_actrl_mac
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10170 ns} 0}
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
WaveRestoreZoom {10085 ns} {10219 ns}
