// Code your testbench here
// or browse Examples
module downsample_tb;
  reg [1:0] matrix_in [0:8]; // 3x3 input matrix with 2-bit values
  reg [1:0] pooled_matrix [0:3]; 
  reg [1:0] pixel_00, pixel_01, pixel_10, pixel_11;
  wire [1:0] max_pixel;
  reg [7:0] extended_matrix_in [0:8]; // Extended 8-bit version of the input matrix for file I/O
  reg [7:0] extended_pooled_matrix [0:3]; // Extended 8-bit version of the output matrix for file I/O
  integer i;
  integer start_time, end_time, time_taken; // Variables for logging time
  integer log_file; // File handle for the log file

  downsample uut (
    .pixel_00({6'b0, pixel_00}), // Extend 2-bit to 8-bit
    .pixel_01({6'b0, pixel_01}),
    .pixel_10({6'b0, pixel_10}),
    .pixel_11({6'b0, pixel_11}),
    .max_pixel(max_pixel)
  );

  initial begin
    // Open the log file for writing
    log_file = $fopen("time_log.txt", "w");

    // Read the 2-bit 3x3 input matrix from file and extend to 8-bit for processing
    $readmemb("input_matrix.txt", extended_matrix_in);
    for (i = 0; i < 9; i = i + 1) begin
      matrix_in[i] = extended_matrix_in[i][1:0];
    end

    // Perform 2x2 max pooling on the 3x3 matrix to produce a 2x2 output

    // First 2x2 block
    start_time = $time;
    pixel_00 = matrix_in[0];
    pixel_01 = matrix_in[1];
    pixel_10 = matrix_in[3];
    pixel_11 = matrix_in[4];
    #1; // Wait for one simulation time unit to allow max pooling to occur
    end_time = $time;
    time_taken = end_time - start_time;
    pooled_matrix[0] = max_pixel[1:0];
    $fdisplay(log_file, "Time taken for first 2x2 block: %0d time units", time_taken);

    // Second 2x2 block
    start_time = $time;
    pixel_00 = matrix_in[1];
    pixel_01 = matrix_in[2];
    pixel_10 = matrix_in[4];
    pixel_11 = matrix_in[5];
    #1; // Wait for one simulation time unit to allow max pooling to occur
    end_time = $time;
    time_taken = end_time - start_time;
    pooled_matrix[1] = max_pixel[1:0];
    $fdisplay(log_file, "Time taken for second 2x2 block: %0d time units", time_taken);

    // Third 2x2 block
    start_time = $time;
    pixel_00 = matrix_in[3];
    pixel_01 = matrix_in[4];
    pixel_10 = matrix_in[6];
    pixel_11 = matrix_in[7];
    #1; // Wait for one simulation time unit to allow max pooling to occur
    end_time = $time;
    time_taken = end_time - start_time;
    pooled_matrix[2] = max_pixel[1:0];
    $fdisplay(log_file, "Time taken for third 2x2 block: %0d time units", time_taken);

    // Fourth 2x2 block
    start_time = $time;
    pixel_00 = matrix_in[4];
    pixel_01 = matrix_in[5];
    pixel_10 = matrix_in[7];
    pixel_11 = matrix_in[8];
    #1; // Wait for one simulation time unit to allow max pooling to occur
    end_time = $time;
    time_taken = end_time - start_time;
    pooled_matrix[3] = max_pixel[1:0];
    $fdisplay(log_file, "Time taken for fourth 2x2 block: %0d time units", time_taken);

    // Close the log file
    $fclose(log_file);

    // Extend the 2-bit output to 8-bit for writing to file
    for (i = 0; i < 4; i = i + 1) begin
      extended_pooled_matrix[i] = {6'b0, pooled_matrix[i]};
    end
    $writememb("output_matrix.txt", extended_pooled_matrix);

    $finish;
  end
endmodule
