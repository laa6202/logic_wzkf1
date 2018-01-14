//commu_m_main.v

module commu_m_main(
fire_push,
done_push,
arm_int_n,
repk_frm,
buf_frm,
//clk rst
clk_sys,
rst_n
);
output	fire_push;
input		done_push;
output 	arm_int_n;
input		repk_frm;
input 	buf_frm;
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

endmodule
