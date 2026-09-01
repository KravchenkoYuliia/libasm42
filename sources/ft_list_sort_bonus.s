section		.text
global		ft_list_sort
extern		ft_strcmp

; rdi = t_list **begin_list ---> save it in r10
; rsi = int (*cmp)( const char*, const char* ) ---> save it in r11


ft_list_sort:

	mov		r10, rdi
	mov		r11, rsi

	mov		rdi, [rdi]
	
	.check_if_sorted:
		mov		rdi, [r10]
		mov		rsi, r11

		call	check_if_list_sorted
		test	rax, rax
		jz		.sort

	.done:
		ret

	.sort:
		mov		rdi, [r10]
		;mov		rsi, r11
		xor		r8, r8					; r8 = prev node, NULL if current node is first node

	.loop:
		;mov		r8, [rdi]		; left node's data
		mov		rdx, rdi		; left node's address
		
		mov		rdi, [rdi + 8]	; list->next
		test	rdi, rdi
		jz		.check_if_sorted
		
		;mov		r9, [rdi]		; right node's data
		
								; rdx has left node address
								; rdi has right node address
		push	rdi				; current node's address is on the stack (right)
		push 	rdx				; left node's address is on the stack
		
		mov		rsi, [rdi]			; second arg for ft_strcmp
		mov		rdi, [rdx]			; first arg for ft_strcmp

		call	ft_strcmp
		ja		.swap_nodes
		pop		rdx
		pop		rdi
		mov		r8, rdx
		jmp		.loop

	.swap_nodes:
		pop		rdx		
		pop		rdi
		mov		rcx, [rdi + 8]				; temp node point to right node's next
		mov		[rdi  + 8], rdx				; right node's next points to left node
		mov		[rdx + 8], rcx				; left node's next point to temp node
		test	r8, r8
		jz		.change_head_of_list

		mov		[r8 + 8], rdi
		jmp		.check_if_sorted
		
		.change_head_of_list:
			mov		[r10], rdi
			jmp		.check_if_sorted
		



	;	check pairs
	;	list->next
	;	if list is NULL ---> .check_if_list_sorted


;p (char*) $rdi
; CHECK IF LIST IS SORTED -----------------------------------------------------------------------------------------

check_if_list_sorted:
	
	.loop:
		mov		r8, [rdi]		; data from first node is in r8

		mov		rdi, [rdi + 8]	; put second node to rdi
		test	rdi, rdi
		jz		.sorted
		
		mov		r9, [rdi]		; data from second node is in r9
	
		push	rdi				; current node is on the stack

		mov		rdi, r8			; first arg for ft_strcmp
		mov		rsi, r9			; second arg for ft_strcmp

		call	ft_strcmp
		ja		.not_sorted

		pop		rdi
		jmp		.loop

	.sorted:
		mov		rax, 1
		ret

	.not_sorted:
		pop		rdi
		mov		rax, 0
		ret