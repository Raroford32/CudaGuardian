#!/bin/bash

log_file="benchmark_results.log"

log() {
    echo "$(date): $1" | tee -a "$log_file"
}

# Check if CUDA samples are installed
if [ ! -d "/usr/local/cuda/samples" ]; then
    log "CUDA samples not found. Attempting to install..."
    sudo apt-get update
    sudo apt-get install -y cuda-samples-11-7
fi

# Function to run a benchmark
run_benchmark() {
    local dir=$1
    local name=$2
    local cmd=$3
    
    if [ -d "$dir" ]; then
        cd "$dir"
        if [ -f "Makefile" ]; then
            log "Compiling $name..."
            sudo make > /dev/null 2>&1
        fi
        if [ -x "$cmd" ]; then
            log "Running $name..."
            ./$cmd
        else
            log "Error: $name executable not found."
        fi
    else
        log "Error: $name directory not found."
    fi
}

# Run deviceQuery
run_benchmark "/usr/local/cuda/samples/1_Utilities/deviceQuery" "deviceQuery" "deviceQuery"

# Run bandwidthTest
run_benchmark "/usr/local/cuda/samples/1_Utilities/bandwidthTest" "bandwidthTest" "bandwidthTest"

# Run nbody simulation benchmark
run_benchmark "/usr/local/cuda/samples/5_Simulations/nbody" "nbody" "nbody -benchmark -numbodies=256000 -device=0"

log "Benchmarks complete. Please review the results in $log_file."
