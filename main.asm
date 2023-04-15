section .data
	introPrompt db "Welcome to the payroll system ", 0ah
	introOption1 db "1. Read employee details", 0ah
	introOption2 db "2. Update/add employee details", 0ah
	introPromptLen equ $- introPrompt

section .text


global _start

_start:
	; log introPrompt to console
	push introPrompt ; push the string pointer to the stack
	call log_to_console ; call log_to_console function
	add esp, 4 ; remove the string pointer from the stack

	; log introOption1 to console
	push introOption1 ; push the string pointer to the stack
	call log_to_console ; call log_to_console function
	add esp, 4 ; remove the string pointer from the stack





	; end program
	mov eax, 1 ; exit
	; mov ebx, 10 ; status code 0
	int 0x80

_return_sth:
	mov ebx, 5
	ret

log_to_console:
	; logs sth to console
	; subroutine prologue
	push ebp ; save old base pointer
	mov ebp, esp ; set up new base pointer

	; get the function argument (pointer to string)
	mov eax, [ebp+8] ; get the first function argument

	; get the length of the string
	push eax ; push the string pointer to the stack
	call strlen ; call strlen function
	add esp, 4 ; remove the string pointer from the stack
	mov edx, eax ; set edx to the length of the string

	; log the string to console
	mov eax, 4 ; write to file
	mov ebx, 1 ; file descriptor 1 (stdout)
	int 0x80 ; call interrupt

	; subroutine epilogue
	pop ebp ; restore old base pointer
	ret ; return from function

strlen:
	push ebp ; save old base pointer
	mov ebp, esp ; set up new base pointer

	; get the function argument (pointer to string)
	mov eax, [ebp+8] ; get the first function argument

	; loop through the string to find the null terminator
	xor ecx, ecx ; set ecx to 0 to start the loop counter
	loop:
		mov bl, [eax+ecx] ; get the byte at the current position in the string
		cmp bl, 0 ; compare the byte to null terminator
		je done ; if the byte is null terminator, jump to done label
		inc ecx ; increment the loop counter
		jmp loop ; jump back to loop label

	done:
		mov eax, ecx ; set eax to the length of the string

		pop ebp ; restore old base pointer
	ret ; return from function
