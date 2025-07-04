
`timescale 1ns / 1ps


module pseudo_dual#(parameter d_width = 8,parameter depth = 8)(  // data width - 8 bits and depth is 8 lines/blocks
input [$clog2(depth):0] bin_w_ptr, 
input [$clog2(depth):0] bin_r_ptr, 
input full,empty, 
input wclk,rclk, 
input w_en,r_en, 
input [d_width-1:0] data_in, 
output reg [d_width-1:0] data_out 
    );
    reg [d_width-1:0] mem [0:depth-1]; 
    
    always @(posedge wclk) begin
    if(w_en && ~full) 
    mem[bin_w_ptr] <= data_in;
    end
   
    always @(posedge rclk) begin
    if(r_en && ~empty)
    data_out <= mem[bin_r_ptr];
    end
    
endmodule