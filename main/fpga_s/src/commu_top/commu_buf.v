//commu_buf.v


module commu_buf(
//pack data output
pk_data,
pk_vld,
pk_frm,
//parmeter 
len_pkg,
//clk rst
clk_sys,
rst_n
);
//pack data output
input [7:0]	pk_data;
input				pk_vld;
input				pk_frm;
//parmeter 
input [15:0]	len_pkg;
//clk rst
input clk_sys;
input rst_n;
//----------------------------------------
//----------------------------------------


reg [15:0]	cnt_buf;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_buf <= 16'h0;
	else if(pk_frm & pk_vld)
		cnt_buf <= cnt_buf + 16'h1;
	else ;
end


endmodule
