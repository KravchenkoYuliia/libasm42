
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

ft_atoi_base:
	; rdi = string
	; rsi = base

	call	check_string_is_valid
	test	rax, rax
	jz		.error

	call	check_base_is_valid
	test	rax, rax
	jz		.error

.done:
	mov		rax, 1
	ret

.error:
	call	__errno_location
	mov		[rax], EINVAL
	mov		rax, 0
	ret


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

	.loop:
		movzx	esi, BYTE [forbidden_chars_for_base + ecx]	; put one byte to rsi
														; (esi is 32 bits from rsi, because strchr has int as 
														; second parameter)
		test	esi, esi
		jz		.end_loop

		call	strchr
		test	rax, rax
		jnz		.base_error_char_not_allowed
		inc		rcx
		jmp		.loop
	.end_loop:
		mov		rsi, rdi				; string is at the stack, base is back to rsi
		pop		rdi						; string is back to rdi, base is in rsi

.check_duplicates:


.base_is_valid:
	mov		rax, 1
	ret

.base_error_char_not_allowed:
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