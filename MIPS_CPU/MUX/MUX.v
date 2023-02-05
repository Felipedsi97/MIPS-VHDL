module MUX (
	input[31:0] In_A,
	input[31:0] In_B,
	input Sel,
	output reg [31:0] Out
);


	always @ (In_A or In_B or Sel)
	begin
		if(Sel) Out <= In_A;
		else Out <= In_B;
	end
	
endmodule 