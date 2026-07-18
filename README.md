#


## Intex Syntax
instruction   dest,source

example:
```
_start:
       ...
function_name:
       ...
.local_label:
       ...
```
local_label belongs to its function

## Compile
nasm -f elf64 -o file.o file.s
ld -o program file.o
./program

## Debug
nasm -f elf64 file.s -g -F dwarf
ld file.o -o program
gdb -tui ./program
layout asm
break _start
run
focus asm
si (to move to the next line in code)
info register

## Registers
```text
       +------------------------+
       |          CPU           |
       |  +------------------+  |
       |  |    Registers     |  |
       |  +------------------+  |
       +-----------+------------+
                   |
                   | Bus (communication channel)
                   |
       +-----------v------------+
       |          RAM           |
       |      Main Memory       |
       +------------------------+
```
| Register | Purpose | Must be preserved by callee? |
|----------|---------|------------------------------|
| `rax` | Temporary register; return value register | No |
| `rbx` | Callee-saved register; optionally used as base pointer | Yes |
| `rcx` | 4th integer/pointer argument | No |
| `rdx` | 3rd integer/pointer argument; 2nd return register | No |
| `rsp` | Stack pointer | Yes |
| `rbp` | Callee-saved register; optionally used as frame pointer | Yes |
| `rsi` | 2nd integer/pointer argument | No |
| `rdi` | 1st integer/pointer argument | No |
| `r8` | 5th integer/pointer argument | No |
| `r9` | 6th integer/pointer argument | No |
| `r10` | Temporary register | No |
| `r11` | Temporary register | No |
| `r12-r15` | Callee-saved registers | Yes |
| `xmm0-xmm1` | Floating-point argument and return registers | No |
| `xmm2-xmm7` | Floating-point argument registers | No |
| `xmm8-xmm15` | Temporary SIMD registers | No |
| `mmx0-mmx7` | Temporary MMX registers | No |
| `st0-st1` | Return registers for `long double` | No |
| `st2-st7` | Temporary x87 registers | No |
| `fs` | Reserved for the system (thread-local storage) | No |
| `mxcsr` | SSE2 control and status register | Partially |
| `x87 SW` | x87 status word | No |
| `x87 CW` | x87 control word | Yes |


### Passing arguments to the function

Calling for example
`strlen( string )`
the next available register of the sequence %rdi, %rsi, %rdx, %rcx, %r8 and %r9 is used
`string` will be put in RDI

if there are more arguments than available registers -> they are put on the Stack (RAM)

### RAX

rax -> for returning value or for system calls
rax 0 = read
rax 1 = write
rax 60 = exit

### XOR

xor -> or
any number comparing with itself is 0
xor rdi, rdi = 0

### RSI, RDI

rsi -> source index
rdi -> destination index

## Links
[x64 Cheat Sheet](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf)
[Call Table for x86 64](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
[CPU Registers x86-64](https://wiki.osdev.org/CPU_Registers_x86-64)
[Guide strlen in assembly](https://dev.to/trish_07/recreating-strlen-and-strcmp-in-assembly-a-step-by-step-guide-1jjn)
[System V Application Binary Interface](https://refspecs.linuxfoundation.org/elf/x86_64-abi-0.98.pdf)
[Jcc types](https://www.felixcloutier.com/x86/jcc)

[colors code](https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124)