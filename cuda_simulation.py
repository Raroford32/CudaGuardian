import numpy as np
import time

try:
    import cupy as cp
    use_cuda = True
except ImportError:
    use_cuda = False
    print("CUDA not available. Using CPU instead.")

def vector_add(a, b):
    return a + b

def main():
    n = 10000000  # Increased size for better benchmarking
    
    if use_cuda:
        a = cp.ones(n, dtype=cp.float32)
        b = cp.ones(n, dtype=cp.float32) * 2
    else:
        a = np.ones(n, dtype=np.float32)
        b = np.ones(n, dtype=np.float32) * 2

    start_time = time.time()

    c = vector_add(a, b)

    end_time = time.time()

    if use_cuda:
        c = cp.asnumpy(c)  # Transfer result back to CPU for printing

    print(f"First 10 elements of the result: {c[:10]}")
    print(f"Time taken: {end_time - start_time:.4f} seconds")
    print(f"Using {'CUDA' if use_cuda else 'CPU'}")

if __name__ == "__main__":
    main()
