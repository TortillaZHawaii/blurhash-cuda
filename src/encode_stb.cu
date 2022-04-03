#include "../include/encode.cuh"
#include "../include/csv/csv_logger.cuh"

#define STB_IMAGE_IMPLEMENTATION
#include "../include/stb/stb_image.h"

#include <stdio.h>
#include <time.h>

const char *blurHashForFile(int xComponents, int yComponents,
	const char *filename, const char *csvFilename);

int main(int argc, const char **argv) 
{
	if(argc != 4 && argc != 5)
    {
		fprintf(stderr, "Usage: %s x_components y_components imagefile [csvfile]\n", argv[0]);
		return 1;
	}

	int xComponents = atoi(argv[1]);
	int yComponents = atoi(argv[2]);
	
    if(xComponents < 1 || xComponents > 8 || yComponents < 1 || yComponents > 8)
    {
		fprintf(stderr, "Component counts must be between 1 and 8.\n");
		return 1;
	}

	const char *csvFilename = argc == 5 ? argv[4] : NULL;

	const char *hash = blurHashForFile(xComponents, yComponents, argv[3], csvFilename);
	
    if(!hash) 
    {
		fprintf(stderr, "Failed to load image file \"%s\".\n", argv[3]);
		return 1;
	}

	printf("%s\n", hash);

	return 0;
}

const char *blurHashForFile(int xComponents, int yComponents, 
	const char *filename, const char *csvFilename)
{
	int width, height, channels;
	unsigned char *data = stbi_load(filename, &width, &height, &channels, 3);
	if(!data) return NULL;

	clock_t startEncode = clock();

	const char *hash = blurHashForPixels(xComponents, yComponents, width, height, data, width * 3);

	clock_t endEncode = clock();

	if(csvFilename != nullptr)
	{
		int msec = (endEncode - startEncode) * 1000 / CLOCKS_PER_SEC;
		csvAppendEncoderLogs(csvFilename, filename, width, height,
		 	hash, xComponents, yComponents, "Pure C", msec);
	}


	stbi_image_free(data);

	return hash;
}
