`timescale 1ns/10ps
module DataMemory_TB();
parameter data_WIDTH = 32;
parameter ADDR_WIDTH = 10;

	reg [ADDR_WIDTH-1:0] address;
	reg we;
	reg clk;
	reg [data_WIDTH-1:0] dataIn;
	wire [data_WIDTH-1:0] dataOut;
	integer k = 0;

	DataMemory DUT
	(
		.address(address),  
		.we(we), 
		.clk(clk),
		.dataIn(dataIn), 
		.dataOut(dataOut)
	);

initial begin
	
	clk = 0;
	we = 0;
	address = 9'b0;
	dataIn = 32'b0;
	we = 0; 
	
	for (k=0; k < 1024; k = k + 1) 
	begin
		#20 address = k;
	end
	
end

always #10 clk = ~clk;
initial #2300 $stop;

endmodule
