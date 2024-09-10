#!/bin/bash

# Install CUDA Samples if not already installed
if [ ! -d "/usr/local/cuda/samples" ]; then
    sudo apt-get update
    sudo apt-get install -y cuda-samples-11-7
fi

# Compile and run deviceQuery
cd /usr/local/cuda/samples/1_Utilities/deviceQuery
sudo make
./deviceQuery

# Compile and run bandwidthTest
cd /usr/local/cuda/samples/1_Utilities/bandwidthTest
sudo make
./bandwidthTest

# Run nbody simulation benchmark
cd /usr/local/cuda/samples/5_Simulations/nbody
sudo make
./nbody -benchmark -numbodies=256000 -device=0

echo "Benchmarks complete. Please review the results above."
