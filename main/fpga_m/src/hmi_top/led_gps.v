//led_gps.v


module led_gps(
led_gps_n,
gps_pluse,
//clk rst
clk_sys,
pluse_us,
rst_n
);
output 	led_gps_n;
input		gps_pluse;
//clk rst
input clk_sys;
input pluse_us;
input rst_n;
//------------------------------------
//------------------------------------

/*
reg gps_pluse_reg;
always @ (posedge clk_sys)	gps_pluse_reg <= gps_pluse;
wire gps_pluse_rasing;
*/
reg led_gps_n;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
		led_gps_n <= 1'b1;
	else 
		led_gps_n <= ~gps_pluse;
end


endmodule

