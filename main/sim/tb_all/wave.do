onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_arm_spi/spi_csn
add wave -noupdate /tb/u_arm_spi/spi_sck
add wave -noupdate /tb/u_arm_spi/spi_miso
add wave -noupdate /tb/u_arm_spi/spi_mosi
add wave -noupdate /tb/u_arm_spi/clk_sys
add wave -noupdate /tb/u_arm_spi/rst_n
add wave -noupdate /tb/u_arm_spi/cnt_cycle
add wave -noupdate /tb/u_arm_spi/pluse_10M
add wave -noupdate /tb/u_arm_spi/cnt_spi_bit
add wave -noupdate /tb/u_arm_spi/spi_en
add wave -noupdate /tb/u_arm_spi/spi_sck_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2111 ns} 0}
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
WaveRestoreZoom {0 ns} {5250 ns}
