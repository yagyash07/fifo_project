`timescale 1ns / 1ps

module async_fifo_tb();
    parameter depth = 8;
    parameter d_width = 8;

    reg wr_clk;
    reg rd_clk;
    reg reset;
    reg wr_en;
    reg rd_en;
    wire [3:0]bin_w_ptr_o,bin_r_ptr_o;
    wire full_o;
    wire empty_o;
    reg [d_width-1:0] wr_data;
    wire [d_width-1:0] rd_data;

    // DUT instantiation
    async_fifo #(depth, d_width) dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full_o(full_o),
        .empty_o(empty_o),
        .bin_r_ptr_o(bin_r_ptr_o),
        .bin_w_ptr_o(bin_w_ptr_o)
    );
  
    // Clocks
    always #5 wr_clk = ~wr_clk;
    always #10 rd_clk = ~rd_clk;
    initial begin
    wr_clk = 0;
    rd_clk = 0;
    reset = 1;
    wr_en = 0;
    rd_en = 0;
    wr_data = 0;
    #25;

 reset=1'b0; wr_en=1;rd_en=0;wr_data=8'd45;#25
 reset=1'b0;  wr_en=1;rd_en=0;wr_data=8'd23;#25
 reset=1'b0;  wr_en=1;rd_en=0;wr_data=8'd27;#25
 reset=1'b0;  wr_en=1;rd_en=0;wr_data=8'd22;#25
 reset=1'b0;  wr_en=1;rd_en=0;wr_data=8'd12;#25    
 reset=1'b0;  wr_en=0;rd_en=1;wr_data=8'd27;#25   
 reset=1'b0;  wr_en=0;rd_en=1;wr_data=8'd22;#25 
 reset=1'b0;  wr_en=0;rd_en=1;wr_data=8'd14;#25 
 reset=1'b1;#25
 $finish;
 
 end
 endmodule  

