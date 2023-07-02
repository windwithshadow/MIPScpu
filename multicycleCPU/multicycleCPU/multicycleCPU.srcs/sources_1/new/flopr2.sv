module flopr2#(parameter WIDTH = 8)(
input logic clk, reset, 
input logic [WIDTH-1:0] rd1, rd2, 
output logic [WIDTH-1:0] a, b
    );
always_ff @(posedge clk, posedge reset)
      if (reset) begin a <= 0;b<=0;end
      else       begin a <= rd1;b<=rd2;end   
endmodule
