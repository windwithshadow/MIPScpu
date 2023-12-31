module mem(
    input  logic        clk,
    input  logic        we,
    input  logic [31:0] a, wd, //adr, writedata
    output logic [31:0] rd); 

    logic [31:0] RAM[63:0];
    
    initial
      $readmemh("memfile.dat", RAM);
    
    //read����߼� 
    assign rd = RAM[a[31:2]];
    //writeʱ���߼�
    always_ff @(posedge clk)
      if (we) RAM[a[31:2]] <= wd;
endmodule

