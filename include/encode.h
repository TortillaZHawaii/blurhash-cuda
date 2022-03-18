#ifndef __BLURHASH_CUDA_ENCODE_H__
#define __BLURHASH_CUDA_ENCODE_H__

#include <stdint.h>
#include <stdlib.h>

uint8_t* encode(int xComponents, int yComponents, int width, int height, uint8_t* rgb, size_t bytesPerRow);

#endif
