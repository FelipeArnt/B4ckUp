__global__ void reducao_soma(const float *g_in, float *g_out, int N)
{
    extern __shared__ float sdata[];

    unsigned int tid = threadIdx.x;
    unsigned int idx = blockIdx.x * blockDim.x * 2 + threadIdx.x;

    float soma = 0.0f;
    if (idx < N) soma += g_in[idx];
    if (idx + blockDim.x < N) soma += g_in[idx + blockDim.x];

    sdata[tid] = soma;
    __syncthreads();

    for (unsigned int s = blockDim.x / 2; s > 0; s >>= 1)
    {
        if(tid < s)
        {
            sdata[tid] += sdata[tid + s];
        }
        __syncthreads();
    }

    if (tid == 0 )
    {
        g_out[blockIdx.x] = sdata[0];

    }
}
