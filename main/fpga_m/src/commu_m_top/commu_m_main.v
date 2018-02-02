//commu_m_main.v

module commu_m_main(
fire_push,
done_push,
repk_frm,
buf_frm,
//configuration
arm_int_n,
stu_buf_rdy,
//clk rst
clk_sys,
rst_n
);
output	fire_push;
input		done_push;
input		repk_frm;
input 	buf_frm;
//configuration
output 	arm_int_n;
output [7:0] stu_buf_rdy;
//clk rst
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
wire buf_frm_falling = buf_frm_reg & (~buf_frm);


reg arm_int_n;
always @(posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		arm_int_n <= 1'b1;
	else if(buf_frm_falling)
		arm_int_n <= 1'b1;
	else if(repk_frm_falling)
		arm_int_n <= 1'b0;
	else ;
end


wire [7:0] stu_buf_rdy;
assign stu_buf_rdy = arm_int_n ? 8'h0 : 8'hff;

endmodule
