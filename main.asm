global main
extern printf
extern scanf

section .data
	introPrompt db "Welcome to the payroll system", 0x0a, 0x00
	introOption1 db "1. Read employee details", 0x0a, 0x00
	introOption2 db "2. Update/add employee details", 0x0a, 0x00
	introOption3 db "3. Exit", 0x0a, 0x00
	chooseResult db "You chose: %d", 0x0a, 0x00
	intFormat db "%d", 0
	option: times 4 db 0 ; 32-bit int 8*4
	STRING_TERMINATOR equ 0
	readEmployeeDetailsIntro db "Reading employee details", 0x0a, 0x00
	updateEmployeeDetailsIntro db "update employee details", 0x0a, 0x00

section .bss
	introOptionChoiceBuffer resb 25
	introOptionChoiceBufferLen equ $- introOptionChoiceBuffer

section .text
	main:
		; main function prologue
		push ebp
		mov ebp, esp

		; log statements
		push introPrompt
		call printf
		add esp, 4

		push introOption1
		call printf
		add esp, 4

		push introOption2
		call printf
		add esp, 4

		push introOption3
		call printf
		add esp, 4

		; read input
		push option
		push intFormat
		call scanf
		add esp, 8

		push dword [option]
		push chooseResult
		call printf
		add esp, 8

		mov eax, dword [option]

		cmp eax, 1
		je read_employee_details

		cmp eax, 2
		je update_employee_details

		cmp eax, 3
		je exit

		; no valid option chosen
		jmp exit

read_employee_details:
		push readEmployeeDetailsIntro
		call printf
		add esp, 4
		jmp exit

update_employee_details:
		push updateEmployeeDetailsIntro
		call printf
		add esp, 4
		jmp exit

exit:		; end program epilogue
		mov eax, 0 ; exit
		mov esp, ebp
		pop ebp
		ret

	; Input:
	; ESI = pointer to the string to convert
	; ECX = number of digits in the string (must be > 0)
	; Output:
	; EAX = integer value
	string_to_int:
		xor ebx,ebx    ; clear ebx
		.next_digit:
			movzx eax,byte[esi]
			inc esi
			sub al,'0'    ; convert from ASCII to number
			imul ebx,10
			add ebx,eax   ; ebx = ebx*10 + eax
			loop .next_digit  ; while (--ecx)
			mov eax,ebx
			ret


	; Input:
	; EAX = integer value to convert
	; ESI = pointer to buffer to store the string in (must have room for at least 10 bytes)
	; Output:
	; EAX = pointer to the first character of the generated string
	int_to_string:
		add esi,9
		mov byte [esi],STRING_TERMINATOR

		mov ebx,10         
		.next_digit:
			xor edx,edx         ; Clear edx prior to dividing edx:eax by ebx
			div ebx             ; eax /= 10
			add dl,'0'          ; Convert the remainder to ASCII 
			dec esi             ; store characters in reverse order
			mov [esi],dl
			test eax,eax            
			jnz .next_digit     ; Repeat until eax==0
			mov eax,esi
			ret

	; read_employee_details:
	; 	push ebp
	; 	mov ebp, esp

	; 	push readEmployeeDetailsIntro
	; 	call printf
	; 	add esp, 4
		
	; 	; clean up
	; 	mov eax, 0
	; 	mov esp, ebp
	; 	pop ebp
	; 	ret

	; update_employee_details:
	; 	push ebp
	; 	mov ebp, esp

	; 	push updateEmployeeDetailsIntro
	; 	call printf
	; 	add esp, 4

	; 	mov eax, 0
	; 	mov esp, ebp
	; 	pop ebp
	; 	ret