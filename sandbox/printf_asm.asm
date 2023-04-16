global main
extern printf

section .data
	msg db "Hello testing %i...", 0x0a, 0x00 

; c already declares a _start label/function
; so we need to define a main function
section .text
main:
	push ebp
	mov ebp, esp
	push 123
	push msg
	call printf
	mov eax, 0
	mov esp, ebp
	pop ebp
	ret
