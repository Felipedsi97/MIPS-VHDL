`timescale 1ns/10ps

module MUX_TB();

	reg [31:0] In_A;
	reg [31:0] In_B;
	reg Sel;
	wire [31:0] Out;
	
	MUX DUT (
	.In_A(In_A),
	.In_B(In_B),
	.Sel(Sel),
	.Out(Out)
	);
	
	initial 
	begin
		In_A = 1;
		In_B = 2;
		
		Sel = 1;
		
		#10 Sel = 0;
		
		#200 $stop;
	end

endmodule 