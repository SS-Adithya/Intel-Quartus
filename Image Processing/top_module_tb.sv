module top_module_tb;

reg clk, rst, bit_serial_in, enable_in, bit_serial_kn, enable_kn;
wire [7:0] Output;

// Instantiate the module
top_module uut (
    .clk(clk),
    .rst(rst),
    .bit_serial_in(bit_serial_in),
    .enable_in(enable_in),
    .bit_serial_kn(bit_serial_kn),
    .enable_kn(enable_kn),
    .Output(Output)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test stimulus
initial begin

    rst = 1;
    #10 rst = 0;

    // Input serial data for InMat (25 values)
    enable_in = 1;
    for (int i = 0; i < 5; i = i + 1) begin
        for (int j = 0; j < 5; j = j + 1) begin
            bit_serial_in = $random;
            #5;
        end
    end
    enable_in = 0;

    // Input serial data for Kernel (9 values)
    enable_kn = 1;
    for (int i = 0; i < 3; i = i + 1) begin
        for (int j = 0; j < 3; j = j + 1) begin
            bit_serial_kn = $random;
            #5;
        end
    end
    enable_kn = 0;

    // Allow some time for computation
    #100;

    // Display the output
    $display("Output value: %h", Output);

   

    $stop;
end

endmodule
