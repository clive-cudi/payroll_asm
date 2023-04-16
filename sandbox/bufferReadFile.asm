extern printf
extern malloc
extern free

section .data
    fileName db "./out/departments.txt", 0
    mode db "r", 0

section .bss
    buffer resb 1024
    fd_out resb 1
    fd_in  resb 1
    fd_size resb 1

section .text
    global main

    main:
        push ebp
        mov ebp, esp

        ; open file
        mov eax, 5
        mov ebx, fileName
        mov ecx, 0
        mov edx, 0777
        int 0x80

        mov [fd_in], eax

        ; get file size
        mov eax, 19
        mov ebx, [fd_in]
        mov ecx, 0
        mov edx, 0
        int 0x80

        mov [fd_size], eax

        ; allocate memory to buffer
        push fd_size
        call malloc
        add esp, 4

        

        ; print file size
        ; push fd_size
        ; call printf
        ; add esp, 4


    exit:		; end program epilogue
        mov eax, 0 ; exit
        mov esp, ebp
        pop ebp
        ret