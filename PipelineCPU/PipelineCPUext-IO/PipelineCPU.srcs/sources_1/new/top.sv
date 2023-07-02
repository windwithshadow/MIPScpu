module top(
input logic CLK100MHZ,
input logic BTNC,//reset
input logic BTNL,//SW input data
input logic BTNR,//七段数码管显示
input logic [15:0] SW,//a:SW[15:8]，b:SW[7:0]
output logic [7:0] AN,
output logic [6:0] A2G,
output logic DP);
logic [31:0] pc;
logic [31:0]  instr;
imem imem(pc[7:2],instr); // output
logic Write;//写信号:可能是memWrite，也可能是ioWrite
logic [31:0] dataAdr, writeData, readData;
mips mips(CLK100MHZ,BTNC,pc,instr,Write,dataAdr,writeData,readData);
dMemoryDecoder dmd(.clk(CLK100MHZ),
                   .writeEN(Write),
                   .addr(dataAdr[7:0]),
                   .writeData(writeData),
                   .readData(readData), //output
                   .reset(BTNC),
                   .btnL(BTNL),
                   .btnR(BTNR),
                   .switch(SW),
                   .an(AN),    //output
                   .dp(DP),
                   .a2g(A2G)); //output
endmodule
