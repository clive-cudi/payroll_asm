section .data
    promptName db "Enter your first name: ", 0
    promptAge db "Enter Age: ", 0
    constYear dw 2023
    ; initialize buffers
    bufferName db 32
    bufferAge db 32
    ; atoi function utils
    buf_size equ 16 ; maximum number of digits in an int
    digit_shift equ 10 ; constant for multiplying digit values
section .text
    global _start
_start:
    ; prompt for first name
    mov eax, 4
    mov ebx, 1
    mov ecx, promptName
    mov edx, 23
    int 0x80

    ; read first name
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferName
    mov edx, 32
    int 0x80

    ; prompt for age
    mov eax, 4
    mov ebx, 1
    mov ecx, promptAge
    mov edx, 11
    int 0x80

    ; read age
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferAge
    mov edx, 32
    int 0x80

    ; convert age to integer
    mov eax, bufferAge
    call atoi ; convert eax to int
    mov ebx, constYear
    add eax, ebx

    ; display the result
    mov ebx, 1
    call itoa
    mov ecx, eax
    mov edx, 4
    mov eax, 4
    int 0x80

    ; exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

atoi:
    push ebp ; base pointer
    mov ebp, esp
    push ebx; save ebx

    xor eax, eax
    mov ebx, [ebp+8]
    .loop:
        movzx ecx, byte [ebx]
        cmp ecx, 0
        je .done
        sub ecx, '0'
        mul dword [digit_shift]
        add eax, ecx
        inc ebx
        jmp .loop
    .done:
        pop ebx ; restore ebx
        mov esp, ebp
        pop ebp
        ret

itoa:
    push ebp ; base pointer
    mov ebp, esp
    push ebx
    push ecx

    mov ebx, [ebp+8]
    mov ecx, buf_size
    mov edi, [ebp+12]
    mov byte [edi], '-' ; set sign character to '-'
    cmp ebx, 0
    jge .positive
        neg ebx ; negate the value
        mov byte [edi], '-'
    .positive:
        add edi, 1
        .loop:
            xor edx, edx ; clear edx
            div dword [digit_shift] ; divide by 10
            add edx, '0' ; convert to digit char
            mov byte [ecx+edi-1], dl
            dec ecx
            cmp ebx, 0
            jne .loop
        mov eax, edi
    
    pop ecx ; restore ecx
    pop ebx ; restore ebx
    mov esp, ebp
    pop ebp
    ret