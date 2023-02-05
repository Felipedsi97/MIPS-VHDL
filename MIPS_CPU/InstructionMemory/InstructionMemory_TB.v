`timescale 1ns/10ps
module InstructionMemory_TB();
parameter data_WIDTH = 32;
parameter ADDR_WIDTH = 10;

reg [ADDR_WIDTH-1:0] address;
reg clk;
wire [data_WIDTH-1:0] dataOut;
integer k = 0;

InstructionMemory DUT
(
	.address(address),  
	.clk(clk), 
	.dataOut(dataOut)
);

initial begin
	clk = 0;
	address = 10'b0;	
	
	for (k=0; k < 10; k = k + 1) 
	begin
		#50 address = k;
	end
	
end

always #50 clk = ~clk;
initial #2000 $stop;

endmodule
