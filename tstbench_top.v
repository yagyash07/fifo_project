`timescale 1ns / 1ps

module testbench_top#(parameter depth = 8)(

    );
    reg rclk;
    reg wclk;
    reg reset;
    reg w_en;
    reg r_en;    
    wire [$clog2(depth):0] bin_w_ptr,bin_r_ptr;
    wire [$clog2(depth):0] gray_w_ptr,gray_w_ptr_syn;
    wire [$clog2(depth):0] gray_r_ptr,gray_r_ptr_syn;
    wire full,empty;
    top_module uut(.rclk(rclk),
                   .wclk(wclk),
                   .reset(reset),
                   .bin_w_ptr(bin_w_ptr),
                   .bin_r_ptr(bin_r_ptr),
                   .gray_w_ptr(gray_w_ptr),
                   .gray_r_ptr(gray_r_ptr),
                   .gray_w_ptr_syn(gray_w_ptr_syn),
                   .gray_r_ptr_syn(gray_r_ptr_syn),
                   .w_en(w_en),
                   .r_en(r_en),
                   .full(full),
                   .empty(empty));
   initial begin
   wclk = 1'b0;
   rclk = 1'b0;
   end
   always #5 wclk = ~wclk ;
   always #10 rclk = ~rclk;
   
   initial begin
   //test case 1
   reset = 1'b1; #20
   // test case 2
   reset = 1'b0; 
   w_en = 1'b1 ; r_en = 1'b0; #20
   // test case 3
   reset = 1'b0; 
   w_en = 1'b1; r_en = 1'b0; #20
   // test case 4
   reset = 1'b0;
   w_en = 1'b1 ; r_en = 1'b1; #20
   // test case 5
   reset = 1'b0;
   w_en = 1'b0 ; r_en = 1'b1; #20
   // test case 6 
   w_en = 1'b0 ; r_en = 1'b1; #20
   
   // test case 7 
   reset = 1'b0;
   w_en = 1'b1 ; r_en = 1'b0; #20
   // test case 8 
   reset = 1'b0; 
   w_en = 1'b1; r_en = 1'b0; #20
   // test case 9 
   reset = 1'b0;
   w_en = 1'b1; r_en = 1'b0; #20
   // test case 10 
   reset = 1'b0;
   w_en = 1'b0; r_en = 1'b1; #50
   // final test 
   reset = 1'b1; #30
      $finish ;
   end
endmodule