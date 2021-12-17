section .data
    extern len_cheie, len_haystack
    size dd '0'
    index_column dd '0'
    index_line dd '0'
    index_caract dd '0'

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    xor edx, edx
    mov ecx, [len_cheie]
    mov eax, [len_haystack]
    div ecx
    cmp edx, 0
    jne add_len
back:
    mov [size], eax
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    mov eax, 0
loop1:
    mov [index_column], eax
    mov edx, 0
    jmp loop2
loop2:
    mov [index_line], edx
    xor eax, eax
    xor edx, edx
    mov eax, [index_line]
    mov edx, [len_cheie]
    imul eax, edx
    xor edx, edx
    mov ecx, [index_column]
    mov edx, [edi + 4 * ecx] 
    add eax, edx
    xor edx, edx
    cmp eax, [len_haystack]
    jge label2
    mov dl, [esi + eax]
    mov [ebx], dl
    xor edx, edx
    inc ebx
    mov edx,[index_line]  
    inc edx
    cmp edx, [size]
    jne loop2
label2:
    mov eax, [index_column]
    inc eax
    mov ecx, [len_cheie]
    cmp eax, ecx
    jne loop1
    jmp final
add_len:
    add eax, 1
    jmp back
final:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY