section .data
	output db "Hello world", 0
	outBufferLen db 0
	outputBuffer db 0
section .text
	global _start

_start:
	push dword output ; push target string to stack
	call strlen ; call strlen
	add esp, 4 ; remove strlen pointer

	; output
	; mov ecx, eax ; move the string length to ecx
	; ; mov dword [outBufferLen], eax
	; mov eax, 4
	; mov ebx, 1
	; mov edx, 4
	; int 0x80

	mov [outputBuffer], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, outputBuffer
	mov edx, 16
	int 0x80

	; terminate
	mov eax, 1
	; xor ebx, ebx
	mov ebx, [outputBuffer]
	int 0x80

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
