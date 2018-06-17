//commu_m_push.v

module commu_m_push(
//control signal
fire_push,
done_push,
//read path
buf_rd,
buf_frm,
buf_q,
real_rd,
real_q,
len_pkg,
//clk rst
clk_sys,
rst_n
);
//control signal
input  fire_push;
output done_push;
//read path
output buf_rd;
output buf_frm;
input [7:0]	buf_q;
input 				real_rd;
output [7:0]	real_q;
input [15:0]	len_pkg;
//clk rst
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------


//---------- data path ---------
wire buf_rd = real_rd;
wire [7:0]	real_q = buf_q;

reg [15:0] cnt_rd;
wire wd_rd_idle;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_rd <= 16'h0;
	else if(real_rd)
		cnt_rd <= cnt_rd + 16'h1;
	else if(cnt_rd == len_pkg)
		cnt_rd <= 16'h0;
	else if(wd_rd_idle)
		cnt_rd <= 16'h0;
	else ;
end

reg [29:0] cnt_rd_idle;
always @ (posedge clk_sys or negedge rst_n)	begin	
	if(~rst_n)
		cnt_rd_idle <= 30'h0;
	else if(real_rd)
		cnt_rd_idle <= 30'h0;
	else if(cnt_rd_idle == 30'h3fff_ffff)
		cnt_rd_idle <= 30'h3fff_ffff;
	else 
		cnt_rd_idle <= cnt_rd_idle + 30'h1;
end
assign wd_rd_idle = (cnt_rd_idle == 30'd100_000_00) ? 1'b1 : 1'b0;


wire buf_frm = (cnt_rd != 16'h0) | real_rd;

endmodule
