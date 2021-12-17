;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .data
    OFFSET dd '0'
    data dd '0'

section .text
    global load

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    mov esi, edx
    shl esi, TAG_BITS
    shr esi, TAG_BITS
    mov [OFFSET], esi
    mov esi, edx
    shr esi, OFFSET_BITS
    shl esi, OFFSET_BITS
    push ecx
    mov ecx, 0
exist_tag:
    mov [data], ecx
    imul ecx, 4
    cmp esi, [ebx + ecx]
    mov ecx, [data]
    je OFFSET_equal
    inc ecx
    cmp ecx, CACHE_LINES
    jne exist_tag
cache_miss:
    imul edi, 4
    add ebx, edi
    mov [ebx], esi
    mov ecx, 0
    xor edx, edx
    mov edi, [ebp + 24]
    pop edx
    imul edi, CACHE_LINE_SIZE
    add edx, edi
loop_replace:
    push ecx
    xor ecx, ecx
    mov ecx, [esi]
    mov [edx], ecx
    inc edx
    inc esi
    pop ecx
    inc ecx
    cmp ecx, CACHE_LINE_SIZE
    jne loop_replace
    sub edx, 0x8
    add edx, [OFFSET]
    xor ecx, ecx
    mov ecx, [edx]
    mov [eax], ecx
    jmp final
OFFSET_equal:
    xor esi, esi
    pop esi
    imul ecx, CACHE_LINE_SIZE
    add ecx, [OFFSET]
    add esi, ecx
    xor ecx, ecx
    mov ecx, [esi]
    mov [eax], ecx
final:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


