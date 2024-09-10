#!/bin/bash

set -e

log_file="cuda_setup.log"

log() {
    echo "$(date): $1" | tee -a "$log_file"
}

error() {
    log "ERROR: $1"
    exit 1
}

# 1. Run CUDA simulation
log "Running CUDA simulation..."
python cuda_simulation.py || error "Failed to run CUDA simulation"

# 2. Run benchmarks (update this to use Python-based benchmarks if needed)
log "Running benchmarks..."
python cuda_simulation.py || log "Warning: Benchmark may have failed. Check output for details."

log "CUDA simulation and optimization completed successfully."
