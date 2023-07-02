module mux7seg(
    input logic [31:0] x,
    input logic        clk,
    output logic [6:0] a2g,
    output logic [7:0] an,
    output logic       dp );
    
    logic [2:0] s;
    logic [4:0] digit;
    logic [19:0] clkdiv;
    
    assign dp =1;
    assign s = clkdiv[19:17];
    
    always_comb
      case(s)
        0: digit = {{1'b0},x[3:0]};
        1: digit = {{1'b0},x[7:4]};
        2: digit = {{1'b0},x[11:8]};
        3: digit = {{1'b1},x[15:12]};
        4: digit = {{1'b0},x[19:16]};
        5: digit = {{1'b0},x[23:20]};
        6: digit = {{1'b0},x[27:24]};
        7: digit = {{1'b0},x[31:28]};
        default: digit = {{1'b0},x[4:0]};
      endcase
     
     always_comb
       case(s)
         0: an = 8'b1111_1110;
         1: an = 8'b1111_1101;
         2: an = 8'b1111_1011;
         3: an = 8'b1111_0111;
         4: an = 8'b1110_1111;
         5: an = 8'b1101_1111;
         6: an = 8'b1011_1111;
         7: an = 8'b0111_1111;
         default: an = 8'b1111_1111;
       endcase
       
    always @(posedge clk)
    begin
        clkdiv <= clkdiv + 1;
    end
 //实例化 7段数码管
    Hex7Seg s7(.x(digit), .a2g(a2g));    
endmodule
