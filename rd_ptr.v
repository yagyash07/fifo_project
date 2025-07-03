`timescale 1ns / 1ps


module read_ptr_logic#(parameter depth  = 8)(  
input rclk, 
input reset, 
output empty,
input r_en, 
input [3:0] gray_w_ptr_syn,// as depth is 8 if u change the depth u need to change the bits too by clog(depth)
output [3:0] bin_w_ptr, 
 output reg [3:0] bin_r_ptr, 
 output [3:0] gray_r_ptr 
    );
   
    bcd_gray btg(.bin_addr(bin_r_ptr),.gray_addr(gray_r_ptr)); 
    gray_bcd gtb(.gray_addr(gray_w_ptr_syn),.bin_addr(bin_w_ptr)); 
     assign empty = (bin_r_ptr == bin_w_ptr);
    always @(posedge rclk) begin
    if(reset) begin
    bin_r_ptr <= 0; 
    end
    else begin
    if(~empty && r_en) begin 
    bin_r_ptr <= bin_r_ptr + 1;
    end
    end
    end
   
endmodule