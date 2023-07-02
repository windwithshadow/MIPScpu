module controller(
input logic clk,
input logic reset,
input logic [5:0] op, funct,
input logic zero,
output logic memwrite, irwrite, regwrite,pcen,
output logic [1:0]alusrcb, pcsrc,
output logic alusrca,iord, memtoreg, regdst,immext,
output logic [2:0] alucontrol);
logic pcwrite;
logic [2:0] aluop;
logic branch;
maindec md(clk,reset,op,pcwrite, memwrite, irwrite, regwrite,
           alusrca, branch, iord, memtoreg, regdst,immext, branchbne,
           alusrcb, pcsrc, aluop);
aludec ad(funct, aluop, alucontrol);
assign pcen = pcwrite|(branch & zero)|(branchbne& (~zero));
endmodule