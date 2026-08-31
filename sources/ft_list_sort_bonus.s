section		.text
global		ft_list_sort
extern		ft_strcmp

; rdi = t_list **begin_list
; rsi = int (*cmp)( const char*, const char* )


ft_list_sort:

	;push	rsi
	;push	rdi

	call	check_if_list_sorted
	test	rax, rax
	jz		.sort
		
	.done
		mov		rax, 1
		ret

	.sort:
		mov		rax, 0
		ret

	;	check pairs
	;	list->next
	;	if list is NULL ---> .check_if_list_sorted


check_if_list_sorted:
		mov		rdx, [rdi]		; put first node to rdx
		mov		r8, [rdx]		; data from first node is in r8

		mov		rdi, [rdx + 8]	; put second node to rdi
		test	rdi, rdi
		jz		.sorted
		
		mov		r9, [rdi]		; data from second node is in r9
	
		push	rdi				; second node is on the stack

		mov		rdi, r8			; first arg for ft_strcmp
		mov		rsi, r9			; second arg for ft_strcmp

		call	ft_strcmp
		ja		.not_sorted

		pop		rdi

		.sorted:
			mov		rax, 1
			ret

		.not_sorted:
			pop		rdi
			mov		rax, 0
			ret