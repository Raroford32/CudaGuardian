#!/bin/bash

# Enable persistence mode for all GPUs
sudo nvidia-smi -pm 1

# Set GPU clock speeds to maximum (adjust as needed)
sudo nvidia-smi -ac 1215,1410

# Disable ECC memory for improved performance (optional)
sudo nvidia-smi --ecc-config=0

# Enable CUDA Multi-Process Service (MPS) for improved multi-process performance
sudo nvidia-smi -c EXCLUSIVE_PROCESS
sudo nvidia-cuda-mps-control -d

# Set GPU compute mode to default (allows multiple processes to use the GPU)
sudo nvidia-smi -c DEFAULT

echo "System configuration complete."
