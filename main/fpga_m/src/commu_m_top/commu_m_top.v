//commu_m_top.v

module commu_m_top(
//arm spi
spi_csn,
spi_sck,
spi_miso,
spi_mosi,
arm_int_n,
//pkg data
repk_data,
repk_vld,
repk_frm,
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
mod_id,
len_pkg,
//clk rst
clk_sys,
rst_n
);
//arm spi
input spi_csn;
input spi_sck;
output	spi_miso;
input		spi_mosi;
output	arm_int_n;
//pkg data
input [15:0]	repk_data;
input					repk_vld;
input					repk_frm;
//fx_bus
input 				fx_wr;
input [7:0]		fx_data;
input [15:0]	fx_waddr;
input [15:0]	fx_raddr;
input 				fx_rd;
output  [7:0]	fx_q;
input [5:0] mod_id;
input [15:0]	len_pkg;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------


//------------ commu_m_reg ---------
wire [7:0] cfg_tp;
wire [7:0] stu_buf_rdy;
commu_m_reg u_commu_m_reg(
//fx bus
.fx_waddr(fx_waddr),
.fx_wr(fx_wr),
.fx_data(fx_data),
.fx_rd(fx_rd),
.fx_raddr(fx_raddr),
.fx_q(fx_q),
.mod_id(mod_id),
//configuration
.cfg_tp(cfg_tp),
.stu_buf_rdy(stu_buf_rdy),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//------------ commu_m_buf ---------
wire				buf_rd;
wire				buf_frm;
wire [7:0]	buf_q;
commu_m_buf u_commu_m_buf(
//pkg data
.repk_data(repk_data),
.repk_vld(repk_vld),
.repk_frm(repk_frm),
//read path
.buf_rd(buf_rd),
.buf_frm(buf_frm),
.buf_q(buf_q),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- commu_m_main -----------
wire fire_push;
wire done_push;
commu_m_main u_commu_m_main(
.fire_push(fire_push),
.done_push(done_push),
.repk_frm(repk_frm),
.buf_frm(buf_frm),
.buf_rd(buf_rd),
//configuration
.arm_int_n(arm_int_n),
.stu_buf_rdy(stu_buf_rdy),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//---------- real push ---------
wire 				real_rd;
wire [7:0]	real_q;
commu_m_push u_commu_m_push(
//control signal
.fire_push(fire_push),
.done_push(done_push),
//read path
.buf_rd(buf_rd),
.buf_frm(buf_frm),
.buf_q(buf_q),
.real_rd(real_rd),
.real_q(real_q),
.len_pkg(len_pkg),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- commu_tp ----------
wire 				tp_rd;
wire [7:0]	tp_q;
commu_m_tp u_commu_m_tp(
.tp_rd(tp_rd),
.tp_q(tp_q),
//configuratiuon
.cfg_tp(cfg_tp),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//----------- commu_m_mux ----------
wire 				req_rd;
wire [7:0]	req_q;
commu_m_mux u_commu_m_mux(
.real_rd(real_rd),
.real_q(real_q),
.tp_rd(tp_rd),
.tp_q(tp_q),
.req_rd(req_rd),
.req_q(req_q),
//configuratiuon
.cfg_tp(cfg_tp),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//--------- spi_inf -----------
spi_inf u_spi_inf(
//arm rd
.req_rd(req_rd),
.req_q(req_q),
//arm spi
.spi_csn(spi_csn),
.spi_sck(spi_sck),
.spi_miso(spi_miso),
.spi_mosi(spi_mosi),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



endmodule
