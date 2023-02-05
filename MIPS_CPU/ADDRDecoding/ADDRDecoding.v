module ADDRDecoding
(
	input [31:0] ADDR,
	output reg CS
);
	reg [31:0] inf, sub;
	
	//5500h a 58FFh
	always @ (*)
	begin
		inf = 32'h5500;
		sub = 32'h58FF;
		if(ADDR[31:0] >= inf) 
			begin
				if(ADDR[31:0] <= sub) CS = 0; //Intervalo do Grupo
				else CS = 1; //Outros chips
			end
		else CS = 1;	
	end 
	
endmodule 