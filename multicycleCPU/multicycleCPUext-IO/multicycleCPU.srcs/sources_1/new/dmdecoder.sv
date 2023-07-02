module dmdecoder(
    input  logic        clk,
    input  logic        writeEN,
    input  logic [31:0] addr, //32bit
    input  logic [31:0] writeData,
    output logic [31:0] readData,
    
    input  logic        reset,
    input  logic        btnL, btnR,
    input  logic [15:0] switch,
    output logic [7:0]  an,
    output logic        dp,
    output logic [6:0]  a2g);
    
    logic [11:0] led;
    logic [31:0] digit;
    assign digit = {switch,{4'b0000},led};
    
    logic [31:0] ReadData1, ReadData2;
    
    logic pRead, pWrite, mWrite;
    
    assign pRead = (addr[7] == 1'b1) ? 1:0;
    assign pWrite = (addr[7] == 1'b1) ? writeEN: 0;
    assign mWrite = writeEN & (addr[7] == 1'b0);
    
    mux2 #(32)  rdmux(.d0(ReadData1),
                      .d1(ReadData2),
                      .s(addr[7]),
                      .y(readData));
     
    mem dMemory(.clk(clk),
                .we(mWrite),
                .a(addr),
                .wd(writeData),
                .rd(ReadData1));
    
    io IO(.clk(clk),
          .reset(reset),
          .pRead(pRead),
          .pWrite(pWrite),
          .addr(addr[3:2]),
          .pWriteData(writeData[11:0]),
          .pReadData(ReadData2),
          .buttonL(btnL),
          .buttonR(btnR),
          .switch(switch),
          .led(led));
          
    mux7seg m7seg(.x(digit),
                  .clk(clk),
                  .a2g(a2g),
                  .an(an),
                  .dp(dp));

    
endmodule

