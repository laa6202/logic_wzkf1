//syn_dec.v

module syn_dec(
rx_data,
rx_vld,
syn_vld,
utc_sec,
now_ns,
//clk rst
clk_sys,
rst_n
);
input	[7:0]	rx_data;
input				rx_vld;
input 			syn_vld;
output [31:0]	utc_sec;
output [31:0]	now_ns;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------------
//-----------------------------------------------


reg [2:0] cnt_times;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_times <= 3'h0;
	else if(rx_vld)
		cnt_times <= syn_vld ? 3'h0 : (cnt_times + 3'h1);
	else ;
end


reg [31:0] cnt_ns;
always @ (posedge clk_sys or negedge rst_n)	begin	
	if(~rst_n)
		cnt_ns <= 32'h0;
	else if(syn_vld)
		cnt_ns <= 32'h0;
	else 
		cnt_ns <= cnt_ns + 32'h0;
end

endmodule

