section     .text

global _start
_start:

    mov     edx, len
    mov     ecx, msg
    mov     ebx, 1      ; file descriptor output
    mov     eax, 4      ; sys call for printing in x86, 4 = write
    int     0x80       ; int = interrupt to stop the process
                        ; 0x80 = Kernel
    mov     eax, 1      ; eax, 1 = exit sys call
    int     0x80

section     .data
    msg     db "Hello World", 0xa       ; db = define byte
                                        ; 0xa = hexa character for creating a new line(\n)
    len     equ $ -msg  ; $ = pointer
                        ; equ = equals
