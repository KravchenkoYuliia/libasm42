	.file	"strlen.c"
	.intel_syntax noprefix
	.text
	.globl	ft_strlen
	.type	ft_strlen, @function
ft_strlen:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-4], 0
	cmp	QWORD PTR [rbp-24], 0
	jne	.L4
	mov	eax, 0
	jmp	.L3
.L5:
	add	DWORD PTR [rbp-4], 1
.L4:
	mov	eax, DWORD PTR [rbp-4]
	movsxd	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L5
	mov	eax, DWORD PTR [rbp-4]
	cdqe
.L3:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	ft_strlen, .-ft_strlen
	.section	.rodata
.LC0:
	.string	"hello"
.LC1:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	edi, OFFSET FLAT:.LC0
	call	ft_strlen
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	mov	eax, 0
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.1 20260123 (Red Hat 15.2.1-7)"
	.section	.note.GNU-stack,"",@progbits
