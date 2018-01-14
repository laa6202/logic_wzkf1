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
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_rd <= 16'h0;
	else if(real_rd)
		cnt_rd <= cnt_rd + 16'h1;
	else if(cnt_rd == len_pkg)
		cnt_rd <= 16'h0;
	else ;
end

wire buf_frm = (cnt_rd != 16'h0) | real_rd;

endmodule
