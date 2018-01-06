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
wire [7:0]	cfg_numDev;
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
.cfg_numDev(cfg_numDev),
.cmd_retry(cmd_retry),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//------------ commu_base --------
wire [15:0]	len_pkg;
wire [1:0]	mode_numDev;
wire [15:0]	tbit_frq;
wire [19:0]	tbit_period;
commu_base u_commu_base(
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
wire slot_begin;
wire slot_rdy;
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
.slot_begin(slot_begin),
.slot_rdy(slot_rdy),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//--------- commu_slot ----------
commu_slot u_commu_slot(
.slot_begin(slot_begin),
.slot_rdy(slot_rdy),
.mode_numDev(mode_numDev),
.dev_id(dev_id),
.cmd_retry(cmd_retry),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//----------- commu_head ---------
wire				fire_tx_head;
wire				done_tx_head;
wire [15:0]	data_tx_head;
commu_head u_commu_head(
//control signal
.fire_head(fire_head),
.done_head(done_head),
//data path
.fire_tx(fire_tx_head),
.done_tx(done_tx_head),
.data_tx(data_tx_head),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- commu_push --------
wire				fire_tx_push;
wire				done_tx_push;
wire [15:0]	data_tx_push;
commu_push u_commu_push(
.fire_push(fire_push),
.done_push(done_push),
//data path
.buf_rd(buf_rd),
.buf_q(buf_q),
.buf_frm(buf_frm),
.fire_tx(fire_tx_push),
.done_tx(done_tx_push),
.data_tx(data_tx_push),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- commu_tail ---------
wire				fire_tx_tail;
wire				done_tx_tail;
wire [15:0]	data_tx_tail;
commu_tail u_commu_tail(
//control signal
.fire_tail(fire_tail),
.done_tail(done_tail),
//data path
.fire_tx(fire_tx_tail),
.done_tx(done_tx_tail),
.data_tx(data_tx_tail),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//------------- commu_mux ------------
wire				fire_tx;
wire				done_tx;
wire [15:0]	data_tx;
commu_mux u_commu_mux(
.fire_tx_head(fire_tx_head),
.done_tx_head(done_tx_head),
.data_tx_head(data_tx_head),
.fire_tx_push(fire_tx_push),
.done_tx_push(done_tx_push),
.data_tx_push(data_tx_push),
.fire_tx_tail(fire_tx_tail),
.done_tx_tail(done_tx_tail),
.data_tx_tail(data_tx_tail),
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- commu_tx_inf -----------
commu_tx_inf u_commu_tx_inf(
.tx(tx_a),
//control 
.fire_tx(fire_tx),
.done_tx(done_tx),
.data_tx(data_tx),
.tbit_period(tbit_period),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule
