#pragma once

int csvAppendLine(const char *filename, const char *line);

void csvAppendEncoderLogs(const char *filename, const char *imgPath,
    int width, int height,
    const char* result, int xComponents, int yComponents, 
    const char* version, int totalEncodingTimeInMs);
