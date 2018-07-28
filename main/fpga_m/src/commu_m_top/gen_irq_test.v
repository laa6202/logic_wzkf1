//gen_irq_test.v

module gen_irq_test(
stu_irq_test,
//clk rst
pluse_us,
clk_sys,
rst_n
);
output [7:0]	stu_irq_test;
//clk rst
input pluse_us;
input clk_sys;
input rst_n;
//-------------------------------------
//-------------------------------------

wire pluse_int;
wire pluse_int_half;
reg [29:0] cnt_us;
wire finish_pluse;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_us <= 30'h0;
	else if(pluse_us) begin
		if(finish_pluse)
			;
		else 
			cnt_us <= (cnt_us == 30'd21_999) ? 30'h0 : (cnt_us + 30'h1);
	end else ;
end
assign pluse_int = pluse_us & (cnt_us == 30'd21_999);
assign pluse_int_half = pluse_us & (cnt_us == 30'd10_999);

reg [19:0] cnt_pluse;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_pluse <= 20'h0;
	else if(pluse_int)
		cnt_pluse <= cnt_pluse + 20'h1;
	else ;
end
assign finish_pluse = (cnt_pluse == 20'd2000) ? 1'b1 : 1'b0;


//--------- output --------
reg [7:0]	stu_irq_test;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		stu_irq_test <= 8'b0;
	else if(pluse_int_half)
		stu_irq_test <= 8'hff;
	else if(pluse_int)
		stu_irq_test <= 8'h00;
	else ;
end

endmodule
