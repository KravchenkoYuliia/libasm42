;64-bits program

section .text
global _start
_start:

    mov     rax, 3
    mov     rbx, 4
    add     rax, rbx

    mov     eax, 60     ; sys exit to tell the program to not go further
    xor     edi, edi
    syscall