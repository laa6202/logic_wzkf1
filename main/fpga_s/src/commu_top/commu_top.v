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
wire [7:0]	cmd_retry;
commu_reg u_commu_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//confiration
.cmd_retry(cmd_retry),
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
wire buf_rd;
wire buf_frm;
wire [7:0] buf_q;
commu_buf u_commu_buf(
//pack data output
.pk_data(pk_data),
.pk_vld(pk_vld),
.pk_frm(pk_frm),
.buf_rd(buf_rd),
.buf_q(buf_q),
.buf_frm(buf_frm),
//parmeter 
.len_pkg(len_pkg),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//--------- commu_main ------------
wire fire_head;
wire fire_push;
wire fire_tail;
wire done_head;
wire done_push;
wire done_tail;
wire slot_rdy = 1'b0;
commu_main u_commu_main(
//control signal
.fire_head(fire_head),
.fire_push(fire_push),
.fire_tail(fire_tail),
.done_head(done_head),
.done_push(done_push),
.done_tail(done_tail),
//env
.pk_frm(pk_frm),
.slot_rdy(slot_rdy),
.cmd_retry(cmd_retry),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

wire tx_a = ^pk_data ^ pk_vld ^ pk_frm;

endmodule
