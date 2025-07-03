`timescale 1ns / 1ps


module top_module#(parameter depth = 8 )(
    input rclk, 
    input wclk, 
    input reset,     
    input w_en,r_en, 
    output [$clog2(depth):0] bin_w_ptr,bin_r_ptr,//$clog2(depth) = 3
    output [$clog2(depth):0] gray_w_ptr,gray_w_ptr_syn,
    output [$clog2(depth):0] gray_r_ptr,gray_r_ptr_syn,
    output full,empty
    );
    

    write_ptr_logic wl(.wclk(wclk),.reset(reset),.full(full),.gray_w_ptr(gray_w_ptr),.gray_r_ptr_syn(gray_r_ptr_syn),.w_en(w_en),.bin_w_ptr(bin_w_ptr));
    
    read_ptr_logic rl(.rclk(rclk),.reset(reset),.empty(empty),.gray_r_ptr(gray_r_ptr),.gray_w_ptr_syn(gray_w_ptr_syn),.r_en(r_en),.bin_r_ptr(bin_r_ptr));
    
    synchroniser write(.clk(rclk),.d(gray_w_ptr),.q(gray_w_ptr_syn));

    synchroniser read(.clk(wclk),.d(gray_r_ptr),.q(gray_r_ptr_syn));

    
endmodule