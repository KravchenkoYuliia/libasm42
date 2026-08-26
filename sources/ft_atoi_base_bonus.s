
; TEXT SECTION ------------------------------------------------------------------------------------------
;  ------------------------------------------------------------------------------------------------------
;  ------------------------------------------------------------------------------------------------------

section		.text
global		ft_atoi_base
extern		ft_strlen
extern		ft_write
extern		strchr
extern		__errno_location
EINVAL 		equ 22

; MAIN FUNCTION -----------------------------------------------------------------------------------------
	
	; rdi = string
	; rsi = base

ft_atoi_base:

	call	check_string_is_valid
	test	rax, rax
	jz		.error

	call	check_base_is_valid
	test	rax, rax
	jz		.error

	call	get_int_from_string
	ret

.error:
	;call	__errno_location
	;mov		[rax], EINVAL
	;mov		rax, 0
	ret



; GET INT FROM STRING -----------------------------------------------------------------------------------------

	; rdi = string
	; rsi = base

get_int_from_string:

	.set_len_of_base_to_RDX:	
		push	rdi							; get len of base
		mov		rdi, rsi
		call	ft_strlen
		mov		rdx, rax					; RDX has len of base
		pop		rdi

	.init_values:
		xor		rcx, rcx					; counter for RDI
		mov		r11, 1						; default number is possitive
	
	.get_sign:
		cmp		[rdi + rcx], '+'
		je		.sign_is_plus

		cmp		[rdi + rcx], '-'
		je		.sign_is_minus

	xor		r8, r8
	.loop:
		movzx	r9, BYTE [rdi + rcx]	; current byte from RDI is in r9
		test	r9, r9
		jz		.done

		mov		rdi, rsi
		mov		rsi, r9			
		call	strchr					; call strchr( base, current_char_from_string )
										; return RAX with address of found char or NULL
		test	rax, rax
		jz		.done

		sub		rax, rdi				; rax - base -> position of current byte
		;mov		r10, rax				; r10 has current number

		;r8(result) = r8(prev result) * rdx(base length) + r10(last number that we found in base)


	.done:
		;mov		rax, r8
		ret

	.sign_is_plus:
		mov		r11, 1					; R11 has sing of the number
		inc		rcx
		jmp		.loop

	.sign_is_minus:
		mov		r11, -1
		inc		rcx
		jmp		.loop




; CHECKER IF ARGS ARE VALID ----------------------------------------------------------------------------

check_string_is_valid:
	.check_if_NULL:
		test	rdi, rdi				; test if string is not NULL
		jz		arg_is_not_valid

	.string_is_valid:
		mov		rax, 1
		ret


check_base_is_valid:
	.check_if_NULL:
		test	rsi, rsi
		jz		arg_is_not_valid

	.check_if_not_enough_chars:
		push	rdi						; string is at the top of the stack, base is in rsi
		mov		rdi, rsi
		call	ft_strlen
		cmp		rax, 1
		pop		rdi
		jbe		arg_is_not_valid

	.check_if_chars_not_allowed:
		push	rdi						; string is at the stack, base is in rsi	1 time action before loop
		mov		rdi, rsi				; string is at the stack, base is in rdi	1 time action before loop
		xor		ecx, ecx				; initialize to 0, ecx is 32 bits from rcx

		.loop_check_not_allowed:
			movzx	esi, BYTE [forbidden_chars_for_base + ecx]	; put one byte to rsi
															; (esi is 32 bits from rsi, because strchr has int as 
															; second parameter)
			test	esi, esi
			jz		.check_duplicates

			call	strchr
			test	rax, rax
			jnz		.error_char_not_allowed
			inc		rcx
			jmp		.loop_check_not_allowed
		;.end_loop:
		;	mov		rsi, rdi				; string is at the stack, base is back to rsi
		;	pop		rdi						; string is back to rdi, base is in rsi

	.check_duplicates:
		push	rdi							; save base to the stack
		xor		rcx, rcx
		.loop_duplicates:
			movzx		esi, BYTE [rdi + rcx]	; take current char from rdi
			test		esi, esi
			jz			.no_duplicates_found	; base is finished

			lea		rdx, [rdi + rcx + 1]

			push	rcx
			push	rdi
			mov		rdi, rdx
			call	strchr
			pop 	rdi
			pop		rcx

			test	rax, rax
			jnz		.error_duplicate_found					; duplicate found
			inc		rcx
			jmp		.loop_duplicates

		.no_duplicates_found:
			pop		rsi
			pop		rdi
	
	.base_is_valid:
		mov		rax, 1
		ret

	.error_char_not_allowed:
		pop		rdi
		mov		rax, 0
		ret

	.error_duplicate_found:
		pop		rsi
		pop		rdi
		mov		rax, 0
		ret


arg_is_not_valid:
	mov		rax, 0
	ret


; DATA SECTION ------------------------------------------------------------------------------------------
;  ------------------------------------------------------------------------------------------------------
;  ------------------------------------------------------------------------------------------------------

section		.data

forbidden_chars_for_base:
	db		'+', '-', 9, 10, 11, 12, 13, 32, 0
	; 0 = '\0'  |  9-13 different tabs, new line  |  32 = space 