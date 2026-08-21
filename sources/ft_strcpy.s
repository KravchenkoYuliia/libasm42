section .text
global 	ft_strcpy

ft_strcpy:
	; rdi -> dest
	; rsi -> source

	xor rcx, rcx
	test rsi, rsi
	jz .rsi_is_null

	mov rax, rdi

.loop:
	mov dl, BYTE [rsi]	; dl is the least significant 8 bits of ax
	mov [rdi], dl

	inc rdi 	; move pointer to the next elem
	inc rsi

	test dl, dl
	jz .done

	jmp .loop

.done:
	ret

.rsi_is_null:
	mov rax, 0
	ret