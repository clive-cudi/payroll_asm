section .data
myNumber dd 42 ; a 32-bit integer
outputString db 16 dup(0) ; buffer to store the string representation of myNumber

section .text
global _start

_start:
	mov eax, myNumber ; move the value of myNumber into eax
	mov ebx, outputString ; address of the output buffer
	call itoa ; call the itoa function to convert myNumber to a string
	mov ebx, 1 ; file descriptor (1 = STDOUT)
	mov ecx, outputString ; address of the buffer to write
	mov edx, eax ; number of bytes to write (length of the output string)
	mov eax, 4 ; write system call number
	int 0x80 ; invoke system call
	mov eax, 1 ; set eax to 1 (sys_exit system call)
	xor ebx, ebx ; set ebx to 0 (status code 0)
	int 0x80 ; invoke system call to exit

itoa:
	push ebp ; save ebp on the stack
	mov ebp, esp ; set ebp to point to the top of the stack
	push ebx ; save ebx on the stack
	push ecx ; save ecx on the stack
	push edx ; save edx on the stack
	push esi ; save esi on the stack
	push edi ; save edi on the stack

	mov esi, esp ; set esi to point to the first argument (the number to convert)
	mov edi, [ebp+8] ; set edi to point to the second argument (the output buffer)
	mov ecx, 10 ; set ecx to the base (decimal)
	xor eax, eax ; clear eax (used as a counter)
	itoa_loop:
		xor edx, edx ; clear edx (used as a remainder)
		div ecx ; divide eax by ecx
		add edx, '0' ; convert the remainder to an ASCII digit
		mov [edi+eax], dl ; store the digit in the output buffer
		inc eax ; increment the counter
		test esi, esi ; test if eax is zero
		jnz itoa_loop ; loop until eax is zero
		mov eax, esi ; set eax to point to the first argument
		sub eax, esp ; subtract the size of the arguments from eax
		mov esp, eax ; adjust the stack pointer

	pop edi ; restore edi from the stack
	pop esi ; restore esi from the stack
	pop edx ; restore edx from the stack
	pop ecx ; restore ecx from the stack
	pop ebx ; restore ebx from the stack
	mov esp, ebp ; restore esp from ebp
	pop ebp ; restore ebp from the stack
	ret ; return from the function
