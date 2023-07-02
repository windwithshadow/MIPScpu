module muxpc#(parameter WIDTH=32)(
input logic [WIDTH-1:0] aluresult, aluout, pcjump, 
input logic [1:0] pcsrc,
output logic[WIDTH-1:0] pcnext
    );
always_comb
case(pcsrc)
2'b00:pcnext<=aluresult;
2'b01:pcnext<=aluout;
2'b10:pcnext<=pcjump;
default:pcnext<=0;
endcase
endmodule
