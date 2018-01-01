//commu_top.v

module commu_top(
//pack data output
pk_data,
pk_vld,
pk_frm,
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

//pack data output
input [7:0]	pk_data;
input				pk_vld;
input 			pk_frm;
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

endmodule
