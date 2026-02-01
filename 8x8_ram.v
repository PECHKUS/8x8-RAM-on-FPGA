module RAM8_8 (
    input              clk,
    input              rst,       // asynchronous active-high reset
    input              wr_enb,
    input              rd_enb,
    input      [2:0]   wr_addr,   
    input      [2:0]   rd_addr,
    input      [7:0]   data_in,
    output reg [7:0]   data_out
);

    // internal memory: 8 locations × 8 bits
    reg [7:0] mem [0:7];
    integer i;

    // sequential logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // clear memory and output on reset
            for (i = 0; i < 8; i = i + 1)
                mem[i] <= 8'b0;

            data_out <= 8'b0;
        end
        else begin
            // write operation
            if (wr_enb)
                mem[wr_addr] <= data_in;

            // read operation 
            if (rd_enb)
                data_out <= mem[rd_addr];
        end
    end

endmodule
