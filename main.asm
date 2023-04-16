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
	promptEnterEmployeeID db "Enter employee id: ", 0x0a, 0x00
	enterResultInt db "You entered: %d", 0x0a, 0x00
	enterResultString db "You entered: %d", 0x0a, 0x00
	invalidOption db "No valid option was choosen", 0x0a, 0x00

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
		mov dword [option], 0
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
		push invalidOption
		call printf
		add esp, 4
		jmp exit

read_employee_details:
		push readEmployeeDetailsIntro
		call printf
		add esp, 4

		push promptEnterEmployeeID
		call printf
		add esp, 4

		mov dword [option], 0
		push option
		push intFormat
		call scanf
		add esp, 8

		push dword [option]
		push enterResultInt
		call printf
		add esp, 8


		jmp exit

update_employee_details:
		push updateEmployeeDetailsIntro
		call printf
		add esp, 4

		push promptEnterEmployeeID
		call printf
		add esp, 4

		push option
		push intFormat
		call scanf
		add esp, 8

		push dword [option]
		push enterResultInt
		call printf
		add esp, 8

		jmp exit

exit:		; end program epilogue
		mov eax, 0 ; exit
		mov esp, ebp
		pop ebp
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