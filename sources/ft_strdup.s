
extern	ft_strlen
extern	ft_strcpy
extern	malloc
global	ft_strdup

section	.text

ft_strdup:

	call	ft_strlen		; rax has the length of the given string

	push	rdi				; put char* string to stack to save it for later
	
	mov		rdi, rax		; rdi has length now
	add		rdi, 1
	call	malloc

	mov		rdi, rax		; pointer to the allocated memory
	pop		rsi
	call	ft_strcpy

	ret