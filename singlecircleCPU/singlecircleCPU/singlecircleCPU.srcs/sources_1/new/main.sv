module main(
input logic CLK100MHZ,
input logic [15:0] SW,
output logic[15:0] LED,
output logic[6:0] A2G,
output logic[7:0] AN
    );
//我至少需要3条指令才能实现输入a+b等于c的展示
mips mips1(CLK100MHZ, 0, pc, instr, memwrite, dataadr,
writedata, readdata,overflow);
mips mips2(CLK100MHZ, 0, pc, instr, memwrite, dataadr,
writedata, readdata,overflow);
mips mips3(CLK100MHZ, 0, pc, instr, memwrite, dataadr,
writedata, readdata,overflow);
assign LED=SW;
logic aluout;
logic [31:0] x;
logic [1:0] space1,space2;
Bin2BCD8bit({3'b000,SW[15:11]},{space1,x[31:24]});//sw[15:11]代表第一位输入
Bin2BCD8bit({3'b000,SW[9:5]},{space2,x[23:16]});//sw[15:11]代表第二位输入
Bin2BCD8bit(alout,x[9:0]);
assign x[11:10]=2'b00;
assign x[15:12]=4'b1010;
x7seg x1(x,CLK100MHZ,A2G,AN);
endmodule
