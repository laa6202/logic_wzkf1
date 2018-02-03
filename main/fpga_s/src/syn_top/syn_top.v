//syn_top.v

module syn_top(
rx_syn,
utc_sec,
now_ns,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
//clk rst
mod_id,
clk_sys,
rst_n
);
input	rx_syn;
output [31:0]	utc_sec;
output [31:0]	now_ns;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
//clk rst
input [5:0]	mod_id;
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------

`ifdef SIM
wire rx_syn_real = rx_syn;
`else
wire rx_syn_real;
io_filter syn_filter(
.io_in(rx_syn),
.io_real(rx_syn_real),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);
`endif


wire [7:0]	rx_data;
wire rx_vld;
wire syn_vld;
rx_syn_phy u_rx_syn_phy(
.rx(rx_syn_real),
`ifdef SIM
.tbit_period(20'd10),		//10M
`else
.tbit_period(20'd1000),		//100K
`endif
.rx_vld(rx_vld),
.rx_data(rx_data),
.syn_vld(syn_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


wire [7:0] stu_err_syn;
syn_dec u_syn_dec(
.rx_data(rx_data),
.rx_vld(rx_vld),
.syn_vld(syn_vld),
.utc_sec(utc_sec),
.now_ns(now_ns),
.stu_err_syn(stu_err_syn),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


syn_reg u_syn_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
//register
.stu_err_syn(stu_err_syn),
.stu_utc_sec(utc_sec),
.stu_now_ns(now_ns),
//clk rst
.mod_id(mod_id),
.clk_sys(clk_sys),
.rst_n(rst_n)
);


endmodule

