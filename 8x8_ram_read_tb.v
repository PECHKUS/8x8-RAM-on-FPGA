module ram_8_8_read_tb;

    reg        clk;
    reg        rst;
    reg        wr_enb;
    reg        rd_enb;
    reg [2:0]  wr_addr;
    reg [2:0]  rd_addr;
    reg [7:0]  data_in;
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
        $dumpfile("ram_read.vcd");
        $dumpvars(0, ram_8_8_read_tb);
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

        // setup phase
        @(posedge clk);
        wr_enb  = 1; wr_addr = 3'd3; data_in = 8'd11;

        @(posedge clk);
        wr_addr = 3'd4; data_in = 8'd22;

        @(posedge clk);
        wr_addr = 3'd7; data_in = 8'd77;

        @(posedge clk);
        wr_enb = 0;

        // read tests
        @(posedge clk);
        rd_enb  = 1;
        rd_addr = 3'd3;

        @(posedge clk);
        if (data_out !== 8'd11)
            $error("READ ERROR addr 3: got %0d", data_out);
        else
            $display("READ PASS addr 3");

        @(posedge clk);
        rd_addr = 3'd4;

        @(posedge clk);
        if (data_out !== 8'd22)
            $error("READ ERROR addr 4: got %0d", data_out);
        else
            $display("READ PASS addr 4");

        @(posedge clk);
        rd_addr = 3'd7;

        @(posedge clk);
        if (data_out !== 8'd77)
            $error("READ ERROR addr 7: got %0d", data_out);
        else
            $display("READ PASS addr 7");

        // end
        @(posedge clk);
        $finish;
    end

endmodule
