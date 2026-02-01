module ram_8_8_tb;

    // testbench signals
    reg        clk;
    reg        rst;
    reg        wr_enb;
    reg        rd_enb;
    reg [2:0]  wr_addr;
    reg [2:0]  rd_addr;
    reg [7:0]  data_in;
    wire [7:0] data_out;

    // DUT instantiation 
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

    initial begin
        $dumpfile("ram_8_8.vcd");
        $dumpvars(0, ram_8_8_tb);
    end

    // clock generation (10 time unit period)
    initial clk = 0;
    always #5 clk = ~clk;

    // test sequence
    initial begin
        // default values
        rst     = 1;
        wr_enb = 0;
        rd_enb = 0;
        wr_addr = 0;
        rd_addr = 0;
        data_in = 0;

        // hold reset for 2 cycles
        #12;
        rst = 0;

      
        @(posedge clk);
        wr_enb  = 1;
        wr_addr = 3'b100;
        data_in = 8'd5;

     
        @(posedge clk);
        wr_addr = 3'b101;
        data_in = 8'd10;

        // disable write
        @(posedge clk);
        wr_enb = 0;

    
        @(posedge clk);
        rd_enb  = 1;
        rd_addr = 3'b100;

        @(posedge clk); // registered read
        $display("READ addr 4 = %0d (expected 5)", data_out);

    
        @(posedge clk);
        rd_addr = 3'b101;

        @(posedge clk);
        $display("READ addr 5 = %0d (expected 10)", data_out);

        // end simulation
        #10;
        $finish;
    end

endmodule
