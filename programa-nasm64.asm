; compile with: nasm -felf64 programa-nasm64.asm && ld programa-nasm64.o
; 64-bit linux only
global _start
section .text
%include "numbers-nasm.asm"
_start:
	mov ecx, CTE_STR_3 ; value=Hola mundo
	mov edx, 10 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_0] ; value=0
	fistp word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	fistp word [VAR_FIB_A]
	fild word [CTE_INT_0] ; value=0
	fistp word [VAR_FIB_B]
	LABEL_0:
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_2] ; value=5
	fcompp
	fstsw ax
	test ax, 0000000100000000b ; c0
	jnz LABEL_1
	test ax, 0100000000000000b ; c3
	jnz LABEL_1
	fild word [VAR_FIB_A]
	fild word [VAR_FIB_B]
	faddp
	fistp word [VAR_FIB_A]
	fild word [VAR_FIB_A]
	fild word [VAR_FIB_B]
	fsubp
	fistp word [VAR_FIB_B]
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	faddp
	fistp word [VAR_CONTADOR]
	jmp LABEL_0
	LABEL_1:
	mov ecx, CTE_STR_0 ; value=FIB(
	mov edx, 4 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	faddp
	itoa 14, BUFFER_CONVERSION
	mov ecx, BUFFER_CONVERSION
	mov edx, edi
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_1 ; value=) = 
	mov edx, 4 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [VAR_FIB_A]
	itoa 14, BUFFER_CONVERSION
	mov ecx, BUFFER_CONVERSION
	mov edx, edi
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_2 ; value=Fin
	mov edx, 3 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov eax, 0x1 ; sys_exit
	xor ebx, ebx ; code = 0
	int 0x80
CTE_INT_0:
	dw 0
CTE_INT_1:
	dw 1
CTE_INT_2:
	dw 5
CTE_STR_0:
	db "FIB("
CTE_STR_1:
	db ") = "
CTE_STR_2:
	db "Fin"
CTE_STR_3:
	db "Hola mundo"
CTE_ESPECIAL_LF:
	db 10
section .bss
VAR_CONTADOR:
	resw 1
VAR_FIB_A:
	resw 1
VAR_FIB_B:
	resw 1
BUFFER_CONVERSION:
	resb 15
