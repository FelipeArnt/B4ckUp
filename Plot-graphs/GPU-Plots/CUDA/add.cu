#include <stdio.h>

__global__ void exemplo1D(int *out) {
    int idx_global = blockDim.x * blockIdx.x + threadIdx.x;

    printf("blockIdx.x = %d, threadIdx.x = %d, idx_global = %d\n",
           blockIdx.x, threadIdx.x, idx_global);

    out[idx_global] = idx_global;
}

__global__ void exemploMax(int *out, int N) {
    
    int idx = blockDim.x * blockIdx.x + threadIdx.x;
    if (idx < N) {out[idx] = idx;}
}

__global__
void saxpy(int n, float a, float *x, float *y)
{
    for (int i = blockIdx.x * blockDim.x + threadIdx.x; 
         i < n; 
         i += blockDim.x * gridDim.x) 
      {
          y[i] = a * x[i] + y[i];
      }
}

static double wtime(void)   /* segundos desde a época – precisão ~ms */
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main() {
    const int N = 14336;          // 14 SMs * 1024 threads
    //const int N = 1 << 20;
    const int threads = 1024;     // máximo de threads por bloco
    const int blocks  = (N + threads - 1) / threads; // 14 blocos

    int h_out[N];
    int *d_out;
    
    float a, *x, *y;

    cudaMallocManaged((void **)&d_out, N * sizeof(int));
    cudaMallocManaged((void **)&y, N * sizeof(int));

    const double t0 = wtime();
    cudaGetLastError();
    cudaDeviceSynchronize();
    saxpy<<<blocks, threads>>>(N, a, x, y);
    //exemploMax<<<blocks, threads>>>(d_out, N);
    const double t1 = wtime();

    cudaMemcpy(h_out, d_out, N * sizeof(int), cudaMemcpyDeviceToHost);
    

    printf("\nVetor final:\n");
    for (int i = 0; i < N; i++) {
        printf("h_out[%d] = %d\n", i, h_out[i]);
    }
    
    printf("[Kernel time]: %.3fms\n", (t1 - t0) * 1e3);

    cudaFree(d_out);
    return 0;
}

