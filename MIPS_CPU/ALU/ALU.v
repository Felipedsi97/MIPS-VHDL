module ALU
#(parameter DATA_WIDTH = 32)
(
	input[DATA_WIDTH-1:0] a, 
	input[DATA_WIDTH-1:0] b,
	input[1:0] load,
	output reg [DATA_WIDTH-1:0] out
);

	always @ (*) 
	begin
		case(load)
			2'b00: out <= a + b; //Soma
			2'b01: out <= a - b;	//Subtração
			2'b10: out <= a & b; //AND
			2'b11: out <= a | b; //OR
		endcase			
	end

endmodule 