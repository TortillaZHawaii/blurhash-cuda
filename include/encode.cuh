#pragma once

#include <stdint.h>
#include <stdlib.h>

const char *blurHashForPixels(int xComponents, int yComponents, int width, int height, uint8_t *rgb, size_t bytesPerRow);
