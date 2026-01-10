cc -Wall -Wextra -Wpedantic -ggdb3 -fsanitize=address,undefined -fsanitize-undefined-trap-on-error -o vetor_soma vetor_soma.c -lOpenCL
#&& ./device_info && ./vetor_soma
