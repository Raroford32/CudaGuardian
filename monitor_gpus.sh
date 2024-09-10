#!/bin/bash

# Function to display GPU utilization
show_gpu_utilization() {
    nvidia-smi --query-gpu=index,name,temperature.gpu,utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv,noheader
}

# Continuous monitoring
while true; do
    clear
    echo "GPU Utilization:"
    show_gpu_utilization
    sleep 5
done
