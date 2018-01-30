onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/u_top_m/u_master_top/u_cspi_codec/cmd_dev
add wave -noupdate /tb/u_top_m/u_master_top/u_cspi_codec/cmd_mod
add wave -noupdate /tb/u_top_m/u_master_top/u_cspi_codec/cmd_addr
add wave -noupdate /tb/u_top_m/u_master_top/u_cspi_codec/cmd_data
add wave -noupdate /tb/u_top_m/u_master_top/u_cspi_codec/cmd_vld
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/cmdl_mod
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/cmdl_addr
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/cmdl_data
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/cmdl_vld
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/cmdl_q
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/cmdl_qvld
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/fx_waddr
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/fx_wr
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/fx_data
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/fx_rd
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/fx_raddr
add wave -noupdate /tb/u_top_m/u_master_top/u_fx_bc/fx_q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18594 ns} 0}
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
WaveRestoreZoom {0 ns} {63 us}
