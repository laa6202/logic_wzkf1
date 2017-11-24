//base.v

module base(
tbit_period,
tbit_fre
);
output [19:0]	tbit_period;
input  [15:0]	tbit_fre;

//--------------------------------------------

//--------- tx_bit ---------
wire [19:0] tbit_period;
assign tbit_period =(tbit_fre == 16'd10000) ? 20'd10 :
										(tbit_fre == 16'd5000) ? 20'd20 :
										(tbit_fre == 16'd2000) ? 20'd50 :
										(tbit_fre == 16'd1000) ? 20'd100 :
										(tbit_fre == 16'd500) ? 20'd200 :
										(tbit_fre == 16'd100) ? 20'd1000 :
										(tbit_fre == 16'd50) ? 20'd2000 :
										(tbit_fre == 16'd10) ? 20'd10000 :
										(tbit_fre == 16'd1) ? 20'd100000 : 20'd10;

endmodule

