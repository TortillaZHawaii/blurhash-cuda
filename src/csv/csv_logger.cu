#include <stdio.h>
#include "../../include/csv/csv_logger.cuh"

int csvAppendLine(const char *filename, const char *line)
{
    FILE* fpt = fopen(filename, "a");
    if(fpt == NULL)
    {
        printf("Error opening file %s\n", filename);
        return -1;
    }

    fprintf(fpt, "%s\n", line);
    fclose(fpt);

    return 0;
}

void csvAppendEncoderLogs(const char *filename, const char *imgPath,
    int width, int height,
    const char* result, int xComponents, int yComponents, 
    const char* version, int totalEncodingTimeInMs)
{
    char line[1024];
    sprintf(line, "%s,%s,%d,%d,%s,%d,%d,%s,%d", imgPath, result, width, height, version, xComponents, yComponents, "encoder", totalEncodingTimeInMs);
    csvAppendLine(filename, line);
}
