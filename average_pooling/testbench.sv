module testbench;

    // Parameters and signals
    parameter WIDTH = 8;  // Width of matrix elements
    
    // Inputs
    reg [WIDTH-1:0] conv_out [2:0][2:0];  // Convolution output matrix
    
    // Outputs
    wire [WIDTH-1:0] downsampled_out [1:0][1:0]; // Downsampled output matrix
    
    // Instantiate downsampling module
    downsampling uut (
        .conv_out(conv_out),
        .downsampled_out(downsampled_out)
    );

    // File I/O
    integer outfile;
    reg [WIDTH-1:0] data_out [1:0][1:0];  // Buffer to hold output data for writing to file
    reg [WIDTH-1:0] expected_output [1:0][1:0] = '{ '{ 0, 3 }, '{ 2, 3 } };

    // Initialize input data
    initial begin
        // Initialize conv_out with example data (you should read from output.txt in real application)
        conv_out[0][0] = 0; conv_out[0][1] = 1; conv_out[0][2] = 2;
        conv_out[1][0] = 3; conv_out[1][1] = 0; conv_out[1][2] = 1;
        conv_out[2][0] = 2; conv_out[2][1] = 3; conv_out[2][2] = 0;
        
        // Open output file for writing
        outfile = $fopen("downsample.txt", "w");
        if (outfile == 0) begin
            $display("Error: Could not open output file.");
            $finish;
        end
        
        // Apply some clock cycles (if needed)
        #10;
        
        // Display the input convolution output (for verification)
        $display("Convolution Output:");
        for (int i = 0; i < 3; i = i + 1) begin
            $write("\t");
            for (int j = 0; j < 3; j = j + 1) begin
                $write("%d ", conv_out[i][j]);
            end
            $write("\n");
        end
        
        // Apply more clock cycles (if needed)
        #10;
        
        // Trigger the downsampling module
        #10;
        
        // Display the downsampled output matrix (for verification)
        $display("\nDownsampled Output Matrix:");
        for (int i = 0; i < 2; i = i + 1) begin
            $write("\t");
            for (int j = 0; j < 2; j = j + 1) begin
                data_out[i][j] = downsampled_out[i][j];  // Store for writing to file
                // Display downsampled output matrix element (optional)
                $write("%d ", downsampled_out[i][j]);
            end
            $write("\n");
        end
        
        // Write the downsampled output matrix to output file
        for (int i = 0; i < 2; i = i + 1) begin
            for (int j = 0; j < 2; j = j + 1) begin
                $fwrite(outfile, "%d ", data_out[i][j]);
            end
            $fwrite(outfile, "\n");
        end
        
        // Close output file
        $fclose(outfile);
        
        // Compare with expected output (for verification)
        $display("\nExpected Downsampled Output:");
        for (int i = 0; i < 2; i = i + 1) begin
            $write("\t");
            for (int j = 0; j < 2; j = j + 1) begin
                $write("%d ", expected_output[i][j]);
            end
            $write("\n");
        end
        
        // End simulation
        $finish;
    end
    
endmodule