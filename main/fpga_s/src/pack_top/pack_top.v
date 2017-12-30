//pack_top.v


module pack_top(
//data path input
dp_data,
dp_vld,
dp_utc,
dp_ns,
//pack data output
pk_data,
pk_vld,
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
//clk rst
utc_sec,
clk_sys,
rst_n
);
//data path output
input [23:0]	dp_data;
input					dp_vld;
input [31:0]	dp_utc;
input [31:0]	dp_ns;
//pack data output
output [7:0]	pk_data;
output				pk_vld;
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
//clk rst
input [31:0]	utc_sec;
input clk_sys;
input rst_n;
//--------------------------------------
//--------------------------------------



pack_reg u_pack_reg(
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


//---------- pack buf --------
wire [11:0]	buf_waddr;
wire [11:0]	buf_raddr = 12'h0;
wire [31:0]	q_x;
wire [31:0]	q_y;
wire [31:0]	q_z;
wire [31:0]	q_utc;
wire [31:0]	q_ns;
pack_buf u_pack_buf(
//data path input
.dp_data(dp_data),
.dp_vld(dp_vld),
.dp_utc(dp_utc),
.dp_ns(dp_ns),
//data path output
.buf_waddr(buf_waddr),
.buf_raddr(buf_raddr),
.q_x(q_x),
.q_y(q_y),
.q_z(q_z),
.q_utc(q_utc),
.q_ns(q_ns),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- pack main ----------
wire	fire_head;
wire	fire_load;
wire	fire_tail;
wire 	done_head = 1'b1;
wire 	done_load = 1'b1;
wire 	done_tail = 1'b1;
pack_main u_pack_main(
.fire_head(fire_head),
.fire_load(fire_load),
.fire_tail(fire_tail),
.done_head(done_head),
.done_load(done_load),
.done_tail(done_tail),
//clk rst
.utc_sec(utc_sec),
.clk_sys(clk_sys),
.rst_n(rst_n)
);

endmodule
