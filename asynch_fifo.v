`timescale 1ns / 1ps

module async_fifo #(parameter depth = 8, parameter d_width = 8)(
    input wr_clk,
    input rd_clk,
    input reset,
    input wr_en,
    input rd_en,
    input [d_width-1:0] wr_data,
    output wire [d_width-1:0] rd_data,
    output wire full_o,
    output wire empty_o
);

    // For depth=8, log2(8) = 3 → 4 bits needed for gray/binary pointers
    wire [3:0] bin_w_ptr, gray_w_ptr, gray_w_ptr_sync;
    wire [3:0] bin_r_ptr, gray_r_ptr, gray_r_ptr_sync;
    wire [3:0] bin_r_ptr_final;

    
    // 1. Dual-port memory
    dual_mm_port #( .DEPTH(depth) ) mem (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wr_en_i(wr_en & ~full_o),
        .rd_en_i(rd_en & ~empty_o),
        .wr_addr(bin_w_ptr[2:0]), // 3-bit address for depth=8 (clog2(depth))
        .rd_addr(bin_r_ptr[2:0]),
        .data_i(wr_data),
        .data_o(rd_data)
    );

    // 2. Write pointer logic
    write_ptr_logic #( .depth(depth), .d_width(d_width) ) uut2 (
        .wclk(wr_clk),
        .reset(reset),
        .full(full_o),
        .w_en(wr_en),
        .gray_r_ptr_syn(gray_r_ptr_sync),
        .bin_r_ptr(bin_r_ptr_final),
        .bin_w_ptr(bin_w_ptr),
        .gray_w_ptr(gray_w_ptr)
    );

    // 3. Read pointer logic
    
    read_ptr_logic #( .depth(depth) ) uut3 (
        .rclk(rd_clk),
        .reset(reset),
        .empty(empty_o),
        .r_en(rd_en),
        .gray_w_ptr_syn(gray_w_ptr_sync),
        .bin_w_ptr(bin_r_ptr_final),
        .bin_r_ptr(bin_r_ptr),
        .gray_r_ptr(gray_r_ptr)
    );

    // 4. Pointer Synchronizers (2 Flip-Flop sync)

    ff_2_sync  uut4 (
        .clk(rd_clk),
        .D1(gray_w_ptr),
        .ff2(gray_w_ptr_sync),
        .rst(reset)
    );

    ff_2_sync uut5 (
        .clk(wr_clk),
        .D1(gray_r_ptr),
        .ff2(gray_r_ptr_sync),
        .rst(reset)
    );

endmodule
