module tb;

wire mclk0;		//clk50m
wire mclk1;		//clk100m
wire mclk2;		//clk1m
wire rst_n;

clk_gen u_clk_gen(
.clk_50m(mclk0),
.clk_100m(mclk1),
.clk_1m(mclk2)
);

rst_gen u_rst_gen(
.rst_n(rst_n)
);

wire clk_sys = mclk1;


//------------ ctrl source ------------
wire [7:0]	dev_id;
wire [7:0]	mod_id;
wire [7:0] 	cmd_addr;
wire [7:0]	cmd_data;
wire				cmd_vld;

cmd_gen u_cmd_gen(
.dev_id(dev_id),
.mod_id(mod_id),
.cmd_addr(cmd_addr),
.cmd_data(cmd_data),
.cmd_vld(cmd_vld)
);


wire cspi_csn;
wire cspi_sck;
wire cspi_miso;
wire cspi_mosi;
arm_ctrl_top u_arm_ctrl(
.cspi_csn(cspi_csn),
.cspi_sck(cspi_sck),
.cspi_miso(cspi_miso),
.cspi_mosi(cspi_mosi),
//configuration
.dev_id(dev_id),
.mod_id(mod_id),
.cmd_addr(cmd_addr),
.cmd_data(cmd_data),
.cmd_vld(cmd_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);

sim_ctrl_top u_tx_ctrl(
.tx_ctrl(),
//configuration
.dev_id(dev_id),
.mod_id(mod_id),
.cmd_addr(cmd_addr),
.cmd_data(cmd_data),
.cmd_vld(cmd_vld),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//------------ arm data spi --------------
wire pspi_csn;
wire pspi_sck;
wire pspi_miso;
wire pspi_mosi;
arm_spi u_arm_spi(
//arm spi
.spi_csn(pspi_csn),
.spi_sck(pspi_sck),
.spi_miso(pspi_miso),
.spi_mosi(pspi_mosi),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//--------- salve mcu --------
wire mcu_csn;
wire mcu_sck;
wire mcu_miso;
wire mcu_mosi;
wire mcu_sel;
smcu u_smcu(
.mcu_csn(mcu_csn),
.mcu_sck(mcu_sck),
.mcu_miso(mcu_miso),
.mcu_mosi(mcu_mosi),
.mcu_sel(mcu_sel),
.cfg_id(),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//------------ gps source ------------
wire gps_pluse;
gps_source u_gps_source( 
.gps_pluse(gps_pluse),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);



//---------- DUT -----------
wire tx_ctrl;
wire ctrl_0_1 = tx_ctrl;
wire ctrl_0_2 = tx_ctrl;
wire syn_0_1;
wire syn_0_2 = syn_0_1;
wire rx_a;
wire rx_b;

top_m u_top_m(
//arm spi
.pspi_csn(pspi_csn),
.pspi_sck(pspi_sck),
.pspi_miso(pspi_miso),
.pspi_mosi(pspi_mosi),
.cspi_csn(cspi_csn),
.cspi_sck(cspi_sck),
.cspi_miso(cspi_miso),
.cspi_mosi(cspi_mosi),

//485 line
.tx_ctrl(tx_ctrl),
.tx_syn(syn_0_1),
.rx_a(rx_a),
.rx_b(),
//gps inf
.gps_pluse(gps_pluse),		
//clk rst
.led1(),
.mclk0(mclk0),
.mclk1(mclk1),
.mclk2(mclk2),
.hrst_n(rst_n)
);


wire tx_a0,tx_a1;
wire de_a0,de_a1;
top_s top_s1(
//adc interface
.ad_mclk(ad_mclk),
.ad_clk(ad_clk),
.ad_din(1'b0),
.ad_cfg(ad_cfg),
.ad_sync(ad_sync),
//485 line
.rx_ctrl(ctrl_0_1),
.rx_syn(syn_0_1),
.tx_a(tx_a0),
.te_a(),
.re_a(),
//mcu port
.mcu_csn(mcu_csn),
.mcu_sck(mcu_sck),
.mcu_miso(mcu_miso),
.mcu_mosi(mcu_mosi),
.mcu_sel(mcu_sel),
.mcu_a(),
//clk rst 
.mclk0(mclk0),
.mclk1(mclk1),
.mclk2(mclk2),
.hrst_n(rst_n)
);


top_s top_s2(
//adc interface
.ad_mclk(),
.ad_clk(),
.ad_din(1'b0),
.ad_cfg(),
.ad_sync(),
//485 line
.rx_ctrl(ctrl_0_2),
.rx_syn(syn_0_2),
.tx_a(),
.te_a(),
.re_a(),
//mcu port
.mcu_csn(mcu_csn),
.mcu_sck(mcu_sck),
.mcu_miso(),
.mcu_mosi(mcu_mosi),
.mcu_sel(mcu_sel),
.mcu_a(),
//clk rst 
.mclk0(mclk0),
.mclk1(mclk1),
.mclk2(mclk2),
.hrst_n(rst_n)
);

assign rx_a = tx_a0 ;
							 

endmodule
