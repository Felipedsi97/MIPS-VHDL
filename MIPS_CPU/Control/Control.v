module Control (
	input[31:0] Instruction, 
	output[23:0] Ctrl
);

	reg RW;                
	reg[1:0] Alu;         
	reg Enable_Offset;     
	reg Mux_Alu_In;        
	reg Mux_Alu_Out;       
	reg Mux_WB;            
	reg WR;                
	reg Hab_MUL;			  
	reg[4:0] Rs;		     
	reg[4:0] Rt;
	reg[4:0] Rd;	        
	
	
	assign Ctrl = {RW, Alu, Enable_Offset, Mux_Alu_In, Mux_Alu_Out, Mux_WB, WR, Hab_MUL,
	Rs, Rt, Rd}; 
	
	always @ (Instruction)
	begin
		Rs = Instruction[25:21];
		Rt = Instruction[20:16];
		WR = 0;
		Hab_MUL = 0;
		Alu = 0;
		Mux_Alu_In = 0;    
		Mux_Alu_Out = 1;
		Rd = 0;
		Mux_WB = 0;
		Enable_Offset = 0;
		RW = 0;
	// Instrucoes I
	if(Instruction[31:26] == 32'd18) // LW - Grupo+1 = 18 	
		begin
			Hab_MUL = 0;
			RW = 1;            
			Alu = 0;           		
			Enable_Offset = 1; 
			Mux_Alu_In = 1;    
			Mux_Alu_Out = 1;   
			Mux_WB = 1;        
			WR = 0;            
			Rd = Rt; 											
	end
	
	if(Instruction[31:26] == 32'd19) // SW - Grupo+2 = 19
	begin
			RW = 0;            
			Alu = 0;           		
			Enable_Offset = 1; 
			Mux_Alu_In = 1;    
			Mux_Alu_Out = 1;   
			Mux_WB = 1;        
			WR = 1;             
			Rd = 0;
	end
	
	// Instruções R
	if(Instruction[31:26] == 32'd17) // Grupo = 17
	begin
		Rd = Instruction[15:11];
		RW = 1;
		Enable_Offset = 0; 
		Mux_Alu_In = 0;
		Mux_WB = 0;        
		WR = 0;            
		if(Instruction[10:6] == 10 && Instruction[5:0] == 50) //MUL
		begin
			Hab_MUL = 1;
			Mux_Alu_Out = 0;
		end
		
		else if(Instruction[10:6] == 10 && Instruction[5:0] == 32) //ADD
		begin			            
			Alu = 0; 
			Hab_MUL = 0;	
			Mux_Alu_Out = 1;        
		end
		
		else if(Instruction[10:6] == 10 && Instruction[5:0] == 34) //SUB
		begin
			Alu = 1;
			Hab_MUL = 0;
			Mux_Alu_Out = 1;
		end
		
		else if(Instruction[10:6] == 10 && Instruction[5:0] == 36) //AND
		begin
			Alu = 2;
			Hab_MUL = 0;
			Mux_Alu_Out = 1;
		end
		
		else if(Instruction[10:6] == 10 && Instruction[5:0] == 37) //OR
		begin
			Alu = 3;
			Hab_MUL = 0;
			Mux_Alu_Out = 1;
		end
	end
	end


endmodule 