section .data
	myNumber db 10 ; declare byte mem location myNumber with value 10
	myNumberLen equ $- myNumber
	num2 db 20
	num3 db 30
	msg db "hhhh", 0ah
	msgLen equ $- msg

global _start

_start:
	; mov eax, 1
	; mov ebx, [myNumber]
	; mov ecx, 10
	; mov edx, 20
	; xor ebx, ebx
	; jmp quit

	; push parameters to stack (last to first
	push dword [num3]
	push dword [num2]
	push dword [myNumber]

	call myFunc

	; get rid of params after function call
	; 3 parameters * 4 bytes each = 12 bytes
	; increment/add base pointer by 12 bytes
	add esp, 12

	; log to console
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msgLen
	int 0x80

quit:
	mov eax, 1
	; mov ebx, 14
	int 0x80

myFunc:
	; standard subroutine prologue
	push ebp ; save the old base pointer value
	mov ebp, esp ; set the new base pointer value
	sub esp, 4 ; make room for one 4-byte local variable
	push edi ; save the values of registers that the function will modify
	push esi ; this function uses EDI and ESI
		 ; hence no need to save EAX, EBP or ESP
	
	; subroutine body
	mov eax, [ebp+8] ; param 1
	mov esi, [ebp+12] ; param 2
	mov edi, [ebp+16] ; param 3

	mov [ebp-4], edi ; value of edi to local variable
	add [ebp-4], esi ; add value of esi to local variable
	add eax, [ebp-4] ; add the value of local variable to eax

	; standard subrouting epilogue "cleanup"
	pop esi ; recover register values
	pop edi
	mov esp, ebp ; deallocate local variable
	pop ebp ; return base pointer to initial state (caller's base pointer)
	ret
