onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_top_m/u_master_top/ucspi_inf/cspi_csn
add wave -noupdate /tb/u_top_m/u_master_top/ucspi_inf/cspi_sck
add wave -noupdate /tb/u_top_m/u_master_top/ucspi_inf/cspi_miso
add wave -noupdate /tb/u_top_m/u_master_top/ucspi_inf/cspi_mosi
add wave -noupdate /tb/u_top_m/u_master_top/ucspi_inf/ctrl_data
add wave -noupdate /tb/u_top_m/u_master_top/ucspi_inf/ctrl_dvld
add wave -noupdate /tb/u_top_m/u_master_top/ucspi_inf/ctrl_q
add wave -noupdate /tb/u_top_m/u_master_top/ucspi_inf/ctrl_qvld
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
