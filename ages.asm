; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages


; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIF
    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    
    xor ebx, ebx
    xor eax, eax
loop_age:
    mov eax, DWORD [esi + my_date.year]
    sub eax, DWORD [edi + my_date_size * ebx + my_date.year]
    cmp eax, 0
    je loop_age0
    xor eax, eax
    mov ax, WORD [esi + my_date.month]
    cmp ax, [edi + my_date_size * ebx + my_date.month]
    jl loop_age1
    jg loop_age2
    xor eax, eax
    mov ax, WORD [esi + my_date.day]
    cmp ax, [edi + my_date_size * ebx + my_date.day]
    jl loop_age1
    jg loop_age2
    mov eax, DWORD [esi + my_date.year]
    sub eax, DWORD [edi + my_date_size * ebx + my_date.year]
    mov DWORD[ecx + ebx * my_date.year], eax
    inc ebx
    cmp ebx, edx
    jne loop_age
    jmp finish

loop_age2:
    mov eax, DWORD [esi + my_date.year]
    sub eax, DWORD [edi + my_date_size * ebx + my_date.year]
    mov DWORD[ecx + ebx * my_date.year], eax
    inc ebx
    cmp ebx, edx
    jne loop_age
    jmp finish
loop_age1:
    xor eax, eax
    mov eax, DWORD [esi + my_date.year]
    sub eax, DWORD [edi + my_date_size * ebx + my_date.year]
    sub eax, 1
    mov DWORD[ecx + ebx * my_date.year], eax
    inc ebx
    cmp ebx, edx
    jne loop_age
    jmp finish
loop_age0_month:
    mov DWORD[ecx + ebx * my_date.year], 0
    inc ebx
    cmp ebx, edx
    jne loop_age
    jmp finish
loop_age0:
    xor eax, eax
    mov ax, [esi + my_date.month]
    cmp ax, [edi + my_date_size * ebx + my_date.month]
    jl loop_age0_month
    xor eax, eax
    mov ax, [esi + my_date.day]
    cmp ax, [edi + my_date_size * ebx + my_date.day]
    jl loop_age0_month
finish:
    ;; FREESTYLE0 ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
