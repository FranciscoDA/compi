; compile with: nasm -felf64 filename.asm && ld filename.o
; 64-bit linux only
global _start
section .text
_start:
	mov rax, 1 ; sys_write
	mov rdi, 1 ; fd=stdout
	mov rsi, CTE_STR_6 ; value=Hola mundo
	mov rdx, 11 ; msg length + newline
	syscall
	fild CTE_INT_0 ; value=0
	fild VAR_CONTADOR
	fild CTE_INT_4 ; value=999
	fld VAR_ACTUAL
	fild CTE_INT_2 ; value=2
	fild VAR_SUMA
	fild VAR_CONTADOR
	fild CTE_INT_1 ; value=1
	fadd
	fild VAR_CONTADOR
	LABEL_0:
	fild VAR_CONTADOR
	fild CTE_INT_5 ; value=92
	cmp
	jg LABEL_1
	fild VAR_CONTADOR
	fild CTE_INT_1 ; value=1
	fadd
	fild VAR_CONTADOR
	fild VAR_CONTADOR
	fld CTE_FLT_4 ; value=0.342
	fdiv
	fild VAR_CONTADOR
	fild VAR_CONTADOR
	fmul
	fadd
	fld VAR_ACTUAL
	fild VAR_SUMA
	fld VAR_ACTUAL
	fadd
	fild VAR_SUMA
	jmp LABEL_0
	LABEL_1:
	fld VAR_ACTUAL
	fild CTE_INT_2 ; value=2
	cmp
	jle LABEL_2
	mov rax, 1 ; sys_write
	mov rdi, 1 ; fd=stdout
	mov rsi, CTE_STR_2 ; value=2 > 3
	mov rdx, 6 ; msg length + newline
	syscall
	LABEL_2:
	fld VAR_ACTUAL
	fild CTE_INT_3 ; value=3
	cmp
	jge LABEL_8
	fld VAR_ACTUAL
	fld CTE_FLT_1 ; value=99999.99
	cmp
	je LABEL_3
	mov rax, 1 ; sys_write
	mov rdi, 1 ; fd=stdout
	mov rsi, CTE_STR_4 ; value=SOY TRUE
	mov rdx, 9 ; msg length + newline
	syscall
	LABEL_3:
	fld VAR_ACTUAL
	fld CTE_FLT_0 ; value=99.0
	cmp
	jg LABEL_4
	mov rax, 1 ; sys_write
	mov rdi, 1 ; fd=stdout
	mov rsi, CTE_STR_5 ; value=SOY FALSE
	mov rdx, 10 ; msg length + newline
	syscall
	LABEL_4:
	fld VAR_ACTUAL
	fld CTE_FLT_3 ; value=0.9999
	cmp
	je LABEL_5
	mov rax, 1 ; sys_write
	mov rdi, 1 ; fd=stdout
	mov rsi, CTE_STR_1 ; value=@sdADaSjfla%dfg
	mov rdx, 16 ; msg length + newline
	syscall
	LABEL_5:
	fld VAR_ACTUAL
	fild CTE_INT_3 ; value=3
	cmp
	jne LABEL_6
	mov rax, 1 ; sys_write
	mov rdi, 1 ; fd=stdout
	mov rsi, CTE_STR_0 ; value=asldk fh sjf
	mov rdx, 13 ; msg length + newline
	syscall
	LABEL_6:
	fld VAR_ACTUAL
	fild CTE_INT_6 ; value=31
	cmp
	je LABEL_7
	mov rax, 1 ; sys_write
	mov rdi, 1 ; fd=stdout
	mov rsi, CTE_STR_3 ; value=asd
	mov rdx, 4 ; msg length + newline
	syscall
	LABEL_7:
	jmp LABEL_9
	LABEL_8:
	fld CTE_FLT_2 ; value=333.3333
	fld VAR_ACTUAL
	LABEL_9:
	fld VAR_ACTUAL
	fld VAR_ACTUAL
	fadd
	fld VAR_ACTUAL
	fld VAR_ACTUAL
	fmul
	fadd
	fild VAR_CX
	fadd
	fld VAR_RESULT
	mov eax, 60 ; sys_exit
	xor rdi, rdi ; code = 0
	syscall
CTE_INT_0:
	dw 0
CTE_INT_1:
	dw 1
CTE_INT_2:
	dw 2
CTE_INT_3:
	dw 3
CTE_INT_4:
	dw 999
CTE_INT_5:
	dw 92
CTE_INT_6:
	dw 31
CTE_FLT_0:
	dd 99.0
CTE_FLT_1:
	dd 99999.99
CTE_FLT_2:
	dd 333.3333
CTE_FLT_3:
	dd 0.9999
CTE_FLT_4:
	dd 0.342
CTE_STR_0:
	db "asldk fh sjf", 10
CTE_STR_1:
	db "@sdADaSjfla%dfg", 10
CTE_STR_2:
	db "2 > 3", 10
CTE_STR_3:
	db "asd", 10
CTE_STR_4:
	db "SOY TRUE", 10
CTE_STR_5:
	db "SOY FALSE", 10
CTE_STR_6:
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
