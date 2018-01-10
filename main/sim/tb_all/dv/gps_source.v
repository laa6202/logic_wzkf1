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

reg [29:0] cnt_cycle;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		cnt_cycle <= 30'h0;
	else 
		cnt_cycle <= cnt_cycle + 30'h1;
end

wire gps_pluse = 	(cnt_cycle == 30'd5) | (cnt_cycle == 30'd10015) |
									(cnt_cycle == 30'd20024) | (cnt_cycle == 30'd30033) |
									(cnt_cycle == 30'd60066) | (cnt_cycle == 30'd90099) ;


endmodule
