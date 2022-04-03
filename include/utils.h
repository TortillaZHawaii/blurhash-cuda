#pragma once

#include <math.h>
#include <stdint.h>

#ifndef MAX_BYTE
#define MAX_BYTE 255
#endif

#ifndef MIN_BYTE
#define MIN_BYTE 0
#endif

uint8_t clampToUByte(int value)
{
    if(value > MAX_BYTE)
    {
        return MAX_BYTE;
    }    

    if(value < MIN_BYTE)
    {
        return MIN_BYTE;
    }
    
    return value;
}

int linearTosRGB(float value)
{
    float v = fmax(0, fminf(1, value));

    if(v <= 0.0031308)
    {
        return v * 12.92f * MAX_BYTE + 0.5f;
    }

    return (1.055f * powf(v, 1 / 2.4f) - 0.055f) * MAX_BYTE + 0.5f;
}

// 0-255 to linear representation with weird curve
float sRGBToLinear(int value)
{
    float v = (float)value / MAX_BYTE;

    if(v <= 0.04045)
    {
        return v / 12.92f;
    }

    return powf((v + 0.055f) / 1.055f, 2.4f);
}

float signedPow(float base, float exponent)
{
    return copysignf(powf(fabsf(base), exponent), base);
}