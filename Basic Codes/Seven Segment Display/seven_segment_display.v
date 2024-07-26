module seven_segment_display (
    input wire [9:0] sw,      // 10-bit input representing the states of 10 switches
    output reg [6:0] seg      // 7-bit output to control segments of the display
);

// Define segment patterns for displaying numbers 0 to 9
// Each bit in the pattern represents a segment of the seven-segment display
// Bit order: DP, G, F, E, D, C, B, A
// For common cathode display, a '0' turns on a segment
// Example: 7'b1000000 represents digit '0'
//          7'b1111001 represents digit '9'
parameter [6:0] SEGMENT_PATTERN [0:9] = {
    7'b1000000,  // 0
    7'b1111001,  // 1
    7'b0100100,  // 2
    7'b0110000,  // 3
    7'b0011001,  // 4
    7'b0010010,  // 5
    7'b0000010,  // 6
    7'b1111000,  // 7
    7'b0000000,  // 8 (blank)
    7'b0011000   // 9
};

// Output the segment pattern based on the input switches state
always @(*) begin
    case(sw)
        10'b0000000000: seg = SEGMENT_PATTERN[0]; // Display digit '0' when all switches are off
        10'b0000000001: seg = SEGMENT_PATTERN[1]; // Display digit '1' when switch 0 is on
        10'b0000000010: seg = SEGMENT_PATTERN[2]; // Display digit '2' when switch 1 is on
        10'b0000000100: seg = SEGMENT_PATTERN[3]; // Display digit '3' when switch 2 is on
        10'b0000001000: seg = SEGMENT_PATTERN[4]; // Display digit '4' when switch 3 is on
        10'b0000010000: seg = SEGMENT_PATTERN[5]; // Display digit '5' when switch 4 is on
        10'b0000100000: seg = SEGMENT_PATTERN[6]; // Display digit '6' when switch 5 is on
        10'b0001000000: seg = SEGMENT_PATTERN[7]; // Display digit '7' when switch 6 is on
        10'b0010000000: seg = SEGMENT_PATTERN[8]; // Display digit '8' when switch 7 is on
        10'b0100000000: seg = SEGMENT_PATTERN[9]; // Display digit '9' when switch 8 is on
        default: seg = 7'b1111111;                // Turn off all segments if switch state is unknown
    endcase
end

endmodule
