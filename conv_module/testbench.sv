// Code your testbench here

module testbench;
  reg clk;
  reg [7:0] image[0:24];
  reg [7:0] kernel[0:8];
  wire [15:0] conv_out[0:8];
  
  convolution uut (
    .clk(clk),
    .image(image),
    .kernel(kernel),
    .conv_out(conv_out)
  );

  integer outfile;  
  integer i, j;     

  initial begin
    clk = 0;

    // Read the image and kernel values from text files
    $readmemb("image.txt", image);
    $readmemb("kernel.txt", kernel);

    // Simulate for a few clock cycles
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;

    // Open the output file for writing
    outfile = $fopen("output.txt", "w");
    if (outfile == 0) begin
      $display("Error: Could not open output file.");
      $finish;
    end

    // Write the results to the output file
    $fwrite(outfile, "Convolution Output:\n");
    for (i = 0; i < 3; i = i + 1) begin
      for (j = 0; j < 3; j = j + 1) begin
        $fwrite(outfile, "conv_out[%0d] = %d\n", i*3 + j, conv_out[i*3 + j]);
      end
    end

    // Close the output file
    $fclose(outfile);

    // End the simulation
    $finish;
  end
endmodule
