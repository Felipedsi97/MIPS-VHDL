module PC 
(
	input Reset, clk,
	output reg [9:0] count
);
	
	always @ (posedge clk) 
	begin									
			if (Reset) 
			begin
					count = 9'b0;
			end 
			else 
			begin
					count = count + 9'b1;
			end
	end
endmodule
