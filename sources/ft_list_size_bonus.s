section		.text
global ft_list_size

MAX_UINT equ 4294967295

ft_list_size:

	xor		rcx, rcx

	test	rdi, rdi
	jz		.done

	inc		rcx
	.loop:
		mov		rdx, [rdi + 8]
		test	rdx, rdx
		jz		.done

		mov		rdi, rdx
		test	rcx, MAX_UINT
		je		.list_too_large
		inc		rcx
		jmp		.loop
		
	.done:
		mov		rax, rcx
		ret

	.list_too_large:
		mov		rax, 0
		ret