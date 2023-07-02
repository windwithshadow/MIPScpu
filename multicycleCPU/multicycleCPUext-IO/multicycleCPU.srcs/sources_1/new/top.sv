module top(
input logic CLK100MHZ,
input logic BTNC,//reset
input logic BTNL,//SW input data
input logic BTNR,//∆ﬂ∂Œ ˝¬Îπ‹œ‘ æ
input logic [15:0] SW,//a:SW[15:8]£¨b:SW[7:0]
output logic [7:0] AN,
output logic [6:0] A2G,
output logic DP);
logic memwrite;
logic [31:0] dataadr, writedata;
logic [31:0] readdata;
// instantiate processor and memories
mips mips(CLK100MHZ, BTNC,memwrite,dataadr, writedata,readdata);
dmdecoder dmem(CLK100MHZ,memwrite,dataadr,writedata,readdata,
    BTNC,BTNL, BTNR,SW,AN,DP,A2G);
endmodule
