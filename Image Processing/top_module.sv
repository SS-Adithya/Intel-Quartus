module top_module(
    input wire clk,
    input wire rst,
    output reg [7:0] Output,
    input wire bit_serial_in, 
    input wire enable_in, 
    input wire bit_serial_kn, 
    input wire enable_kn,
);

reg [7:0] InMat[0:4][0:4];
reg [7:0] Kernel[0:2][0:2];
reg [7:0] OutMat[0:6][0:6];
reg [7:0] MatA[0:8][0:8];

reg [7:0] x_in, x_kn; 
reg [2:0] bit_counter_in, bit_counter_kn; 
reg [3:0] i_in, j_in, i_kn, j_kn; 

always @(posedge clk or posedge rst or enable_in or enable_kn) begin
    if (rst) begin
       
        x_in <= 8'h0;
        bit_counter_in <= 3'b0;
        i_in <= 4'd0;
        j_in <= 4'd0;

        x_kn <= 8'h0;
        bit_counter_kn <= 3'b0;
        i_kn <= 4'd0;
        j_kn <= 4'd0;

        for (integer i = 0; i < 5; i = i + 1) begin
            for (integer j = 0; j < 5; j = j + 1) begin
                InMat[i][j] = 8'h0;
            end
        end

        for (integer i = 0; i < 3; i = i + 1) begin
            for (integer j = 0; j < 3; j = j + 1) begin
                Kernel[i][j] = 8'h0;
            end
        end
		  
		  Output <= 8'h0;
		  
    end else begin
      
        if (enable_in) begin
            x_in <= {x_in[6:0], bit_serial_in};
            if (bit_counter_in == 3'b111) begin
                InMat[i_in][j_in] <= x_in;
                bit_counter_in <= 3'b0;

                if (j_in == 4'd3) begin
                    if (i_in == 4'd3) begin
                        i_in <= 4'd0;
                        j_in <= 4'd0;
                    end else begin
                        i_in <= i_in + 1;
                        j_in <= 4'd0;
                    end
                end else begin
                    j_in <= j_in + 1;
                end
            end else begin
                bit_counter_in <= bit_counter_in + 1;
            end
        end

       
        if (enable_kn) begin
            x_kn <= {x_kn[6:0], bit_serial_kn};
            if (bit_counter_kn == 3'b111) begin
                Kernel[i_kn][j_kn] <= x_kn;
                bit_counter_kn <= 3'b0;

                if (j_kn == 4'd2) begin
                    if (i_kn == 4'd2) begin
                        i_kn <= 4'd0;
                        j_kn <= 4'd0;
                    end else begin
                        i_kn <= i_kn + 1;
                        j_kn <= 4'd0;
                    end
                end else begin
                    j_kn <= j_kn + 1;
                end
            end else begin
                bit_counter_kn <= bit_counter_kn + 1;
            end
        end

       
        for (integer i = 0; i < 9; i = i + 1) begin
            for (integer j = 0; j < 9; j = j + 1) begin
                MatA[i][j] = 8'h0; 
            end
        end

        for (integer i = 0; i < 7; i = i + 1) begin
            for (integer j = 0; j < 7; j = j + 1) begin
                OutMat[i][j] = 8'h0;
            end
        end

        for (integer i = 0; i < 5; i = i + 1) begin
            for (integer j = 0; j < 5; j = j + 1) begin
                MatA[2 + i][2 + j] = InMat[i][j];
            end
        end

        for (integer w = 0; w < 7; w = w + 1) begin
            for (integer x = 0; x < 7; x = x + 1) begin
                for (integer y = 0; y < 3; y = y + 1) begin
                    for (integer z = 0; z < 3; z = z + 1) begin
                        OutMat[w][x] = OutMat[w][x] + MatA[y + w][z + x] * Kernel[y][z];
								Output = OutMat[w][x];
                    end
                end
            end
        end
    end
end



endmodule

