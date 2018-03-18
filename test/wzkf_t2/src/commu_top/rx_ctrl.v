//rx_ctrl.v

module rx_ctrl(
rx_total,
rx_error,
tx_pattern,
rx_data,
rx_vld,
//clk rst
clk_sys,
rst_n
);
output [31:0]	rx_total;
output				rx_error;
input			tx_pattern;
input [7:0]	rx_data;
input				rx_vld;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------


reg [7:0] goldern;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		goldern <= tx_pattern ? 8'h0 : 8'h55;
	else if(rx_vld)
		goldern <= tx_pattern ? (goldern + 8'h1) : 8'h55;
	else ;
end


reg [31:0] rx_total;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_total <= 32'h0;
	else if(rx_vld)
		rx_total <= (rx_data == goldern) ? (rx_total + 32'h1) : rx_total ;
	else ;
end


reg rx_error;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		rx_error <= 1'b0;
	else if(rx_vld & (rx_data != goldern))
		rx_error <= 1'b1;
	else ;
end

endmodule
