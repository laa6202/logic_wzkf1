
module fetch_monitor(
rx,
tbit_period,
rx_vld,
rx_data,
//clk rst
clk_sys,
rst_n,

test_out
);
input 				rx;
input  [19:0]	tbit_period;
input 				rx_vld;
input [15:0]	rx_data;
//clk rst
input clk_sys;
input rst_n;

output test_out;



reg [15:0] data1;
reg [15:0] data2;
reg [15:0] data3;
reg [15:0] data4;

reg [15:0] data33;
reg [15:0] data44;

always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
	begin
		data1 <= 16'h0;
		data2 <= 16'h0;
		data3 <= 16'h0;
		data4 <= 16'h0;
	end
	else if(rx_vld)
		begin
			data1 <= rx_data;
			data2 <= data1;
			data3 <= data2;
			data4 <= data3;
		end
	end
	
	reg test_out;
always @ (posedge clk_sys or negedge rst_n)	begin
	if(~rst_n)
	begin
		data33 <= 16'h0;
		data44 <= 16'h0;
		test_out <= 1'b0;
	end
	else if((rx_vld)&(data3==16'h5101)&(data2==16'h47d0))
		begin
		    test_out <= ((data33+16'd1)==rx_data)?  1'b0: 1'b1;
			data33 <= rx_data;
		end
		else
			;
	
	end
	


endmodule
