; compile with: nasm -felf64 programa-nasm64.asm && ld programa-nasm64.o
; 64-bit linux only
global _start
section .text
_start:
	mov rsi, CTE_STR_0 ; value=Hola mundo
	mov rdx, 11 ; msg length + newline
	mov rax, 1 ; sys_write
	mov rdi, 1 ; fd=stdout
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
