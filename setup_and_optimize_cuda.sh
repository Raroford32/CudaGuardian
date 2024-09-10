#!/bin/bash

set -e

log_file="cuda_setup.log"

log() {
    echo "$(date): $1" | tee -a "$log_file"
}

# 1. Install CUDA
log "Starting CUDA installation..."
source ./install_cuda.sh >> "$log_file" 2>&1
log "CUDA installation completed."

# 2. Configure the system
log "Configuring the system..."
source ./configure_system.sh >> "$log_file" 2>&1
log "System configuration completed."

# 3. Compile and run CUDA test
log "Compiling and running CUDA test..."
source ./compile_and_run_test.sh >> "$log_file" 2>&1
log "CUDA test completed."

# 4. Run benchmarks
log "Running benchmarks..."
source ./run_benchmarks.sh >> "$log_file" 2>&1
log "Benchmarks completed."

# 5. Start GPU monitoring (in background)
log "Starting GPU monitoring..."
./monitor_gpus.sh &
monitor_pid=$!
log "GPU monitoring started with PID: $monitor_pid"

log "CUDA setup and optimization completed successfully."
echo "To stop GPU monitoring, run: kill $monitor_pid"
