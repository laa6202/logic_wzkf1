//fx_bm.v

module fx_bm(
//fx bus
fx_waddr,
fx_wr,
fx_data,
fx_rd,
fx_raddr,
fx_q,
//bm data 
bm_data,
bm_vld,
//clk rst
clk_sys,
rst_n
);
//fx bus
input [15:0]	fx_waddr;
input 				fx_wr;
input [7:0]	fx_data;
input				fx_rd;
input [15:0]	fx_raddr;
input  [7:0]	fx_q;
//bm data 
output [31:0]	bm_data;
output				bm_vld;
//clk rst
input clk_sys;
input rst_n;

//--------------------------------------
//--------------------------------------


//---------- bm_vld ------
wire fx_op = fx_wr | fx_rd;
reg  fx_op_reg;
reg  bm_vld;
always @(posedge clk_sys)	begin
	fx_op_reg <= fx_op;
	bm_vld <= fx_op_reg;
end


//--------- bm_data ---------
reg [31:0] bm_data;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		bm_data <= 32'h0;
	else if(fx_op_reg)
		bm_data[7:0] <= fx_q;
	else if(fx_op)	begin
		bm_data[15:8] <= fx_data;
		bm_data[31:16] <= fx_wr ? (fx_waddr | 16'h8000) : fx_raddr;
	end
	else ;
end
	

endmodule
