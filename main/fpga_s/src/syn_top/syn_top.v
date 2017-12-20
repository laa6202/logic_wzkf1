//syn_top.v

module syn_top(
rx_syn,
utc_sec,
now_ns,
//clk rst
clk_sys,
rst_n
);
input	rx_syn;
output [31:0]	utc_sec;
output [31:0]	now_ns;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------



rx_syn_phy u_rx_syn_phy(
.rx(rx_syn),
`ifdef SIM
.tbit_period(20'd10),		//10M
`else
.tbit_period(20'd1000),		//100K
`endif
.rx_vld(),
.rx_data(),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


endmodule

