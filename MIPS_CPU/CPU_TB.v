`timescale 1ns/100ps

module CPU_TB();
	
	reg CLK;
	reg CLK_SYS, CLK_MUL;
	reg RST;
	wire [31:0] ADDR, Data_BUS_WRITE;
	reg  [31:0] writeBack;
	reg  [31:0] Data_BUS_READ;
	wire CS, WR;
	
	CPU DUT (
	.CLK(CLK),
	.RST(RST),
	.Data_BUS_READ(Data_BUS_READ),
	.ADDR(ADDR), 
	.Data_BUS_WRITE(Data_BUS_WRITE),
	.CS(CS),
	.WR(WR)
	);
	
	initial 
	begin
		$init_signal_spy("DUT/CLK_SYS","CLK_SYS",1);
		$init_signal_spy("DUT/CLK_MUL","CLK_MUL",1);
		$init_signal_spy("DUT/WriteBack","writeBack",1);
				
		CLK = 0;
		RST = 1;
		#100 RST = 0;
		Data_BUS_READ = 32'dz; //highZ	
	end
	
	always #13 CLK = ~CLK;
	
	initial #50000 $stop;
		
	
endmodule 