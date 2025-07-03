`timescale 1ns / 1ps


module gray_bcd#(parameter depth = 8)(
input [3:0] gray_addr, // as depth is 8 if u change the depth u need to change the bits too by clog(depth)
output reg [3:0] bin_addr 
    );
    integer i;
    always @(*) begin
    bin_addr[3] = gray_addr[3];
    for( i = (2) ; i >= 0 ; i = i -1 ) begin
    bin_addr[i] = bin_addr[i+1] ^ gray_addr[i];
    end
    end
    
endmodule