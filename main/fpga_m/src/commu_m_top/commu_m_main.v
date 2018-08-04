//commu_m_main.v

//3秒ARM无响应，清理一次缓存的包，再发一次边沿中断
`define T_WD_ARM_HIGH 32'd3_000_000_00


module commu_m_main(
repk_frm,
buf_frm,
cnt_pkg_buf,
//configuration
arm_int_n,
stu_buf_rdy,
//clk rst
wd_arm_high,
clk_sys,
rst_n
);
input		repk_frm;
input 	buf_frm;
input [3:0] cnt_pkg_buf;
//configuration
output 	arm_int_n;
output [7:0] stu_buf_rdy;
//clk rst
output wd_arm_high;
input clk_sys;
input rst_n;
//------------------------------------------
//------------------------------------------


reg repk_frm_reg;
reg buf_frm_reg;

always @(posedge clk_sys )	begin
	repk_frm_reg <= repk_frm;
	buf_frm_reg <= buf_frm;

end
wire repk_frm_falling = repk_frm_reg & (~repk_frm);
//wire buf_frm_falling = buf_frm_reg & (~buf_frm);
wire buf_frm_rasing = (~buf_frm_reg) & (buf_frm);



reg arm_int;
wire wd_arm_high;
/*
wire rst_delay_now;
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
*/


parameter S_RST  = 3'h6;
parameter S_IDLE = 3'h0;
//parameter S_CKECK= 3'h1;
parameter S_UP	 = 3'h2;
parameter S_DOWN = 3'h3;
parameter S_DONE = 3'h7;
reg [2:0] st_buf;
wire finish_rst;
wire finish_down;
wire bufpkg_now;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		st_buf <= S_RST;
	else begin
		case(st_buf)
			S_RST : st_buf <= finish_rst ? S_IDLE : S_RST;
			S_IDLE: st_buf <= bufpkg_now ? S_UP : S_IDLE;
			S_UP 	: st_buf <= wd_arm_high ? S_DOWN : 
												buf_frm_rasing ? S_DOWN : S_UP;
			S_DOWN: st_buf <= finish_down ? S_DONE : S_DOWN;
			S_DONE: st_buf <= S_IDLE;
			default : st_buf <= S_IDLE;
		endcase
	end
end

assign finish_rst = ~rst_delay_now;
assign bufpkg_now = (cnt_pkg_buf > 4'h0) ? 1'b1 : 1'b0;
reg [29:0] cnt_down;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_down <= 30'h0;
	else if(st_buf == S_DOWN)
		cnt_down <= cnt_down + 30'h1;
	else 
		cnt_down <= 30'h0;
end
assign finish_down = (cnt_down == 30'd10_000_00) ? 1'b1 : 1'b0;

always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		arm_int <= 1'b0;
	else 
		arm_int = (st_buf == S_UP) ? 1'b1 : 1'b0;
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
//assign wd_arm_high = 1'b0;


wire arm_int_n = ~arm_int;


wire [7:0] stu_buf_rdy;
assign stu_buf_rdy = arm_int_n ? 8'h0 : 8'hff;




endmodule
