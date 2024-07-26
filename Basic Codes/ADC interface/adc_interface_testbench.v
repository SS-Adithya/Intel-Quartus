`timescale 1ns / 1ps

module adc_interface_tb;

    reg clk;
    reg [2:0] switches;
    wire adc_cs;
    wire adc_sclk;
    wire adc_din;
    wire adc_dout;

    // Instantiate the module
    adc_interface uut (
        .clk(clk), 
        .adc_cs(adc_cs), 
        .adc_sclk(adc_sclk), 
        .adc_dout(adc_dout), 
        .switches(switches), 
        .adc_din(adc_din)
    );

    // Clock generator
    always begin
        #5 clk = ~clk;
    end

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        switches = 3'b000;

        // Wait for a few clock cycles
        #20;

        // Toggle switches
        switches = 3'b001;
        #10;

        switches = 3'b010;
        #10;

        switches = 3'b100;
        #10;

        switches = 3'b111;
        #10;

        // Finish the simulation
        $finish;
    end

endmodule