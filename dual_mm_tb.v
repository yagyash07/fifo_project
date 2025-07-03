`timescale 1ps/1ps

module dual_mm_tb(); 
    parameter DEPTH=8;
    reg wr_clk;
    reg rd_clk;
    reg wr_en_i;
    reg rd_en_i;
    reg [7:0] data_i;
    wire [7:0] data_o;

dual_mm_port #(DEPTH) uut(
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .wr_en_i(wr_en_i),
    .rd_en_i(rd_en_i),
    .data_i(data_i),
    .data_o(data_o)

);
integer i;
initial wr_clk=1'b1;
always (#5) wr_clk=~wr_clk;

initial rd_clk=1'b1;
always (#8) rd_clk=~rd_clk;

initial begin
    wr_en_i = 0;
    rd_en_i = 0;
    data_i = 8'd0;
    #10;

    @(posedge wr_clk);
    wr_en_i=1'b1;
    rd_en_i=1'b0;


    for(i=0; i<8; i=i+1) begin
        data_i=i;
        @(posedge wr_clk);
    end
    @(posedge wr_clk);
    wr_en_i = 0;
    rd_en_i = 0;

    #40;

    
    @(posedge rd_clk);
    wr_en_i=1'b0;
    rd_en_i=1'b1;
    for(i=0; i<8; i=i+1) begin
       @(posedge rd_clk);
    end
    @(posedge rd_clk);
    wr_en_i = 0;
    rd_en_i = 0;

    #50;
    $stop;
end

endmodule








