//io_filter.v

module io_filter(
io_in,
io_real,
//clk rst
clk_sys,
rst_n
);
input io_in;
output io_real;
//clk rst
input clk_sys;
input rst_n;
//---------------------------------------------
//---------------------------------------------

reg [7:0]	io_reg;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		io_reg <= 8'h0;
	else 
		io_reg <= {io_reg[6:0],io_in};
end


reg io_real;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		io_real <= 1'b0;
	else if(io_reg == 8'h0)
		io_real <= 1'b0;
	else if(io_reg == 8'hff)
		io_real <= 1'b1;
	else ;
end


endmodule
