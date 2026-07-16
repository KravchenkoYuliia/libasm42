section     .text
global _start
_start:

mov rcx, 3
mov rbx, 5

l1:    ; decrementing rcx

    add rbx, 1
    loop l1     ; till it's not 0 make -1

    mov rax, 60     ; syscall exit
    xor rdi, rdi    ; exit code = 0
    syscall