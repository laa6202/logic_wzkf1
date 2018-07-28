//commu_m_main.v

//3秒ARM无响应，清理一次缓存的包，再发一次边沿中断
`define T_WD_ARM_HIGH 32'd1_500_000_00


module commu_m_main(
fire_push,
done_push,
repk_frm,
buf_frm,
buf_rd,
//configuration
arm_int_n,
stu_buf_rdy,
//clk rst
wd_arm_high,
debug,
clk_sys,
rst_n
);
output	fire_push;
input		done_push;
input		repk_frm;
input 	buf_frm;
input		buf_rd;
//configuration
output 	arm_int_n;
output [7:0] stu_buf_rdy;
//clk rst
output wd_arm_high;
output debug;
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------


reg repk_frm_reg;
reg buf_frm_reg;
reg buf_rd_reg;
always @(posedge clk_sys )	begin
	repk_frm_reg <= repk_frm;
	buf_frm_reg <= buf_frm;
	buf_rd_reg  <= buf_rd;
end
wire repk_frm_falling = repk_frm_reg & (~repk_frm);
wire buf_frm_falling = buf_frm_reg & (~buf_frm);
wire buf_frm_rasing = (~buf_frm_reg) & (buf_frm);
wire buf_rd_falling = buf_rd_reg & (~buf_rd);


reg arm_int;
wire rst_delay_now;
wire wd_arm_high;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		arm_int <= 1'b0;
	else if(rst_delay_now)
		arm_int <= 1'b0;
//	else if(buf_frm_falling)
	else if(buf_frm_rasing)
		arm_int <= 1'b0;
	else if(repk_frm_falling)
		arm_int <= 1'b1;
	else if(wd_arm_high)
		arm_int <= 1'b0;
	else ;
end


//---------- protect for por and wd ---------
reg [31:0] cnt_por;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_por <= 32'h0;
	else if(cnt_por == 32'hffff_ffff)
		cnt_por <= 32'hffff_ffff;
	else 
		cnt_por <= cnt_por + 32'h1;
end
assign rst_delay_now = (cnt_por < 32'd100_000_00) ? 1'b1 :1'b0;
reg [31:0] cnt_wd;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_wd <= 32'b0;
	else if(arm_int == 1'b1)
		cnt_wd <= cnt_wd + 32'h1;
	else 
		cnt_wd <= 32'h0;
end
assign wd_arm_high = (cnt_wd == `T_WD_ARM_HIGH) ? 1'b1 :1'b0;


wire arm_int_n = ~arm_int;


wire [7:0] stu_buf_rdy;
assign stu_buf_rdy = arm_int_n ? 8'h0 : 8'hff;


//----------- for debug ------------
reg [9:0] cnt_repk_frm;

always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_repk_frm <= 10'h0;
	else if(cnt_repk_frm  == 10'h3ff)
		;
	else if(buf_frm_falling)
		cnt_repk_frm <= cnt_repk_frm + 10'h1;
	else ;
end
wire debug = ^cnt_repk_frm;

endmodule
