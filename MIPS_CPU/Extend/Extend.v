module Extend (
	input  [15:0] Offset,
	output reg [31:0] ext,
	input Enable
);

	always @ (*)
	begin
	ext = 0;
		if(Enable)
		begin
			if(Offset[15]) ext = {16'b1111111111111111,Offset[15:0]};
			else ext = {16'b0,Offset[15:0]};
		end
	end

endmodule 