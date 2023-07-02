module mips(input logic clk, reset,
output logic memwrite,
output logic [31:0] adr, writedata,
input logic [31:0] readdata);
logic [5:0]  op, funct;
logic memtoreg, alusrc, regdst,
regwrite,zero,irwrite,alusrca,iord,pcen,immext;
logic [1:0] alusrcb, pcsrc;
logic [2:0] alucontrol;
controller c( clk,reset,
op, funct,
zero,memwrite, irwrite, regwrite,pcen,
alusrcb, pcsrc,alusrca,iord, memtoreg, regdst,immext,alucontrol);
datapath dp(clk, reset,iord, irwrite,memtoreg, regdst,
    pcen,pcsrc,regwrite,alucontrol,alusrca,alusrcb,immext,zero,
    op, funct,
    //from imem/dmem
    readdata,adr,writedata
);
endmodule