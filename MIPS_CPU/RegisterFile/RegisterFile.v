module RegisterFile 
#(parameter DATA_WIDTH = 32)
(
	input [DATA_WIDTH-1:0] dataIn,
	input we,
	input clk, rst,
	input [4:0] rs,rt,rd,
	output reg [DATA_WIDTH-1:0] A,B
);

	integer i;
	
	reg [DATA_WIDTH-1:0] register [0:15];
	
	always @ (negedge clk, posedge rst) 
	begin
	i = 0;
		if(rst)
			for(i = 0; i < 16; i = i+1) 
			begin
				register[i] = 32'b0;
			end
		else if (we) 
			register[rd] <= dataIn;
	end
	
	always @ (posedge clk) 
	begin
			A <= register[rs];
			B <= register[rt];
	end

endmodule
