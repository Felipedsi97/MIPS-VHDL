`timescale 1ns/100ps
module ADDRDecoding_TB();

	wire CS;
	reg [31:0] ADDR;
	integer i;
	
	ADDRDecoding DUT
	(
		.CS(CS),
		.ADDR(ADDR)
	);
	
	initial
		begin
			for(i = 0; i <= 16'hFFFF; i = i + 1)
				#30 ADDR = i;				
		end
	
endmodule 