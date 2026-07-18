
section .text
global ft_strlen

ft_strlen:
    xor rcx, rcx
    test rdi, rdi ; bitwise AND
	jz .rdi_is_null

.loop:
	cmp byte [rdi + rcx], 0
	je .done ;jump if equal
	inc rcx
	jmp .loop

.done:
	mov rax, rcx
	ret

.rdi_is_null
	xor rax, rax
	ret