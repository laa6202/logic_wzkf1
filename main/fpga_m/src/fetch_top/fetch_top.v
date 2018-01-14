//fetch_top.v


module fetch_top(
//data path
rx_a,
rx_b,
pkg_data,
pkg_vld,
pkg_frm,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//clk rst
fire_sync,
clk_sys,
rst_n
);
//data path
input rx_a;
input rx_b;
output [15:0]	pkg_data;
output				pkg_vld;
output				pkg_frm;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
//clk rst
input fire_sync;
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------


//---------- fetch_reg ------------
wire [7:0]	cfg_sample;
wire [7:0]	cfg_numDev;
fetch_reg u_fetch_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//configuration
.cfg_sample(cfg_sample),
.cfg_numDev(cfg_numDev),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- fetch_base --------
wire [15:0]	len_pkg;
wire [1:0]  mode_numDev;
wire [15:0]	tbit_frq;
wire [19:0]	tbit_period;
fetch_base u_fetch_base(
.len_pkg(len_pkg),
.mode_numDev(mode_numDev),
.tbit_frq(tbit_frq),
.tbit_period(tbit_period),
//configuration
.cfg_numDev(cfg_numDev),
.cfg_sample(cfg_sample),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);




//--------- fetch_rx_inf ---------
wire [15:0]	rx_data;
wire				rx_vld;
fetch_rx_inf u_fetch_inf(
.rx(rx_a),
.tbit_period(tbit_period),
.rx_vld(rx_vld),
.rx_data(rx_data),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- fetch_pkg ----------
fetch_pkg u_fetch_pkg(
.pkg_data(pkg_data),
.pkg_vld(pkg_vld),
.pkg_frm(pkg_frm),
.rx_vld(rx_vld),
.rx_data(rx_data),
//configration
.len_pkg(len_pkg),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

endmodule

