//top.v
//top for WZKF_test1 

//`define TX_FEQ  16'd10000		//10Mbps
//`define TX_FEQ  16'd5000		//5Mbps
//`define TX_FEQ  16'd2000		//5Mbps
//`define TX_FEQ  16'd1000		//1Mbps
//`define TX_FEQ  16'd500			//500kbps
//`define TX_FEQ  16'd100			//100kbps
//`define TX_FEQ  16'd50		 	//50kbps
//`define TX_FEQ  16'd10		 	//10kbps
//`define TX_FEQ  16'd1			  //1kbps
`define TX_FEQ  		32'd5000
`define TX_COUNT		32'd100		//number of send bits 

module top(
mclk0,
mclk1,
mclk2,
hrst_n,
//
tx,
rx,
led_commu,
led_ok

);
input mclk0;
input mclk1;
input mclk2;
input hrst_n;
//
output tx;
input  rx;
output led_commu;
output led_ok;
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


//---------- commu_top -------------
wire [15:0] tbit_fre = `TX_FEQ;
wire [31:0] tx_total = `TX_COUNT;
wire [31:0]	rx_total;
wire now_send;
commu_top u_commu(
.tx(tx),
.rx(rx),
//configuration
.tbit_fre(tbit_fre),
.tx_total(tx_total),
.rx_total(rx_total),
.now_send(now_send),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);
wire led_commu = now_send;
wire led_ok = (tx_total == rx_total) ? 1'b1 : 1'b0;

endmodule
