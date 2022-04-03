NVCC=nvcc
ENCODER=blurhash_cuda_encoder
DECODER=blurhash_cuda_decoder

all: ${ENCODER} ${DECODER}

# Shared dependencies
CSV_LOGGER_DEP=build/csv_logger.o


# Compile the encoder
ENCODER_DEP=build/encode.o build/encode_stb.o ${CSV_LOGGER_DEP}

$(ENCODER): ${ENCODER_DEP}
	$(NVCC) -o $@ ${ENCODER_DEP} -lm

build/encode_stb.o: src/encode_stb.cu
	$(NVCC) -c src/encode_stb.cu -o $@ -dc

build/encode.o: src/encode.cu include/encode.cuh include/utils.h include/constants.h
	$(NVCC) -c src/encode.cu -o $@ -dc


# Compile the decoder
DECODER_DEP=build/decode.o build/decode_stb.o ${CSV_LOGGER_DEP}

${DECODER}: ${DECODER_DEP}
	$(NVCC) -o $@ ${DECODER_DEP} -lm

build/decode_stb.o: src/decode_stb.cu
	$(NVCC) -c src/decode_stb.cu -o $@ -dc

build/decode.o: src/decode.cu include/decode.cuh include/utils.h include/constants.h
	$(NVCC) -c src/decode.cu -o $@ -dc


# Compile CSV logger
${CSV_LOGGER_DEP}: src/csv/csv_logger.cu include/csv/csv_logger.cuh
	$(NVCC) -c src/csv/csv_logger.cu -o $@ -dc


.PHONY: clean
clean:
	rm -f ${ENCODER}
	rm -f ${DECODER}
	rm build/*.o
