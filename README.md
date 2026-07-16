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

### RAX

rax -> for system calls
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
