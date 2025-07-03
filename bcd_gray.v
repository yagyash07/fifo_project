`timescale 1ns / 1ps

module bcd_gray#(parameter depth = 8)( 
input [3:0] bin_addr, 
output reg [3:0] gray_addr// as depth is 8 if u change the depth u need to change the bits too by clog(depth)
    );
    integer i;
    always @(*) begin
    gray_addr[3] = bin_addr[3];
    for(i = (2) ; i >= 0 ; i = i -1 )begin
    gray_addr[i] = bin_addr[i+1] ^ bin_addr[i];
    end
    
    end
endmodule