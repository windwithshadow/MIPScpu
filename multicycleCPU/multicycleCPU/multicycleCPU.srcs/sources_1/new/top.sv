module top(input logic clk, reset,
output logic [31:0] writedata, dataadr,
output logic memwrite);
logic [31:0] pc, instr, readdata;
// instantiate processor and memories
mips mips(clk, reset,memwrite,dataadr, writedata,readdata);
mem dmem(clk, memwrite, dataadr, writedata, readdata);
endmodule
