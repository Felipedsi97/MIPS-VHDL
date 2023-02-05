`timescale 1ns/10ps

module Register_TB();

reg rst, clk;
reg [31:0] in;
wire [31:0] out;
	
integer i;
	
Register DUT
(
	.rst(rst),
	.clk(clk),
	.in(in),
	.out(out)
);
	
	
initial 
begin
	clk = 0;
	rst = 1;	
	#10 rst = 0;
		
	for(i = 0; i < 15; i = i + 1) 
	begin	
		#10 in = i;
	end

	#100 $stop;
end
	
always #5 clk = ~clk;
	
endmodule
