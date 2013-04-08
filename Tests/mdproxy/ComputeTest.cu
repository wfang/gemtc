#include "../../gemtc.cu"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv){
  gemtcSetup(25600, 0);
  
  int np = 5;
  int nb = 6;
  int a_size = np * nb;

  int size = sizeof(int)*2 + sizeof(double)*a_size;
  
  void *d_mem = gemtcGPUMalloc(size);
  void *h_mem = malloc(size);

  double pos[a_size];

  memcpy(h_mem, &np, sizeof(int));
  memcpy((((int*)h_mem)+1), &nb, sizeof(int));
  memcpy((((int*)h_mem)+2), pos, sizeof(double)*a_size); 

  gemtcMemcpyHostToDevice(d_mem, h_mem, size);
  gemtcPush(16, 1, 12000, d_mem); 
 
  void *ret = NULL;
  int id;
  while(ret==NULL){
    gemtcPoll(&id, &ret);
  }

  void* results = malloc(size);
  gemtcMemcpyDeviceToHost(results, ret, size);

  int *p_np = (int*)results;
  int *p_nb = ((int*)results)+1;
  double *p_pos = (double*)((int*)results + 2); 

  printf("np is : %d\nnb is : %d\n", *p_np, *p_nb);
  int i;
  for(i=0; i<a_size; i++){
    printf("%f\n", p_pos[i]);
  }

  gemtcGPUFree(results);
  ret = NULL;

  gemtcCleanup();
}
