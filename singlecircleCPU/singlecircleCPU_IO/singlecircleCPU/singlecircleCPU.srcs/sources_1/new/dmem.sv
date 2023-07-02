module dmem(
    input  logic        clk, we,
    input  logic [7:0]  a,
    input  logic [31:0] wd,
    output logic [31:0] rd);
    
    logic [31:0] RAM[255:0]; //0xFF�ĵ�ַ�ռ�
    assign rd = RAM[a]; //word aligned
    
    always_ff @(posedge clk)
      if (we) RAM[a] <= wd;
    
endmodule

