//commu_top.v

module commu_top(
//data path
pk_data,
pk_vld,
pk_frm,
tx_a,
de_a,
tx_b,
de_b,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
//configuration
cfg_sample,
dev_id,
//clk rst
utc_sec,
now_ns,
clk_sys,
rst_n
);

//data path
input [7:0]	pk_data;
input				pk_vld;
input 			pk_frm;
output	tx_a;
output	de_a;
output	tx_b;
output	de_b;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
//configuration
input [7:0]	cfg_sample;
input [7:0]	dev_id;
//clk rst
input [31:0]	utc_sec;
input [31:0]	now_ns;
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------


//--------- commu_reg ---------
commu_reg u_commu_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//------------ commu_base --------
wire [15:0]	len_pkg;
commu_base u_commu_base(
.len_pkg(len_pkg),
//configuration
.cfg_sample(cfg_sample),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- commu_buf ----------
commu_buf u_commu_buf(
//pack data output
.pk_data(pk_data),
.pk_vld(pk_vld),
.pk_frm(pk_frm),
//parmeter 
.len_pkg(len_pkg),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


endmodule
