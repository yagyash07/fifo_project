module ff_2_sync #(parameter Width=4)(
    
    input clk,
    input wire [Width-1:0] D1,
    output reg [Width-1:0] ff2,
    input rst
);
  reg [Width-1:0] ff1;
  always @(posedge clk) begin
  if (rst) begin
     ff1<=0;
     ff2<=0;
  end 
  else begin
       ff1<=D1;
       ff2<=ff1;
  end

endmodule
