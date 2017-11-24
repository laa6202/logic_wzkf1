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

//--------- tx_bit ---------
wire [19:0] tbit_period;
assign tbit_period =(tbit_fre == 16'd10000) ? 20'd10 :
										(tbit_fre == 16'd5000) ? 20'd20 :
										(tbit_fre == 16'd2000) ? 20'd50 :
										(tbit_fre == 16'd1000) ? 20'd100 :
										(tbit_fre == 16'd500) ? 20'd200 :
										(tbit_fre == 16'd100) ? 20'd1000 :
										(tbit_fre == 16'd50) ? 20'd2000 :
										(tbit_fre == 16'd10) ? 20'd10000 :
										(tbit_fre == 16'd1) ? 20'd100000 : 20'd10;

reg [31:0] cnt_tx;
wire tbit_vld;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_tx <= 32'h0;
	else if(tbit_vld)
		cnt_tx <= cnt_tx + 32'h1;
	else ;
end
										
reg [19:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 20'h0;
	else if(cnt_cycle == tbit_period)
		cnt_cycle <= 20'h1;
	else if(cnt_tx < tx_total)
		cnt_cycle <= cnt_cycle + 20'h1;
	else ;
end

assign tbit_vld =  (cnt_cycle == tbit_period) ? 1'b1 : 1'b0;

reg tx;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		tx <= 1'b1;
	else if(tbit_vld)
		tx <= ~tx;
	else ;
end
wire now_send = (cnt_tx < tx_total) ? 1'b1 : 1'b0;

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

