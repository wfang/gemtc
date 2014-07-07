#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

static size_t MM = 90000000;

void add(int *a, int *b, int *c, size_t n){
    size_t i;
    
    omp_set_num_threads(1);
    
    #pragma omp parallel for
    for(i = 0; i < n; ++i) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    int *a, *b, *c;
    size_t i;
    struct timespec start, finish;
    double elapsed;

    a = (int *) malloc(MM*sizeof(int));
    b = (int *) malloc(MM*sizeof(int));
    c = (int *) malloc(MM*sizeof(int));


    for(i = 0; i < MM; ++i){
        a[i] = i;
        b[i] = i;
    }

    clock_gettime(CLOCK_MONOTONIC, &start);
    add(a,b,c,MM);
    clock_gettime(CLOCK_MONOTONIC, &finish);
    elapsed = (finish.tv_sec - start.tv_sec);
    elapsed += (finish.tv_nsec - start.tv_nsec)/ 1000000000.0;

    printf("\n time = %le  ",elapsed);

    free(a);
    free(b);
    free(c);
    return 0;
}