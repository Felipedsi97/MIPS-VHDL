Obs: A memória foi sintetizada na BRAM, os Resets foram realizados de forma síncrona, assim como as memórias. O sistema funcionou quase como esperado, com alguns erros de valores em alguns casos.


a) Como existem 5 estágios de pipeline, a latência é de 5 pulsos de clock

b) Uma instrução a cada 5 pulsos de clock (32bits/5*clksys).

c)
	Cyclone IV GX: EP4CGX150DF31I7AD
	Frequência Máxima Multiplicador: 231,21 MHz
	Frequência Máxima Sistema: 46,56 MHz

d) Define-se como a frequência do multiplicador dividido pelo número de ciclos de clock necessários para gerar a resposta.
FPGA - Cyclone IV GX: EP4CGX150DF31I7AD
Frequência Máxima do Sistema: 231,21 MHz / 34 = 6,80 MHz
                              
e) Não executa corretamente em forma de sequência ininterrupta, pois acontecem pipeline hazzards como, por exemplo, a ALU realizar uma operação com um operando que ainda não foi carregado para os registradores. Para resolver esse problema, o assembler fica encarregado de inserir bolhas no pipelina. No nosso caso realizamos manualmente.

f) Não haverá metaestabilidade devido ao fato do clock do multiplicador ser múltiplo do clock do sistema e a utilização da PLL para garantir a borda de subida final e inicial em fase entre os clocks.
	
g) O multiplicador utilizado (shift add) não é um multiplicador adequado para esse sistema, devido a necessidade de vários pulsos de clock para apresentar o resultado. Seria interessante encontrar outro circuito que não limitasse a frequência do sistema.

h) Alteração no multiplicador do circuito (outros algoritmos), adição de mais estágios no pipeline (1 instrução a cada 38 ciclos de clock, frequência maior, período menor). Realizar um trade off de área/velocidade (Utilizar registradores de 64bits, o throughput seria dobrado se conciliado com outro algoritmo de multiplicação), visto que a FPGA não foi utilizada nem perto dos 10% da sua capacidade para o circuito projetado. Desenrolar o pipeline (5 instruções a cada ciclo de clock do sistema).
*/


module CPU 
(
	input CLK, RST, 
	input[31:0] Data_BUS_READ,
	output[31:0] ADDR, Data_BUS_WRITE,
	output CS, WR
);

	(*keep=1*) wire CLK_SYS, CLK_MUL;
	
	(*keep=1*) wire [31:0] WriteBack;
	
	wire [9:0] wire_address;
	
	
	(*keep=1*) wire [31:0] out_produto, wire_A, wire_B, instruction_w, D_out,
	M_in, REG_CS, Memory_w, D_in, alu_w, mux_alu_in, imm_w,
	ctrl1_w, ctrl2_w, ctrl3_w, ctrl4_w, offset_ext;
 		

assign WR = ctrl3_w[16]; 

//Descricao estrutural
InstructionMemory ProgramMemory (
	.address(wire_address),
	.clk(CLK_SYS),
	.dataOut(instruction_w)
);

PC PC (
	.Reset(RST),
	.clk(CLK_SYS),
	.count(wire_address)
);

Register Reg_CS (
	.rst(RST),
	.clk(CLK_SYS),
	.in(CS),      
	.out(REG_CS)	
);

Register D2 (
	.rst(RST),
	.clk(CLK_SYS),
	.in(ADDR),      
	.out(D_out)	
);

Register CRTL3 (
	.rst(RST),
	.clk(CLK_SYS),
	.in(ctrl3_w),      
	.out(ctrl4_w)	
);

MUX Mux_WB (
	.In_A(M_in),
	.In_B(D_out),
	.Sel(ctrl4_w[17]), 
	.Out(WriteBack)
);

PLL PLL( 
	.areset(RST),
	.inclk0(CLK),
	.c0(CLK_MUL),
	.c1(CLK_SYS)
);

RegisterFile RegisterFile (
	.dataIn(WriteBack),
	.we(ctrl4_w[23]),
	.clk(CLK_SYS),
	.rst(RST),
	.rs(ctrl1_w[14:10]),
	.rt(ctrl1_w[9:5]),
	.rd(ctrl4_w[4:0]),
	.A(wire_A),
	.B(wire_B)
);	

Control Control (
	.Instruction(instruction_w),  
	.Ctrl(ctrl1_w)
);

Extend Extend (
	.Offset(instruction_w[15:0]),
	.ext(offset_ext),
	.Enable(ctrl1_w[20])
);

Register IMM (
	.rst(RST), 
	.clk(CLK_SYS),
	.in(offset_ext),      
	.out(imm_w)	
);

Register CRTL1 (
	.rst(RST),
	.clk(CLK_SYS),
	.in({8'b0,ctrl1_w}),      
	.out(ctrl2_w)	
);

MUX Mux_Alu_In (
	.In_A(imm_w), 
	.In_B(wire_B), 
	.Sel(ctrl2_w[19]),
	.Out(mux_alu_in)
);

Register CRTL2 (
	.rst(RST),
	.clk(CLK_SYS),
	.in(ctrl2_w),      
	.out(ctrl3_w)	
);

ALU ALU (
	.a(wire_A),
	.b(mux_alu_in),
	.load(ctrl2_w[22:21]),
	.out(alu_w)
);

MUX Mux_Alu_Out (
	.In_A(alu_w), 
	.In_B(out_produto), 
	.Sel(ctrl2_w[18]),
	.Out(D_in)
);

multiplicador MUL(
	.St(ctrl2_w[15]), 
	.Clk(CLK_MUL), 
	.Produto(out_produto),
	.Multiplicador(wire_A),
	.Multiplicando(wire_B)
);

Register D (
	.rst(RST),
	.clk(CLK_SYS),
	.in(D_in),      
	.out(ADDR)	
);

Register Reg_B2 (
	.rst(RST),
	.clk(CLK_SYS),
	.in(wire_B),      
	.out(Data_BUS_WRITE)	
);
	
DataMemory DataMemory (
	.address(ADDR[9:0]),
	.dataIn(Data_BUS_WRITE),
	.we(ctrl3_w[16]),
	.clk(CLK_SYS),
	.dataOut(Memory_w)
);

MUX Mux_Memory (
	.In_A(Data_BUS_READ), 
	.In_B(Memory_w), 
	.Sel(REG_CS), 
	.Out(M_in)
);

ADDRDecoding ADDRDecoding(
	.ADDR(ADDR),
	.CS(CS)
);

endmodule
