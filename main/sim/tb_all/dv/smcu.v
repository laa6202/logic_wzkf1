//smuc.v

module smcu(
mcu_csn,
mcu_sck,
mcu_miso,
mcu_mosi,
mcu_sel,
cfg_id,
//clk rst
clk_sys,
rst_n
);
//mcu port
output mcu_csn;
output mcu_sck;
input  mcu_miso;
output mcu_mosi;
output mcu_sel;
output cfg_id;
//clk rst
input clk_sys;
input rst_n;
//--------------------------------------------
//--------------------------------------------

//reg sck;


reg sck;
reg csn;
reg mosi;

initial begin
	sck <= 1'b1;
	csn <= 1'b1;
	mosi <= 1'b1;
end

task sck_gen;
input [7:0]	data;
begin
				csn <= 1'b0;
	#500  sck <= 1'b0;
				mosi <= data[7];
	#200	sck <= 1'b1;
	#200	sck <= 1'b0;
				mosi <= data[6];
	#200	sck <= 1'b1;
	#200	sck <= 1'b0;
				mosi <= data[5];
	#200	sck <= 1'b1;
	#200	sck <= 1'b0;
				mosi <= data[4];
	#200	sck <= 1'b1;
	#200	sck <= 1'b0;
				mosi <= data[3];
	#200	sck <= 1'b1;
	#200	sck <= 1'b0;
				mosi <= data[2];
	#200	sck <= 1'b1;
	#200	sck <= 1'b0;
				mosi <= data[1];
	#200	sck <= 1'b1;
	#200	sck <= 1'b0;
				mosi <= data[0];
	#200	sck <= 1'b1;
	#500  csn <= 1'b1;
				mosi <= 1'b1;
end
endtask



initial begin
		#5000 sck_gen(8'h54);
		#5000 sck_gen(8'h85);
end


wire mcu_sck;
wire mcu_csn;
wire mcu_mosi;
assign mcu_csn = csn;
assign mcu_sck = sck;
assign mcu_mosi = mosi;




endmodule
