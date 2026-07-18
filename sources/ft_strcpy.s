section .text
global ft_strcpy

ft_strcpy:
	; rdi -> dest
	; rsi -> source

	xor rcx, rcx
	test rsi, rsi
	jz .rsi_is_null

	mov rax, rdi

.loop:
	mov al, [rsi]
	jz .done
	
	mov [rdi], al
	inc rdi
	inc rsi

	jmp .loop

.done:
	ret

.rsi_is_null:
	mov rax, 0
	ret