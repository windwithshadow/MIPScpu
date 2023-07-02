module datapath(
    input  logic        clk, reset,
    
    //from control
    input  logic        iord, irwrite,
    input  logic        memtoreg, regdst,
    input  logic        pcen, 
    input  logic [1:0]  pcsrc,
    input  logic        regwrite,
    input  logic [2:0]  alucontrol,
    input  logic        alusrca,
    input  logic [1:0]  alusrcb,
    output logic        zero,
    output logic [5:0]  op, funct,
    
    //from imem/dmem
    input  logic [31:0] rd, //readdata
    output logic [31:0] adr,
    output logic [31:0] wd);//writedata
       
    //logic
    logic [31:0] pcnext, pc;
    logic [31:0] instr, data;
    logic [31:0] signimm, signimmsh;
    logic [31:0] wd3, rd1, rd2;
    logic [4:0]  a3;
    logic [27:0] jumpadr;
    logic [31:0] pcjump;
    logic [31:0] srca, srcb, a, b;
    logic [31:0] aluresult, aluout; 
    
    //control
    assign op = instr[31:26];
    assign funct = instr[5:0];
    
    //mem
    assign wd = b;
    
    //next PC  logic
    muxpc   #(32) pcout(aluresult, aluout, pcjump, pcsrc, pcnext); 
    flopenr #(32) pcreg(clk, reset, pcen, pcnext, pc); //pc¸üÐÂ³Épcnext
    mux2    #(32) pcadr(pc, aluout, iord, adr);
 
    //instruction or data
    flopenr  #(32) instrfp(clk, reset, irwrite, rd, instr);
    flopr    #(32) datafp(clk, reset, rd, data);
    
                      
    //register file logic
    regfile      rf(clk, regwrite, instr[25:21], instr[20:16],
                   a3, wd3, rd1, rd2);
    flopr2 #(32) rdfp(clk, reset, rd1, rd2, a, b);
    mux2   #(5)  wrmux(instr[20:16], instr[15:11],
                       regdst, a3);
    mux2   #(32) wdmux(aluout, data, memtoreg, wd3);
    
    //imm
    signext     se(instr[15:0], signimm);
    sl2         immsh(signimm, signimmsh);
    
    //jump
    assign jumpadr = {instr[25:0], 2'b00};
    assign pcjump = {pc[31:28], jumpadr};
    
    //ALU logic
    mux2 #(32)  srcamux(pc, a, alusrca, srca); //srca
    muxb #(32)  srcbmux(b,signimm, signimmsh, alusrcb, srcb); //srcb
    alu         alu(srca, srcb, alucontrol, aluresult, zero);
    flopr #(32) alufp(clk, reset, aluresult, aluout);
    
endmodule

