; compile with: nasm -felf32 programa-nasm32.asm && ld programa-nasm32.o
; 32-bit linux only
global _start
section .text
_start:
	mov ecx, CTE_STR_0 ; value=Hola mundo
	mov edx, 11 ; msg length + newline
	mov eax, 1 ; sys_write
	mov ebx, 1 ; fd=stdout
	syscall
	mov eax, 60 ; sys_exit
	xor rdi, rdi ; code = 0
	syscall
CTE_STR_0:
	db "Hola mundo", 10
section .bss
VAR_SUMA:
	resw 1
VAR_ASD:
	resb 4
VAR_DX:
	resw 1
VAR_CX:
	resw 1
VAR_BX:
	resb 4
VAR_AX:
	resw 1
VAR_CONTADOR:
	resw 1
VAR_PROMEDIO:
	resw 1
VAR_ACTUAL:
	resb 4
VAR_RESULT:
	resb 4
