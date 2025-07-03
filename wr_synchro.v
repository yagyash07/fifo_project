`timescale 1ns / 1ps

module synchroniser#(parameter depth = 8)(
input [3:0] d,  // as depth is 8 if u change the depth u need to change the bits too by clog(depth)
output wire [3:0]q,
input clk
    );
    wire [3:0] w1;
    d_ff uut_1(.clk(clk),.d(d),.q(w1));
    d_ff uut_2(.clk(clk),.d(w1),.q(q));
    
endmodule

module d_ff#(parameter depth = 8)(
input clk,
input [3:0] d,   // as depth is 8 if u change the depth u need to change the bits too by clog(depth)
output reg [3:0] q
    );
    always @(posedge clk) begin
    q <= d;
    end
endmodule