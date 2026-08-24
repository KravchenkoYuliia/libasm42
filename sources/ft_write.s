;	ssize_t		write( int fd, const void buf[.count], size_t count );
;	fd = rdi
;	buf = rsi
;	count = rdx


section	.text
global	ft_write
extern	__errno_location

ft_write:

	mov		rax, 1		; 1 = sys_write, syscall will ask rax what it needs to do
						; all other information is already passed in args - rdi, rsi. rdx
	syscall

	cmp		rax, -4095	;
	jae		.error		; jump if above or equal to 18446744073709547521 -> unsigned version of signed -4095
	
	ret

.error:
	neg		rax								; in case of error rax has a negative number, need to make it positive to set it as an errno
	push	rax								; put the value to the top of the stack RSP

	call	__errno_location 				; return the address of the current's thread errno variable

	pop		rcx
	mov		[rax], ecx

	mov		rax, -1
	ret