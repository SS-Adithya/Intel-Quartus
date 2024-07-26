module switch_led (
    input wire clk,        // Clock input
    input wire reset,      // Reset input
    input wire sw,         // Switch input
    output reg led         // LED output
);

// Define a register to store the state of the switch
reg prev_sw_state;

// Synchronous reset
always @(posedge clk, posedge reset)
begin
    if (reset)
        prev_sw_state <= 1'b0;  // Initialize to LED off
    else
        prev_sw_state <= sw;     // Store the current state of the switch
end

// Combinational logic to control the LED
always @*
begin
    if (sw && !prev_sw_state)   // Detect rising edge of the switch
        led <= ~led;            // Toggle the LED
    prev_sw_state <= sw;        // Update the previous switch state
end

endmodule
