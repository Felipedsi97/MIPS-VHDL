`timescale 1ns/10ps
module Extend_TB ();

	reg [15:0] Offset;
	reg Enable;
	wire [31:0] ext;
	
	Extend DUT (
	.Offset(Offset),
	.ext(ext),
	.Enable(Enable)
	);
	
	initial
	begin
		Enable = 1;
		Offset = 16'b1000000000000000;
		
		#10 Offset = 16'b0111111111111111;
		#10 Enable = 0;
		
		#10 $stop;
	end
	
endmodule
