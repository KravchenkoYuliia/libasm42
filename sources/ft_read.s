section	.text
global	ft_read
extern __errno_location

ft_read:
	mov		rax, 0
	syscall

	cmp		rax, -4095
	jae		.error

	ret

.error:
	neg		rax
	push	rax

	call	__errno_location

	pop		rcx
	mov		[rax], ecx
	
	mov		rax, -1
	ret