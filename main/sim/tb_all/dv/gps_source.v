//gps_source.v

module gps_source(
gps_pluse,
//clk rst
clk_sys,
rst_n
);
output gps_pluse;
//clk rst
input clk_sys;
input rst_n;
//-----------------------------------------
//-----------------------------------------

reg [19:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 20'h0;
	else 
		cnt_cycle <= cnt_cycle + 20'h1;
end

wire gps_pluse = 	(cnt_cycle == 20'd5) | (cnt_cycle == 20'd1015) |
									(cnt_cycle == 20'd2024) | (cnt_cycle == 20'd3033) |
									(cnt_cycle == 20'd6066) | (cnt_cycle == 20'd9099) ;


endmodule
