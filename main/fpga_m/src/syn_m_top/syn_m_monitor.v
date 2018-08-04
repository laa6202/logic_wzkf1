//monitor.v

module syn_m_monitor(
//control 
fire_tx,
data_tx,
pluse,
//clk rst
err,
pluse_us,
clk_sys,
rst_n
);
input 			fire_tx;
input [7:0]	data_tx;
//clk rst
input pluse;
output	err;
input pluse_us;
input	clk_sys;
input	rst_n;
//--------------------------------------
//--------------------------------------

//----------- check data_tx -----------
reg [1:0] cnt_tx;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_tx <= 2'h0;
	else if(fire_tx)
		cnt_tx <= cnt_tx + 2'h1;
	else ;
end
wire d0_vld = fire_tx & (cnt_tx == 2'h0);
wire d3_vld = fire_tx & (cnt_tx == 2'h3);


reg [7:0]	d3_reg;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		d3_reg <= 8'h0;
	else if(d3_vld)
		d3_reg <= data_tx;
	else ;
end

wire err1 = d3_vld & ((d3_reg + 8'h1) != data_tx) | d0_vld;


//----------- check pluse teriod -------------
reg [31:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 32'h0;
	else if(pluse_us)
		cnt_cycle <= cnt_cycle + 32'h1;
	else ;
end

wire err2 = pluse & (cnt_cycle == 32'h0);



wire err = err1 | err2;

endmodule

