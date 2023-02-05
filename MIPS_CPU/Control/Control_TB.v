`timescale 1ns/10ps
module Control_TB();
reg  [31:0] Instruction;
wire [23:0] Ctrl;
	
	Control DUT 
	(
		.Instruction(Instruction),
		.Ctrl(Ctrl)
	);
	
	initial
	begin
		//formato i       opcode   rs   rt          offset
		Instruction = 32'b010010_00000_00001_0101_0101_0000_0000; //LW
		#20 
		Instruction = 32'b010011_00000_00111_0101_1000_1111_1111; //SW
		#20
		//formato R			opcode   rs    rt    rd       op
		Instruction = 32'b010001_00001_00010_00101_01010_110010; //MUL
		#20
		Instruction = 32'b010001_00011_00100_00110_01010_100000; //ADD
		#20
		Instruction = 32'b010001_00101_00110_00111_01010_100010; //SUB
		#20 $stop;
	end
	
endmodule
