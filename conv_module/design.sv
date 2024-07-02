// Code your design here
module convolution(
  input clk,
  input [7:0] image[0:24],  // 5x5 input image
  input [7:0] kernel[0:8],  // 3x3 kernel
  output [15:0] conv_out[0:8]  // 3x3 convolution output
);

integer i, j, m, n;
reg [15:0] temp;
reg [15:0] conv_reg[0:8];

always @(posedge clk) begin
  for (i = 0; i < 3; i = i + 1) begin
    for (j = 0; j < 3; j = j + 1) begin
      temp = 0;
      for (m = 0; m < 3; m = m + 1) begin
        for (n = 0; n < 3; n = n + 1) begin
          temp = temp + image[(i+m)*5 + (j+n)] * kernel[m*3 + n];
        end
      end
      conv_reg[i*3 + j] = temp;
    end
  end
end

assign conv_out = conv_reg;

endmodule
