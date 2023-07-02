module muxb#(parameter WIDTH=32)(
input logic[WIDTH-1:0]b,signimm, signimmsh, 
input logic[1:0]alusrcb, 
output logic[WIDTH-1:0]srcb
    );
always_comb
case(alusrcb)
2'b00:srcb<=b;
2'b01:srcb<=4;
2'b10:srcb<=signimm;
2'b11:srcb<=signimmsh;
default:srcb<=0;
endcase
endmodule
