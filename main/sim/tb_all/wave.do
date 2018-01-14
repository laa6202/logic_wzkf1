onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_top_m/u_fetch_top/pkg_data
add wave -noupdate /tb/u_top_m/u_fetch_top/pkg_vld
add wave -noupdate /tb/u_top_m/u_fetch_top/pkg_frm
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_pkg/cnt_rx
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_pkg/pkg_sop
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_pkg/pkg_eop
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_pkg/rx_vld
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_pkg/rx_data
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_pkg/len_pkg
add wave -noupdate /tb/u_top_m/u_fetch_top/u_fetch_pkg/lenw_pkg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {501596 ns} 0}
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
WaveRestoreZoom {501214 ns} {501926 ns}
