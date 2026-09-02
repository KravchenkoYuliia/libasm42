section		.text
extern		ft_list_remove_if

; rdi = t_list** begin_list
; rsi = void* data_ref
; rdx = cmp_function
; rcx = free_data_function 


ft_list_remove_if:

	mov		r11, rdi					; store the address of list

	mov		rdi, [rdi]					; rdi has first node address
	.loop:
		push	rdi						; the address of the current node is on the stack
		mov		rdi, [rdi]				; first arg for cmp_function is current node's data
										; rsi already has data_ref

		push	rsi
		push	rdx
		push	rcx

		call	rdx						; cmp_function
		
		pop		rcx
		pop		rdx
		pop		rsi

		test	rax, rax
		jz		.data_match

		pop		rdi
		mov		rdi, [rdi + 8]			; list = list->next
		test	rdi, rdi
		jz		.done

		jmp		.loop

	.done:
		ret

	.data_match:
		pop		rdi
		push	rdi
		mov		rdi, [rdi]

		push	rsi
		push	rdx
		push	rcx

		call	rcx						; free_data_function

		pop		rcx
		pop		rdx
		pop		rsi

		pop		rdi
		
		; temp line
		mov dword [rdi], 0
		
		mov		rdi, [rdi + 8]			; list = list->next
		test	rdi, rdi
		jz		.done

		jmp		.loop