section		.text
global		ft_list_push_front
extern		malloc
extern		__errno_location

; rdi = t_list** list
; rsi = void* data
; Quadword = 8 bytes

ft_list_push_front:
	test	rdi, rdi
	jz		.error_in_args

	push	rdi						; address of the head list is on the stack (**list)
	push	rsi						; data that we need to put to first node is on the stack 
									; because malloc call will modify it

	mov		rdi, 16					; 8 bytes for void* data
									; 8 bytes for struct t_list* next
	call	malloc
	test	rax, rax
	jz		.malloc_failed

	pop		rsi
	mov		[rax + 0], rsi			; put void* data to the mallocked memory -> struct with offset 0

	pop		rdi
	mov		r8, [rdi]
	mov		[rax + 8], r8			; put the ex-head's address to the new struct's next -> offset 8

	mov		[rdi], rax				; put new struct as head of the list

	.end_of_function:
		ret

	.malloc_failed:
		pop		rsi
		pop		rdi
		ret

	.error_in_args:
	call	__errno_location
	ret