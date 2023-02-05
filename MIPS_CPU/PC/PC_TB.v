`timescale 1ns/10ps

module PC_TB();

	reg Reset, clk;
	wire [9:0] count;
	
	integer k = 0;
	
	PC DUT
	(		
		.Reset(Reset),
		.clk(clk),
		.count(count)	
	);

initial 
begin
	clk = 0;
	Reset = 1;
	#2 Reset = 0;
	
	#500 Reset = 1;
	#505 Reset = 0;
	
	#1300 $stop;
end

always #1 clk = ~clk;

endmodule 