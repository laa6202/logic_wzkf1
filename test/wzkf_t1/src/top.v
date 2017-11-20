//top.v
//top for WZKF_test1 

module top(
mclk0,
mclk1,
mclk2,
hrst_n

);
input mclk0;
input mclk1;
input mclk2;
input hrst_n;

//----------------------------------
//----------------------------------

wire clk_sys;
wire clk_slow;
wire pluse_us;
wire rst_n;
clk_rst_top u_clk_rst(
.hrst_n(hrst_n),
.mclk0(mclk0),
.mclk1(mclk1),
.mclk2(mclk2),
.clk_sys(clk_sys),
.clk_slow(clk_slow),
.pluse_us(pluse_us),
.rst_n(rst_n)
);




endmodule
