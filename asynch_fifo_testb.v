`timescale 1ns / 1ps

module async_fifo_tb;
    parameter depth = 8;
    parameter d_width = 8;

    reg wr_clk = 0;
    reg rd_clk = 0;
    reg reset;
    reg wr_en;
    reg rd_en;
    reg [d_width-1:0] wr_data;
    wire [d_width-1:0] rd_data;
    wire full_o;
    wire empty_o;

    // Instantiate the FIFO with depth = 8, d_width = 8
    async_fifo #(depth, d_width) uut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full_o(full_o),
        .empty_o(empty_o)
    );

    // Clock generation (asynchronous)
    always #5 wr_clk = ~wr_clk;
    always #7 rd_clk = ~rd_clk;

    integer i;

    initial begin
        reset = 1;
        wr_en = 0;
        rd_en = 0;
        wr_data = 0;

        #20;
        reset = 0;

        for (i = 0; i < depth; i = i + 1) begin
            @(posedge wr_clk);
            if (!full_o) begin
                wr_en = 1;
                wr_data = i + 1;
            end
        end
        wr_en = 0;

        #50;

        for (i = 0; i < depth; i = i + 1) begin
            @(posedge rd_clk);
            if (!empty_o) begin
                rd_en = 1;
            end
        end
        rd_en = 0;

        for (i = 0; i < depth + 2; i = i + 1) begin
            @(posedge wr_clk);
            if (!full_o) begin
                wr_en = 1;
                wr_data = 100 + i;
            end else begin
                wr_en = 0;
            end
        end
        wr_en = 0;

        for (i = 0; i < depth + 2; i = i + 1) begin
            @(posedge rd_clk);
            if (!empty_o) begin
                rd_en = 1;
            end else begin
                rd_en = 0;
            end
        end
        rd_en = 0;

        #100;
        $finish;
    end
endmodule
