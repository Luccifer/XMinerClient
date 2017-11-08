#include "oaes_lib.h"

#ifndef CRYPTONIGHT_H
#define CRYPTONIGHT_H

#define MEMORY         (1 << 21) /* 2 MiB */
#define ITER           (1 << 20)
#define AES_BLOCK_SIZE  16
#define AES_KEY_SIZE    32 /*16*/
#define INIT_SIZE_BLK   8
#define INIT_SIZE_BYTE (INIT_SIZE_BLK * AES_BLOCK_SIZE)    // 128

#define likely(x) (x)

#ifdef __cplusplus
extern "C" {
#endif
    
#pragma pack(push, 1)
    union hash_state {
        uint8_t b[200];
        uint64_t w[25];
    };
#pragma pack(pop)
    
#pragma pack(push, 1)
    union cn_slow_hash_state {
        union hash_state hs;
        struct {
            uint8_t k[64];
            uint8_t init[INIT_SIZE_BYTE];
        };
    };
#pragma pack(pop)
    
    struct cryptonight_ctx {
        uint8_t long_state[MEMORY] __attribute((aligned(16)));
        union cn_slow_hash_state state;
        uint8_t text[INIT_SIZE_BYTE] __attribute((aligned(16)));
        uint8_t a[AES_BLOCK_SIZE] __attribute__((aligned(16)));
        uint8_t b[AES_BLOCK_SIZE] __attribute__((aligned(16)));
        uint8_t c[AES_BLOCK_SIZE] __attribute__((aligned(16)));
        oaes_ctx* aes_ctx;
    };
    
    void cryptonight(void *output, const void *input, size_t len);
    void cryptonight_hash_ctx(void * output, const void * input, struct cryptonight_ctx * ctx);
    
#ifdef __cplusplus
}
#endif

#endif
