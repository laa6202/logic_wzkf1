onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_top_m/y_fetch_top/rx_a
add wave -noupdate /tb/u_top_m/y_fetch_top/rx_b
add wave -noupdate /tb/u_top_m/y_fetch_top/fire_sync
add wave -noupdate /tb/u_top_m/y_fetch_top/clk_sys
add wave -noupdate /tb/u_top_m/y_fetch_top/rst_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {255667 ns} 0}
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
WaveRestoreZoom {0 ns} {420 us}
