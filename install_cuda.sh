#!/bin/bash

set -e

log_file="cuda_install.log"

log() {
    echo "$(date): $1" | tee -a "$log_file"
}

# Update package list
log "Updating package list..."
sudo apt-get update

# Install build essentials and kernel headers
log "Installing build essentials and kernel headers..."
sudo apt-get install -y build-essential linux-headers-$(uname -r)

# Install NVIDIA drivers
log "Installing NVIDIA drivers..."
sudo apt-get install -y nvidia-driver-515 || {
    log "Failed to install NVIDIA drivers. Trying alternative method..."
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt-get update
    sudo apt-get install -y nvidia-driver-515
}

# Download and install CUDA Toolkit (adjust version as needed)
log "Downloading and installing CUDA Toolkit..."
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda_11.7.0_515.43.04_linux.run
sudo sh cuda_11.7.0_515.43.04_linux.run --silent --toolkit --samples --driver

# Set up environment variables
log "Setting up environment variables..."
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# Verify installation
log "Verifying installation..."
if command -v nvcc &> /dev/null; then
    nvcc --version
else
    log "Error: NVCC not found. CUDA installation may have failed."
    exit 1
fi

if command -v nvidia-smi &> /dev/null; then
    nvidia-smi
else
    log "Error: nvidia-smi not found. NVIDIA driver installation may have failed."
    log "Attempting to load NVIDIA kernel module..."
    sudo modprobe nvidia
    if [ $? -eq 0 ]; then
        log "NVIDIA kernel module loaded successfully."
        nvidia-smi
    else
        log "Failed to load NVIDIA kernel module. A system reboot may be required."
        exit 1
    fi
fi

log "CUDA and NVIDIA driver installation complete. A system reboot is recommended."
