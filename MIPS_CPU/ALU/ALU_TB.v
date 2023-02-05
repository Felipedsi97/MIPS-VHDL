`timescale 1ns/10ps
module ALU_TB();

	reg[31:0] a;
	reg[31:0] b;
	reg[2:0] load;
	wire[31:0] out;
	integer i;

	ALU DUT
	(
		.a(a),
		.b(b),
		.load(load),
		.out(out)
	);

	initial 
		begin
			a = 32'h0000FFFF;
			b = 32'hFFFF0000;
			load = 3'd0;
			for(i=0;i<4;i=i+1)
				#100 load <= i;
		#1000 $stop;
		end

endmodule
