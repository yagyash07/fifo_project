`timescale 1ns / 1ps


module async_fifo#(parameter depth = 8 , parameter d_width = 8)(
input [d_width-1:0] wr_data,
input w_en,r_en,
input wclk,rclk,
output wire [3:0] bin_w_ptr,bin_r_ptr,//clog2(depth)=3
output full,empty,
output wire [d_width-1:0] rd_data,
input reset
    );
    top_module uut(.wclk(wclk),
                   .rclk(rclk),
                   .reset(reset),
                   .w_en(w_en),
                   .r_en(r_en),
                   .bin_w_ptr(bin_w_ptr),
                   .bin_r_ptr(bin_r_ptr),
                   .full(full),
                   .empty(empty));
    pseudo_dual uut1( .wclk(wclk),
                      .rclk(rclk),              
                      .w_en(w_en),
                      .r_en(r_en),
                      .bin_w_ptr(bin_w_ptr),
                      .bin_r_ptr(bin_r_ptr),
                      .full(full),
                      .empty(empty),
                      .data_in(wr_data),
                      .data_out(rd_data));
endmodule
