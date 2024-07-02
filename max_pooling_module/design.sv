// Code your design here
// Code your design here
module downsample(
  input  wire [7:0] pixel_00, 
  input  wire [7:0] pixel_01, 
  input  wire [7:0] pixel_10, 
  input  wire [7:0] pixel_11, 
  output wire [7:0] max_pixel  
);
  
  wire [7:0] max_00_01;
  wire [7:0] max_10_11;
  
  assign max_00_01 = (pixel_00 > pixel_01) ? pixel_00 : pixel_01;
  assign max_10_11 = (pixel_10 > pixel_11) ? pixel_10 : pixel_11;
  assign max_pixel = (max_00_01 > max_10_11) ? max_00_01 : max_10_11;

endmodule
