module alu(
     input logic[31:0] srca,srcb,
     input logic[2:0] alucontrol,
     output logic[31:0] aluout,
     output logic zero
    );
    always_comb
    case(alucontrol)
    3'b000:aluout=srca&srcb;
    3'b001:aluout=srca|srcb;
    3'b010:aluout=srca+srcb;
    3'b011: aluout=0;
    3'b100:aluout=srca&(~srcb);
    3'b101:aluout=srca|(~srcb);
    3'b110:aluout=srca-srcb;
    3'b111:aluout= srca<srcb;
    endcase
    assign zero=(aluout == 32'b0);
endmodule
