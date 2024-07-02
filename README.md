# Image Sampling and Pooling with Verilog

This project performs image sampling on a 5x5 image using a 3x3 convolution kernel. The image and kernel data are read from text files, processed in Verilog, and the convolved image undergoes two operations: max pooling and average pooling. The results are saved to output files, and the time taken for performing max pooling is measured relative to the simulation time unit.

## Project Structure

- `image.txt`: Contains the 5x5 input image in binary format.
- `kernel.txt`: Contains the 3x3 convolution kernel in binary format.
- input : 3x3 matrix used for pooling.
- output`: 2x2 matrix resulting from pooling.
- `time_log.txt`: Logs the time taken for each max pooling operation.



1. **Python Script**: 
   - Used to convert the image and kernel data into binary format.
   - The resulting binary data is saved in `image.txt` and `kernel.txt`.

2. **Verilog Simulation**:
   - The convolution module reads `image.txt` and `kernel.txt` and performs the convolution operation.
   - The downsamplinng module reads the convolved image and performs max pooling and average pooling.
   - The testbench measures the time taken for max pooling and writes the results to output and time_log file under max pooling .

