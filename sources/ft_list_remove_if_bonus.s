section		.text
extern		ft_list_remove_if
extern		__errno_location
extern		free

EINVAL equ 22					; 22 errno code = invalid argument

; rdi = t_list** begin_list
; rsi = void* data_ref
; rdx = cmp_function
; rcx = free_data_function 


ft_list_remove_if:

	test	rdi, rdi
	jz		.error_in_args

	mov		r11, rdi					; store the address of list
	push	r11

	mov		rdi, [rdi]					; rdi has first node address
	test	rdi, rdi
	jz		.error_in_args

	xor		r8, r8						; r8 = prev
	
	.loop:
		push	rdi						; the address of the current node is on the stack
		mov		rdi, [rdi]				; first arg for cmp_function is current node's data
										; rsi already has data_ref

		push	rsi
		push	rdx
		push	rcx
		push	r8

		call	rdx						; cmp_function
		
		pop		r8
		pop		rcx
		pop		rdx
		pop		rsi

		test	rax, rax
		jz		.data_match

		pop		rdi
		mov		r8, rdi					; save current node in r8( prev ) before going to the next one

		mov		rdi, [rdi + 8]			; list = list->next
		test	rdi, rdi
		jz		.done

		jmp		.loop

	.done:
		pop		r11
		ret

	.data_match:
		pop		rdi
		push	rdi
		mov		rdi, [rdi]

		push	rsi
		push	rdx
		push	rcx
		push	r8

		call	rcx						; free_data_function

		pop		r8
		pop		rcx
		pop		rdx
		pop		rsi
		pop		rdi

		mov		r9, [rdi + 8]			; list = list->next

		test	r8, r8
		jz		.change_head_of_list

		mov		[r8 + 8], r9			; prev is pointing to rdi->next

	.delete_current_node:
		push	rsi
		push	rdx
		push	rcx
		push	r8
		push	r9

		call	free

		pop		r9
		pop		r8
		pop		rcx
		pop		rdx
		pop		rsi

		mov		rdi, r9
		test	rdi, rdi
		jz		.done
		
		jmp		.loop

	.change_head_of_list:
		pop		r11
		mov		[r11], r9
		push	r11
		
		jmp		.delete_current_node

	.error_in_args:
		call	__errno_location
		mov		[rax], EINVAL
		ret