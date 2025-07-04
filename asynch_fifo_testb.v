`timescale 1ns / 1ps

module async_fifo_tb();
    parameter depth = 8;
    parameter d_width = 8;

    reg wclk;
    reg rclk;
    reg reset;
    reg w_en;
    reg r_en;
    wire full;
    wire empty;
    reg [d_width-1:0] wr_data;
    wire [d_width-1:0] rd_data;

    // DUT instantiation
    async_fifo #(depth, d_width) dut (
        .wclk(wclk),
        .rclk(rclk),
        .reset(reset),
        .w_en(w_en),
        .r_en(r_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
        
    );
        
    // Clocks
    always #5 wclk = ~wclk;
    always #10 rclk = ~rclk;
    initial begin
    wclk = 0;
    rclk = 0;
    reset = 1;
    w_en = 0;
    r_en = 0;
    wr_data = 0;
    #25;

 reset=1'b0; w_en=1;r_en=0;wr_data=8'd45;#25
 reset=1'b0;  w_en=1;r_en=0;wr_data=8'd23;#25
 reset=1'b0;  w_en=1;r_en=0;wr_data=8'd27;#25
 reset=1'b0;  w_en=1;r_en=0;wr_data=8'd22;#25
 reset=1'b0;  w_en=1;r_en=0;wr_data=8'd12;#25   
 reset=1'b0;  w_en=0;r_en=1;wr_data=8'd27;#25   
 reset=1'b0;  w_en=0;r_en=1;wr_data=8'd22;#25 
 reset=1'b0;  w_en=0;r_en=1;wr_data=8'd14;#25 
 reset=1'b1;#25
 $finish;
 
 end
 endmodule  
