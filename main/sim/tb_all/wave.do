onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_smcu/mcu_csn
add wave -noupdate /tb/u_smcu/mcu_sck
add wave -noupdate /tb/u_smcu/mcu_mosi
add wave -noupdate /tb/u_smcu/mcu_sel
add wave -noupdate /tb/u_smcu/cfg_id
add wave -noupdate /tb/u_smcu/sck
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16417 ns} 0}
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
WaveRestoreZoom {0 ns} {52500 ns}
