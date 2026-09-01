section		.text
global		ft_list_sort
extern		ft_strcmp

; rdi = t_list **begin_list ---> save it in r10
; rsi = int (*cmp)( const char*, const char* ) ---> save it in r11


ft_list_sort:

	mov		r10, rdi
	mov		r11, rsi

	mov		rdi, [rdi]
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



; CHECK IF LIST IS SORTED -----------------------------------------------------------------------------------------

check_if_list_sorted:
	
	.loop:
		mov		r8, [rdi]		; data from first node is in r8

		mov		rdi, [rdi + 8]	; put second node to rdi
		test	rdi, rdi
		jz		.sorted
		
		mov		r9, [rdi]		; data from second node is in r9
	
		push	rdi				; second node is on the stack

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