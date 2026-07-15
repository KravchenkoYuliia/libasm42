Intex Syntax

instr   dest,source




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