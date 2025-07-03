module dual_mm_port #(parameter DEPTH=8)(
    input wr_clk,
    input rd_clk,
    input wr_en_i,
    input rd_en_i,
    input [7:0] data_i,
    input[2:0] wr_addr;
    input [2:0] rd_addr;
    output reg [7:0] data_o

    
);
reg [7:0] mem[0:DEPTH-1];


always @(posedge wr_clk) begin
    if (wr_en_i) begin
        mem [wr_addr] <=data_i;
    end
end

always @(posedge rd_clk) begin
    if (rd_en_i) begin
        data_o<=mem[rd_addr];
    end
end


endmodule
    
