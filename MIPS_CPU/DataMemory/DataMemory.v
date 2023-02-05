module DataMemory 
#(	parameter data_WIDTH = 32,	parameter ADDR_WIDTH = 10)

(
	input [ADDR_WIDTH-1:0] address,
	input [data_WIDTH-1:0] dataIn,
	input we,
	input clk,
	output reg [data_WIDTH-1:0] dataOut
);


reg [data_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1]; // 1024 words de 4bytes
reg [31:0] address_correto;

initial 
begin
	mem[0] = 2001;
	mem[1] = 4001;
	mem[2] = 5001;
	mem[3] = 3001;
end

always @ (posedge clk) 
begin
	if(we)
		mem[address_correto] <= dataIn;  //Escrever
	else
		dataOut <= mem[address_correto]; //Ler
end

always @ (*)
begin
	if(address >= 10'h100 && address <= 10'h3FF) 
		address_correto <= address - 10'h100;
	else
		address_correto <= address + 10'h100;
end 

endmodule
