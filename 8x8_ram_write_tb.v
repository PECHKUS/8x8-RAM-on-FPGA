module ram_8_8_write_tb;

    reg        clk;
    reg        rst;
    reg        wr_enb;
    reg [2:0]  wr_addr;
    reg [7:0]  data_in;

    // unused read signals
    reg        rd_enb;
    reg [2:0]  rd_addr;
    wire [7:0] data_out;

    
    RAM8_8 dut (
        .clk      (clk),
        .rst      (rst),
        .wr_enb   (wr_enb),
        .rd_enb   (rd_enb),
        .wr_addr  (wr_addr),
        .rd_addr  (rd_addr),
        .data_in  (data_in),
        .data_out (data_out)
    );

    // waveform
    initial begin
        $dumpfile("ram_write.vcd");
        $dumpvars(0, ram_8_8_write_tb);
    end

    // clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // defaults
        rst = 1;
        wr_enb = 0;
        rd_enb = 0;
        wr_addr = 0;
        rd_addr = 0;
        data_in = 0;

        // reset
        #12 rst = 0;

        // write test
        @(posedge clk);
        wr_enb  = 1;
        wr_addr = 3'd2;
        data_in = 8'd25;

        @(posedge clk);
        wr_addr = 3'd6;
        data_in = 8'd99;

        @(posedge clk);
        wr_addr = 3'd1;
        data_in = 8'd42;

        @(posedge clk);
        wr_enb = 0;

        // end
        @(posedge clk);
        $display("WRITE TEST COMPLETED");
        $finish;
    end

endmodule
