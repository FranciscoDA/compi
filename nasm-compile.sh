nasm -felf32 -o gen/nasm-programa.o gen/nasm-programa.asm
ld -melf_i386 -o gen/nasm-exe gen/nasm-programa.o
chmod ug+rwx gen/nasm-exe
