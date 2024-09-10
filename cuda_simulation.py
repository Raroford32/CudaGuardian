import multiprocessing
import time

def vector_add(a, b, c, start, end):
    for i in range(start, end):
        c[i] = a[i] + b[i]

def main():
    n = 1000000
    a = [1.0] * n
    b = [2.0] * n
    c = [0.0] * n

    num_processes = multiprocessing.cpu_count()
    chunk_size = n // num_processes
    processes = []

    start_time = time.time()

    for i in range(num_processes):
        start = i * chunk_size
        end = start + chunk_size if i < num_processes - 1 else n
        p = multiprocessing.Process(target=vector_add, args=(a, b, c, start, end))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()

    end_time = time.time()

    print(f"First 10 elements of the result: {c[:10]}")
    print(f"Time taken: {end_time - start_time:.4f} seconds")

if __name__ == "__main__":
    main()
