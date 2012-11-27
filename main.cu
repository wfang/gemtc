#include "gemtc.cu"
#include <cuda_runtime.h>

int main(int argc, char **argv){

  // creates two queues each size of half this param
  setupGemtc(2560);

  // doing work on gpu
  int i;
  for(i=0; i<1; i++){
    int sleepTime = 60000000;
    // runs a task on the gpu
    void *ret = run(0, 32, &sleepTime, sizeof(int));
    //printf("%d : Finished job with parameter: %d\n",i, *(int *)ret);
  }

  // stops the superkernel and cleans up some memory
  cleanupGemtc();

  return 0;
}
