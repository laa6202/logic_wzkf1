//commu_top.v



module commu_top(
tx,
rx,
//configuration
tbit_fre,
tx_total,
rx_total,
now_send,
//clk rst
clk_sys,
rst_n
);
output tx;
input  rx;
//configuration
input [15:0]	tbit_fre;
input [31:0]	tx_total;
output[31:0]  rx_total;
output now_send;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------
//---------------------------------------

wire [19:0] tbit_period;
base u_base(
.tbit_period(tbit_period),
.tbit_fre(tbit_fre)
);

tx_top u_tx_top(
.tx(tx),
//configuration
.tbit_period(tbit_period),
.tx_total(tx_total),
.now_send(now_send),
//clk rst
.clk_sys(clk_sys),
.rst_n(rst_n)
);


//--------- rx_bit ---------
reg [7:0]	rx_reg;
always @ (posedge clk_sys) 
	rx_reg <= {rx_reg[6:0],rx};

reg rx_real;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_real <= 1'b1;
	else if(rx_reg == 8'hff)
		rx_real <= 1'b1;
	else if(rx_reg == 8'h0)
		rx_real <= 1'b0;
	else ;
end
reg rx_real_delay;
always @ (posedge clk_sys)
	rx_real_delay <= rx_real;
wire rx_vld = (rx_real != rx_real_delay) ? 1'b1 : 1'b0;
	
reg [31:0] rx_total;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_total <= 32'h0;
	else if(rx_vld)
		rx_total <= rx_total + 31'h1;
	else ;
end




endmodule

