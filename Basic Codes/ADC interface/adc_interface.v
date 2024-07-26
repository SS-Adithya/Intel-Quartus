module adc_interface (
    input wire clk,          
    output reg adc_cs,     
    output reg adc_sclk,     
    input wire adc_dout,      
    input wire [2:0] switches,  
    output reg adc_din
);

reg [3:0] cs_counter;
parameter CS_LOW_CYCLES = 16;

reg [15:0] din_t;
reg dout_t;


always @(posedge clk) begin
    if (cs_counter < CS_LOW_CYCLES) begin
        adc_cs <= 1'b0;
        cs_counter <= cs_counter + 1;
    end else begin
        adc_cs <= 1'b1;
        cs_counter <= 4'b0000;
    end
end


always @(posedge clk) begin
    if (!adc_cs) begin
        adc_sclk <= ~adc_sclk;
        
        if (cs_counter < CS_LOW_CYCLES) begin
            adc_din <= din_t[15 - cs_counter]; 
        end else begin
            adc_din <= 1'b0; 
        end
        
        dout_t <= {dout_t, adc_dout};
    end else begin
        adc_sclk <= 1'b0;
    end
end


always @(*) begin
    din_t = {1'b1, 1'b0, 1'b0, switches, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1};
end

endmodule