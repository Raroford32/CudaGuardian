import numpy as np
import time
import logging
import os

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Check CUDA availability
use_cuda = False
try:
    import cupy as cp
    use_cuda = True
    logging.info("CUDA is available. Using GPU.")
except ImportError:
    logging.warning("CUDA not available. Using CPU instead.")

def vector_add(a, b):
    return a + b

def main():
    n = 10000000  # Increased size for better benchmarking
    
    if use_cuda:
        try:
            a = cp.ones(n, dtype=cp.float32)
            b = cp.ones(n, dtype=cp.float32) * 2
        except Exception as e:
            logging.error(f"Error initializing CUDA arrays: {str(e)}")
            logging.info("Falling back to CPU...")
            use_cuda = False
            a = np.ones(n, dtype=np.float32)
            b = np.ones(n, dtype=np.float32) * 2
    else:
        a = np.ones(n, dtype=np.float32)
        b = np.ones(n, dtype=np.float32) * 2

    start_time = time.time()

    try:
        c = vector_add(a, b)
    except Exception as e:
        logging.error(f"Error during vector addition: {str(e)}")
        return

    end_time = time.time()

    if use_cuda:
        try:
            c = cp.asnumpy(c)  # Transfer result back to CPU for printing
        except Exception as e:
            logging.error(f"Error transferring result to CPU: {str(e)}")
            return

    logging.info(f"First 10 elements of the result: {c[:10]}")
    logging.info(f"Time taken: {end_time - start_time:.4f} seconds")
    logging.info(f"Using {'CUDA' if use_cuda else 'CPU'}")

    # Log system information
    logging.info(f"Python version: {os.sys.version}")
    logging.info(f"NumPy version: {np.__version__}")
    if use_cuda:
        logging.info(f"CuPy version: {cp.__version__}")

if __name__ == "__main__":
    main()
