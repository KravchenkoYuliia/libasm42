;	ssize_t		write( int fd, const void buf[.count], size_t count );
;	fd = rdi
;	buf = rsi
;	count = rdx


section	.text
global	ft_write

ft_write:

	mov		rax, 1		; 1 = sys_write, syscall will ask rax what it needs to do
						; all other information is already passed in args - rdi, rsi. rdx
	syscall
	ret