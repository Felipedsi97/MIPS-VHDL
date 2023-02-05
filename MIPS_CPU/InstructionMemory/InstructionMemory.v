module InstructionMemory 
#(	parameter data_WIDTH = 32,	parameter ADDR_WIDTH = 10 )

(
	input [ADDR_WIDTH-1:0] address,
	input clk,
	output reg [data_WIDTH-1:0] dataOut
);

reg [data_WIDTH-1:0] memoria [0:(1<<ADDR_WIDTH)-1];

initial
begin
   //codigo com pipeline hazzard
			  
	memoria[0] <= 32'b0;
	memoria[1] <= 32'b0;
	memoria[2] <= 32'b0;
	memoria[3] <= 32'b010010_00000_00001_0101_0101_0000_0000; //Grupo+1 MSB + Load A 5500h LSB
	memoria[4] <= 32'b010010_00000_00010_0101_0101_0000_0001; //Grupo+1 MSB + Load A 5501h LSB
	memoria[5] <= 32'b010010_00000_00011_0101_0101_0000_0010; //Grupo+1 MSB + Load A 5502h LSB
	memoria[6] <= 32'b010010_00000_00100_0101_0101_0000_0011; //Grupo+1 MSB + Load A 5503h LSB
	
	memoria[7] <= 32'b010001_00011_00100_00110_01010_100000; //ADD C+D MSB Grupo
	memoria[8] <= 32'b010001_00001_00010_00101_01010_110010; //MUL A*B MSB Grupo
	memoria[9] <= 32'b010001_00101_00110_00111_01010_100010; //SUB (A*B)-(C+D) MSB Grupo

	memoria[10] <= 32'b010011_00000_00111_0101_1000_1111_1111; //Store (A*B)-(C+D) MSB Grupo+2, 58FFh LSB
   memoria[11] <= 32'b010010_00000_01000_0101_1000_1111_1111; //Load Memory[58FFh] Grupo+1 LSB, 58FFh LSB 
			
	//codigo com bolhas
			  
	memoria[12] <= 32'b0;
	memoria[13] <= 32'b0;
	memoria[14] <= 32'b0;
	memoria[15] <= 32'b010010_00000_00001_0101_0101_0000_0000; //Grupo+1 MSB + Load A 5500h LSB
	memoria[16] <= 32'b010010_00000_00010_0101_0101_0000_0001; //Grupo+1 MSB + Load A 5501h LSB
	memoria[17] <= 32'b010010_00000_00011_0101_0101_0000_0010; //Grupo+1 MSB + Load A 5502h LSB
	memoria[18] <= 32'b010010_00000_00100_0101_0101_0000_0011; //Grupo+1 MSB + Load A 5503h LSB
	memoria[19] <= 32'b0;
	memoria[20] <= 32'b0;
	
	memoria[21] <= 32'b010001_00011_00100_00110_01010_100000; //ADD C+D MSB Grupo
	memoria[22] <= 32'b010001_00001_00010_00101_01010_110010; //MUL A*B MSB Grupo
	memoria[23] <= 32'b0;
	memoria[24] <= 32'b0;
	memoria[25] <= 32'b010001_00101_00110_00111_01010_100010; //SUB (A*B)-(C+D) MSB Grupo
	memoria[26] <= 32'b0;
	memoria[27] <= 32'b0;
	
	memoria[28] <= 32'b010011_00000_00111_0101_1000_1111_1111; //Store (A*B)-(C+D) MSB Grupo+2, 58FFh LSB
	memoria[29] <= 32'b0;
   memoria[30] <= 32'b010010_00000_01000_0101_1000_1111_1111; //Load Memory[58FFh] Grupo+1 LSB, 58FFh LSB 
	memoria[31] <= 32'b0;
	memoria[32] <= 32'b0;
	memoria[33] <= 32'b0;
	memoria[34] <= 32'b0;
	memoria[35] <= 32'b0;
	memoria[36] <= 32'b0;
	memoria[37] <= 32'b0;
	
end


always @ (posedge clk) 
begin
		dataOut <= memoria[address];
end

endmodule
