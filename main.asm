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

section .bss
	introOptionChoiceBuffer resd 1

section .text
	main:
		; main function prologue
		push ebp
		mov ebp, esp

		; log statements
		push introPrompt
		call printf

		push introOption1
		call printf

		push introOption2
		call printf

		push introOption3
		call printf

		; read input for introOptions
		mov eax, 3
		mov ebx, 0 ; stdout
		mov ecx, introOptionChoiceBuffer,
		mov edx, 1
		int 0x80

		mov esi, [introOptionChoiceBuffer]
		push esi
		push chooseResult
		call printf


		; end program epilogue
		mov eax, 0 ; exit
		mov esp, ebp
		pop ebp
		ret

	log_to_console:
		push ebp
		mov ebp, esp

		mov eax, [ebp+8]

		push eax
		call printf

		mov eax, 0
		mov esp, ebp
		pop ebp
		ret