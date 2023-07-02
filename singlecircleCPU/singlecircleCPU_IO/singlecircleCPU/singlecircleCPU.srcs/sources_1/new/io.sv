module io(
    //��CPU����
    input  logic        clk,
    input  logic        reset,
    input  logic        pRead,
    input  logic        pWrite,
    input  logic [1:0]  addr,
    input  logic [11:0] pWriteData,
    output logic [31:0] pReadData,
    //����������
    input  logic        buttonL,
    input  logic        buttonR,
    input  logic [15:0] switch, //control
    output logic [11:0] led); //digital
    
    logic [1:0]  status;
    logic [15:0] switchl;
    logic [11:0] ledl;
    always_ff @(posedge clk) begin
        if(reset) begin
           status <=  2'b00;
           ledl   <=  12'h00;
           switchl <= 16'h00;
        end
        else begin
           //����λ�ò��ţ���������
           if(buttonR) begin
               status[1] <= 1;
               switchl   <= switch;
           end
           //led��ʾ׼���ã��������
           if(buttonL) begin
               status[0] <= 1;
               led       <= ledl;
           end
           //����������˿������led��
           if(pWrite & (addr==2'b01)) begin
               ledl      <= pWriteData;
               status[0] <= 0;
           end
        end
     end
     
     always_comb
         if(pRead)
            case(addr)
                2'b11:   pReadData = {24'b0, switchl[15:8]};
                2'b10:   pReadData = {24'b0, switchl[7:0]};
                2'b00:   pReadData = {24'b0, 6'b0, status};
                default: pReadData = 32'b0;
            endcase
         else
            pReadData = 32'b0;
                   
endmodule
