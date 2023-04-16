	.file	"agePrompt.c"
	.text
	.section	.rodata
.LC2:
	.string	"%s"
.LC3:
	.string	"%d"
	.align 4
.LC4:
	.string	"Name: %s\nAge: %d\nYear of birth: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	subl	$80, %esp
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	movdqa	.LC0@GOTOFF(%ebx), %xmm0
	movups	%xmm0, -61(%ebp)
	movl	$663610, -46(%ebp)
	movdqa	.LC1@GOTOFF(%ebx), %xmm0
	movups	%xmm0, -78(%ebp)
	movb	$0, -62(%ebp)
	movl	$2023, -84(%ebp)
	subl	$8, %esp
	leal	-61(%ebp), %eax
	pushl	%eax
	leal	.LC2@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	movl	stdin@GOT(%ebx), %eax
	movl	(%eax), %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$30
	leal	-42(%ebp), %eax
	pushl	%eax
	call	fgets@PLT
	addl	$16, %esp
	subl	$8, %esp
	leal	-78(%ebp), %eax
	pushl	%eax
	leal	.LC2@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	subl	$8, %esp
	leal	-88(%ebp), %eax
	pushl	%eax
	leal	.LC3@GOTOFF(%ebx), %eax
	pushl	%eax
	call	__isoc99_scanf@PLT
	addl	$16, %esp
	movl	-88(%ebp), %eax
	movl	-84(%ebp), %edx
	subl	%eax, %edx
	movl	-88(%ebp), %eax
	pushl	%edx
	pushl	%eax
	leal	-42(%ebp), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	movl	$0, %eax
	movl	-12(%ebp), %edx
	subl	%gs:20, %edx
	je	.L3
	call	__stack_chk_fail_local
.L3:
	leal	-8(%ebp), %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 16
.LC0:
	.long	1702129221
	.long	1870209138
	.long	1847620213
	.long	979725665
	.align 16
.LC1:
	.long	1702129221
	.long	1870209138
	.long	1629516405
	.long	169895271
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB1:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE1:
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (GNU) 12.2.1 20230201"
	.section	.note.GNU-stack,"",@progbits
