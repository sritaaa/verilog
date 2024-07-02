module downsampling (
    input wire [7:0] conv_out [2:0][2:0],    // Convolution output matrix (3x3)
    output reg [7:0] downsampled_out [1:0][1:0]  // Downsampled output matrix (2x2)
);

    reg [11:0] sum;     // Sum accumulator for averaging
    reg [3:0] average;  // Average value (4-bit is enough for averaging 8-bit values)

    always @* begin
        // Compute average pooling (downsampling)
        sum = conv_out[0][0] + conv_out[0][1] + conv_out[1][0] + conv_out[1][1];
        average = sum >> 2;  // Divide sum by 4 (average of four values)
        downsampled_out[0][0] = average;

        sum = conv_out[0][1] + conv_out[0][2] + conv_out[1][1] + conv_out[1][2];
        average = sum >> 2;
        downsampled_out[0][1] = average;

        sum = conv_out[1][0] + conv_out[1][1] + conv_out[2][0] + conv_out[2][1];
        average = sum >> 2;
        downsampled_out[1][0] = average;

        sum = conv_out[1][1] + conv_out[1][2] + conv_out[2][1] + conv_out[2][2];
        average = sum >> 2;
        downsampled_out[1][1] = average;
    end

endmodule