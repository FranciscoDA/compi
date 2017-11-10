; compile with: nasm -felf32 programa-nasm32.asm && ld programa-nasm32.o
; 32-bit linux only
global _start
section .text
%include "numbers-nasm.asm"
_start:
	mov ecx, CTE_STR_7 ; value=Prueba 1 (Enteros):
	mov edx, 19 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_11 ; value=-------------------
	mov edx, 19 ; msg length
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
	fild word [CTE_INT_5] ; value=10
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
	mov ecx, CTE_STR_2 ; value=FIB(
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
	mov ecx, CTE_STR_3 ; value=) = 
	mov edx, 4 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [VAR_FIB_B]
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
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	faddp
	fistp word [VAR_CONTADOR]
	jmp LABEL_0
	LABEL_1:
	mov ecx, CTE_STR_0 ; value=
	mov edx, 0 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_9 ; value=Prueba 2 (Reales):
	mov edx, 18 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_12 ; value=------------------
	mov edx, 18 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_0] ; value=3.1415927
	fstp dword [VAR_PI]
	fild word [CTE_INT_4] ; value=5
	fstp dword [VAR_DIAMETRO]
	mov ecx, CTE_STR_10 ; value=Diametro: 
	mov edx, 10 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_DIAMETRO]
	ftoa 14, BUFFER_CONVERSION, 4
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
	mov ecx, CTE_STR_8 ; value=Radio: 
	mov edx, 7 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_DIAMETRO]
	fild word [CTE_INT_2] ; value=2
	fdivp
	ftoa 14, BUFFER_CONVERSION, 4
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
	mov ecx, CTE_STR_4 ; value=Circunferencia: 
	mov edx, 16 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_PI]
	fld dword [VAR_DIAMETRO]
	fmulp
	ftoa 14, BUFFER_CONVERSION, 4
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
	mov ecx, CTE_STR_6 ; value=Area: 
	mov edx, 6 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_PI]
	fld dword [VAR_DIAMETRO]
	fmulp
	fld dword [VAR_DIAMETRO]
	fmulp
	fild word [CTE_INT_3] ; value=4
	fdivp
	ftoa 14, BUFFER_CONVERSION, 4
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
	mov ecx, CTE_STR_0 ; value=
	mov edx, 0 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_5 ; value=Prueba 3 (Negativos):
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_1 ; value=---------------------
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_4] ; value=5
	fsubp
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
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_4] ; value=5
	fsubp
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_2] ; value=2
	fsubp
	fmulp
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_1] ; value=1
	fsubp
	fmulp
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
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_4] ; value=5
	fsubp
	fild word [CTE_INT_5] ; value=10
	fmulp
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
	mov eax, 0x1 ; sys_exit
	xor ebx, ebx ; code = 0
	int 0x80
CTE_INT_0:
	dw 0
CTE_INT_1:
	dw 1
CTE_INT_2:
	dw 2
CTE_INT_3:
	dw 4
CTE_INT_4:
	dw 5
CTE_INT_5:
	dw 10
CTE_FLT_0:
	dd 3.1415927
CTE_STR_0:
	db ""
CTE_STR_1:
	db "---------------------"
CTE_STR_2:
	db "FIB("
CTE_STR_3:
	db ") = "
CTE_STR_4:
	db "Circunferencia: "
CTE_STR_5:
	db "Prueba 3 (Negativos):"
CTE_STR_6:
	db "Area: "
CTE_STR_7:
	db "Prueba 1 (Enteros):"
CTE_STR_8:
	db "Radio: "
CTE_STR_9:
	db "Prueba 2 (Reales):"
CTE_STR_10:
	db "Diametro: "
CTE_STR_11:
	db "-------------------"
CTE_STR_12:
	db "------------------"
CTE_ESPECIAL_LF:
	db 10
section .bss
VAR_PI:
	resd 1
VAR_DIAMETRO:
	resd 1
VAR_CONTADOR:
	resw 1
VAR_FIB_A:
	resw 1
VAR_FIB_B:
	resw 1
BUFFER_CONVERSION:
	resb 15
