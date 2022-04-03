NVCC=nvcc
ENCODER=blurhash_cuda_encoder
DECODER=blurhash_cuda_decoder

all: ${ENCODER} ${DECODER}

# Compile the encoder
ENCODER_DEP=build/encode.o build/encode_stb.o

$(ENCODER): ${ENCODER_DEP}
	$(NVCC) -o $@ ${ENCODER_DEP} -lm

build/encode_stb.o: src/encode_stb.cu
	$(NVCC) -c src/encode_stb.cu -o $@ -dc

build/encode.o: src/encode.cu include/encode.cuh include/utils.h include/constants.h
	$(NVCC) -c src/encode.cu -o $@ -dc

# Compile the decoder
DECODER_DEP=build/decode.o build/decode_stb.o

${DECODER}: ${DECODER_DEP}
	$(NVCC) -o $@ ${DECODER_DEP} -lm

build/decode_stb.o: src/decode_stb.cu
	$(NVCC) -c src/decode_stb.cu -o $@ -dc

build/decode.o: src/decode.cu include/decode.cuh include/utils.h include/constants.h
	$(NVCC) -c src/decode.cu -o $@ -dc

.PHONY: clean
clean:
	rm -f ${ENCODER}
	rm -f ${DECODER}
	rm build/*.o
