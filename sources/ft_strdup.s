
section	.text
global	ft_strdup
extern	ft_strlen
extern	ft_strcpy
extern	malloc
extern __errno_location

EINVAL equ 22					; 22 errno code = invalid argument

ft_strdup:

	test	rdi, rdi
	jz		.string_is_null

	call	ft_strlen			; rax has the length of the given string

	push	rdi					; put char* string to stack to save it for later
	
	mov		rdi, rax			; rdi has length now
	add		rdi, 1
	call	malloc
	test	rax, rax
	jz		.malloc_failed

	mov		rdi, rax			; pointer to the allocated memory
	pop		rsi
	call	ft_strcpy

	ret

.string_is_null:
	call	__errno_location
	mov		[rax], EINVAL
	mov		rax, 0
	ret

.malloc_failed:
		ret
