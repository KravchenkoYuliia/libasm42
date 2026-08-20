section .text
global ft_strcmp

ft_strcmp:

	; rdi is first string
	; rsi is second string

.loop:
	mov		al, [rdi]
	mov		dl, [rsi]

	cmp		al, dl
	ja		.first_is_above
	jb		.first_is_below

	test	al, dl
	jz		.strings_are_finished
	
	inc		rdi
	inc		rsi

	jmp		.loop

.strings_are_finished:
	mov 	rax, 0
	ret

.first_is_above:
	mov		rax, 1
	ret

.first_is_below:
	mov		rax, -1
	ret