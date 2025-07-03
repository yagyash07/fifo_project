`timescale 1ns / 1ps


module write_ptr_logic#(parameter depth = 8,  
parameter d_width = 8)(
input wclk, 
input reset, 
output full, 
input w_en,

input [3:0] gray_r_ptr_syn, // as depth is 8 if u change the depth u need to change the bits too by clog(depth)
output [3:0] bin_r_ptr, 
output reg [3:0] bin_w_ptr,  
output [3:0] gray_w_ptr 
    );
   
    bcd_gray btg(.bin_addr(bin_w_ptr),.gray_addr(gray_w_ptr)); 
    gray_bcd gtb(.gray_addr(gray_r_ptr_syn),.bin_addr(bin_r_ptr)); 
    assign full = ({~bin_w_ptr[3],bin_w_ptr[2:0]} == bin_r_ptr[3:0]); 

    always @(posedge wclk) begin
    if(reset) begin
    bin_w_ptr <= 0;
    
    end
    else begin
    if(~full && w_en) 
    bin_w_ptr <= bin_w_ptr + 1;
    end
    
    end
endmodule