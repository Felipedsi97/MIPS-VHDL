# MIPS-VHDL

Arquitetura RISC implementada em FPGA. A CPU em questão é baseada nas
CPUs MIPS. No entanto, não utiliza o mesmo instruction set (IS reduzido). **O projeto foi criado no software Quartus 18.1 Lite e ModelSim-Altera.**

- A Word da arquitetura é definida em 32 bits;
- Todo o sistema é implementado em pipeline;
- Todas as instruções são formadas por 4 bytes;
- A memória de programa tem 1kWord alocados a partir de 0000h;
- A memória de dados tem 1kWord alocados a partir de 5500h;
- A cada Reset, o Program Counter sempre aponta para o endereço 0 da memória de programa;
- Sem instruções de Branch/Jump;


![](/project_description.png)
