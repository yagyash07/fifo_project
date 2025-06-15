`timescale 1ns / 1ps

module ff_2_sync_tb;

    parameter Width = 1;
    reg clk;
    reg rst;
    reg [Width-1:0] D1;
    wire [Width-1:0] ff2;

    ff_2_sync #(Width) uut (
        .clk(clk),
        .rst(rst),
        .D1(D1),
        .ff2(ff2)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
        end

    initial begin
        $monitor("Time = %0t | rst = %b | D1 = %b | ff2 (output) = %b", $time, D1,rst, ff2);

        rst=0;
        D1=0;

        #10;
        rst=0;

        #10;
        D1 = 1;

        #10;

        D1 = 0;

        #10;

        D1 = 1;

        #10;

        D1 = 0;

        #20;

        $finish; 
    end

endmodule
