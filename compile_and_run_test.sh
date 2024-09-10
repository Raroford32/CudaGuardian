#!/bin/bash

# Compile the CUDA test program
nvcc -o test_cuda test_cuda.cu

# Run the test program
./test_cuda

# Check for any CUDA errors
if [ $? -eq 0 ]; then
    echo "CUDA test completed successfully."
else
    echo "CUDA test failed. Please check your installation and configuration."
fi
