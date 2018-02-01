onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_smcu/mcu_csn
add wave -noupdate /tb/u_smcu/mcu_sck
add wave -noupdate /tb/u_smcu/mcu_mosi
add wave -noupdate /tb/u_smcu/mcu_sel
add wave -noupdate /tb/u_smcu/cfg_id
add wave -noupdate /tb/u_smcu/sck
add wave -noupdate /tb/top_s1/u_ex_top/u_mcuspi_inf/mcu_csn
add wave -noupdate /tb/top_s1/u_ex_top/u_mcuspi_inf/mcu_sck
add wave -noupdate /tb/top_s1/u_ex_top/u_mcuspi_inf/mcu_mosi
add wave -noupdate /tb/top_s1/u_ex_top/u_mcuspi_inf/spi_data
add wave -noupdate /tb/top_s1/u_ex_top/u_mcuspi_inf/spi_vld
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
