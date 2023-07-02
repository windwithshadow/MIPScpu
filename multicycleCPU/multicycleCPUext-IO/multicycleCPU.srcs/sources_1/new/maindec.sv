module maindec(
    input  logic       clk,
    input  logic       reset,
    input  logic [5:0] op,
    output logic       pcwrite, memwrite, irwrite, regwrite,
    output logic       alusrca, branch, iord, memtoreg, regdst,
    output logic       immext, branchbne,
    output logic [1:0] alusrcb, pcsrc, 
    output logic [2:0] aluop);
    
    localparam  FETCH   = 4'b0000; //State 0
    localparam  DECODE  = 4'b0001; //State 1
    localparam  MEMADR  = 4'b0010; //State 2
    localparam  MEMRD   = 4'b0011; //State 3
    localparam  MEMWB   = 4'b0100; //State 4
    localparam  MEMWR   = 4'b0101; //State 5
    localparam  RTYPEEX = 4'b0110; //State 6
    localparam  RTYPEWB = 4'b0111; //State 7
    localparam  BEQEX   = 4'b1000; //State 8
    localparam  ADDIEX  = 4'b1001; //State 9
    localparam  ITYPEWB = 4'b1010; //State 10
    localparam  JEX     = 4'b1011; //State 11
    
    localparam  BNEEX   = 4'b1100; //state 12
    localparam  ORIEX   = 4'b1101; //state 13
    localparam  ANDIEX  = 4'b1110; //state 14
    
    localparam  LW      = 6'b100011; //Opcode for lw
    localparam  SW      = 6'b101011; //Opcode for sw
    localparam  RTYPE   = 6'b000000; //Opcode for R-type
    localparam  BEQ     = 6'b000100; //Opcode for beg
    localparam  ADDI    = 6'b001000; //Opcode for addi
    localparam  J       = 6'b000010; //Opcode for j
    
    localparam  BNE     = 6'b000101; //Opcode for bne
    localparam  ORI     = 6'b001101; //Opcode for ori
    localparam  ANDI    = 6'b001100; //Opcode for andi

 
    logic [3:0]  state, nextstate;
    logic [17:0] controls;
    
    //state register
    always_ff @(posedge clk or posedge reset)
        if(reset) state <= FETCH;
        else      state <= nextstate;
        
    //next state logic
    always_comb
        case(state)
            FETCH:  nextstate = DECODE;
            DECODE: case(op)
                   LW:      nextstate = MEMADR;
                   SW:      nextstate = MEMADR;
                   RTYPE:   nextstate = RTYPEEX;
                   BEQ:     nextstate = BEQEX;
                   ADDI:    nextstate = ADDIEX;
                   J:       nextstate = JEX;
                   
                   BNE:     nextstate = BNEEX;
                   ORI:     nextstate = ORIEX;
                   ANDI:    nextstate = ANDIEX;
                   
                   default: nextstate = 4'bx;
                 endcase
            MEMADR: case(op)
                   LW:      nextstate = MEMRD;
                   SW:      nextstate = MEMWR;
                   default: nextstate = 4'bx;
                 endcase
            MEMRD:          nextstate = MEMWB;
            MEMWB:          nextstate = FETCH;
            MEMWR:          nextstate = FETCH;
            RTYPEEX:        nextstate = RTYPEWB;
            RTYPEWB:        nextstate = FETCH;
            BEQEX:          nextstate = FETCH;
            ADDIEX:         nextstate = ITYPEWB;
            ITYPEWB:        nextstate = FETCH;
            JEX:            nextstate = FETCH;
            
            BNEEX:          nextstate = FETCH;
            ORIEX:          nextstate = ITYPEWB;
            ANDIEX:         nextstate = ITYPEWB;
         
            default:        nextstate = 4'bx;
        endcase
        
        //output logic
        assign {pcwrite, memwrite, irwrite, regwrite,
                alusrca, branch, iord, memtoreg, regdst,
                alusrcb, pcsrc, aluop, immext, branchbne} = controls;
           
        always_comb
            case(state)
                FETCH:   controls = 18'h28080; //18'b10 1000 0000 1000 0000
                DECODE:  controls = 18'h00180; //18'b00 0000 0001 1000 0000
                MEMADR:  controls = 18'h02100; //18'b00 0010 0001 0000 0000
                MEMRD:   controls = 18'h00800; //18'b00 0000 1000 0000 0000
                MEMWB:   controls = 18'h04400; //18'b00 0100 0100 0000 0000
                MEMWR:   controls = 18'h10800; //18'b01 0000 1000 0000 0000
                RTYPEEX: controls = 18'h02008; //18'b00 0010 0000 0000 1000
                RTYPEWB: controls = 18'h04200; //18'b00 0100 0010 0000 0000
                BEQEX:   controls = 18'h03024; //18'b00 0011 0000 0010 0100
                ADDIEX:  controls = 18'h02100; //18'b00 0010 0001 0000 0000
                ITYPEWB: controls = 18'h04000; //18'b00 0100 0000 0000 0000
                JEX:     controls = 18'h20040; //18'b10 0000 0000 0100 0000
                
                BNEEX:   controls = 18'h02025; //18'b00 0010 0000 0010 0101
                ORIEX:   controls = 18'h0210e; //18'b00 0010 0001 0000 1110
                ANDIEX:  controls = 18'h02112; //18'b00 0010 0001 0001 0010
                
                default: controls = 18'hxxxxx;
            endcase
         
endmodule

