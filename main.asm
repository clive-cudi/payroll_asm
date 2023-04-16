global main
extern printf
extern scanf

section .data
	; message strings to show up at first on run
	introPrompt db "Welcome to the payroll system", 0x0a, 0x00
	introOption1 db "1. Read employee details", 0x0a, 0x00
	introOption2 db "2. Update/add employee details", 0x0a, 0x00
	introOption3 db "3. Exit", 0x0a, 0x00
	chooseResult db "You chose: %d", 0x0a, 0x00 ; store printf argument string for displaying the chosen option
	intFormat db "%d", 0 ; store int input formatter for scanf (argument)
	strFormat db "%s", 0 ; store string input formatter for scanf (argument)
	option: times 4 db 0 ; 32-bit int 8*4
	; message strings for respective first-level options chosen
	readEmployeeDetailsIntro db "Reading employee details", 0x0a, 0x00
	updateEmployeeDetailsIntro db "Update employee details", 0x0a, 0x00
	; message string for prompting Employee ID
	promptEnterEmployeeID db "Enter employee id: ", 0x0a, 0x00
	enterResultInt db "You entered: %d", 0x0a, 0x00 ; store printf arg string for displaying the int option chosen
	enterResultString db "You entered: %s", 0x0a, 0x00 ; store printf arg string for displaying the string option chosen
	invalidOption db "No valid option was choosen", 0x0a, 0x00 ; store printf arg string for invalid option
	promptDepartmentName db "Enter departmentName: ", 0x0a, 0x00 ; message string for prompting dept. name
	notFoundDepartmentName db "No department with the name %s was found", 0x0a, 0x00 ; store printf arg string for dept. not found
	optionString db "", 0x0a ; storing user input of type string
	optionStringReset db "", 0x0a ; resetting the optionString
	departmentListPath db "./data/departments.txt"

section .bss
	fileInputBuffer resb 26

section .text
	main:
		; main function prologue
		push ebp ; push intial base pointer to stack
		mov ebp, esp ; move stack pointer to base pointer location
		; function frame

		; log statements
		push introPrompt ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params

		push introOption1 ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params => 1 param * 4 bytes each = 4

		push introOption2 ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params => 1 param * 4 bytes each = 4

		push introOption3 ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params => 1 param * 4 bytes each = 4

		; read input scanf("%d", &option);
		mov dword [option], 0 ; reset option to 0
		push option ; parameter 2 for scanf (push option pointer on the stack)
		push intFormat ; parameter 1 for scanf (pointer to string arg) 
		call scanf ; call scanf()
		add esp, 8 ; deallocate scanf params => 2 params * 4 bytes each

		push dword [option] ; parameter 1 for printf
		push chooseResult ; parameter 2 for printf
		call printf ; call printf
		add esp, 8 ; deallocate printf params => 2 params * 4 bytes each = 8

		mov eax, dword [option] ; move value of option to eax

		cmp eax, 1 ; option is one
		je read_employee_details ; jump to read_employee_details

		cmp eax, 2 ; option is two
		je update_employee_details ; jump to update_employee_details

		cmp eax, 3 ; option is three
		je exit ; jump to exit

		; no valid option chosen
		push invalidOption ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params
		jmp exit ; jump to exit

read_employee_details:
		push readEmployeeDetailsIntro ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params

		; prompt for department name
		push promptDepartmentName ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params

		; read input scanf("%s", &optionString);
		mov dword [optionString], optionStringReset ; reset optionString
		push optionString ; parameter 2 for scanf (push optionString pointer on the stack)
		push strFormat ; parameter 1 for scanf (pointer to string arg) 
		call scanf ; call scanf()
		add esp, 8 ; deallocate scanf params => 2 params * 4 bytes each

		; prompt for employee ID
		push promptEnterEmployeeID ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params

		; read input scanf("%d", &option);
		mov dword [option], 0 ; reset option to 0
		push option ; parameter 2 for scanf (push option pointer on the stack)
		push intFormat ; parameter 1 for scanf (pointer to string arg) 
		call scanf ; call scanf()
		add esp, 8 ; deallocate scanf params => 2 params * 4 bytes each

		push optionString ; parameter 1 for printf
		push enterResultString ; parameter 2 for printf
		call printf ; call printf
		add esp, 8 ; deallocate printf params => 2 params * 4 bytes each = 8

		push dword [option] ; parameter 1 for printf
		push enterResultInt  ; parameter 2 for printf
		call printf ; call printf
		add esp, 8 ; deallocate printf params => 2 params * 4 bytes each = 8

		; construct path ./data/{department_name}/{employee_id}.txt
		; open file
		; read file
		; ouput file
		; close file


		jmp exit ; jump to exit

update_employee_details:
		push updateEmployeeDetailsIntro ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params

		; prompt for department name
		push promptDepartmentName ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params

		; read input scanf("%s", &optionString);
		mov dword [optionString], optionStringReset
		push optionString ; parameter 2 for scanf (push optionString pointer on the stack)
		push strFormat ; parameter 1 for scanf (pointer to string arg) 
		call scanf ; call scanf()
		add esp, 8 ; deallocate scanf params => 2 params * 4 bytes each

		push promptEnterEmployeeID ; parameter 1 for printf
		call printf ; call printf
		add esp, 4 ; deallocate printf params

		; read input scanf("%d", &option);
		mov dword [option], 0 ; reset option to 0
		push option ; parameter 2 for scanf (push option pointer on the stack)
		push intFormat ; parameter 1 for scanf (pointer to string arg) 
		call scanf ; call scanf()
		add esp, 8 ; deallocate scanf params => 2 params * 4 bytes each

		push optionString ; parameter 1 for printf
		push enterResultString ; parameter 2 for printf
		call printf ; call printf
		add esp, 8 ; deallocate printf params

		push dword [option] ; parameter 1 for printf
		push enterResultInt ; parameter 2 for printf
		call printf ; call printf
		add esp, 8 ; deallocate printf params



		jmp exit ; jump to exit

exit:		; end program epilogue
		mov eax, 0 ; exit status
		mov esp, ebp ; set stack pointer to initial base pointer
		pop ebp ; restore base pointer
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