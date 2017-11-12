; compile with: nasm -felf64 programa-nasm64.asm && ld programa-nasm64.o
; 64-bit linux only
global _start
section .text
%include "macros/nasm.asm"
_start:
	mov ecx, CTE_STR_0 ; value=Prueba 1 (Fibonacci):
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_19 ; value=---------------------
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
	fistp word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	fistp word [VAR_FIB_A]
	fild word [CTE_INT_0] ; value=0
	fistp word [VAR_FIB_B]
	LABEL_0:
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_4] ; value=10
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
	mov ecx, CTE_STR_8 ; value=FIB(
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
	mov ecx, CTE_STR_9 ; value=) = 
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
	mov ecx, CTE_STR_1 ; value=
	mov edx, 0 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_14 ; value=Prueba 2 (Circunferencia):
	mov edx, 26 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_11 ; value=--------------------------
	mov edx, 26 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_2] ; value=3.1415927
	fstp dword [VAR_PI]
	fild word [CTE_INT_3] ; value=5
	fstp dword [VAR_DIAMETRO]
	mov ecx, CTE_STR_29 ; value=Diametro: 
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
	mov ecx, CTE_STR_27 ; value=Radio: 
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
	mov ecx, CTE_STR_24 ; value=Circunferencia: 
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
	mov ecx, CTE_STR_25 ; value=Area: 
	mov edx, 6 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_PI]
	fld dword [VAR_DIAMETRO]
	fmulp
	fild word [CTE_INT_2] ; value=2
	fdivp
	fld dword [VAR_DIAMETRO]
	fmulp
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
	mov ecx, CTE_STR_1 ; value=
	mov edx, 0 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_13 ; value=Prueba 3 (Nro. de Euler):
	mov edx, 25 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_21 ; value=-------------------------
	mov edx, 25 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_1] ; value=1
	fistp word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	fstp dword [VAR_e]
	LABEL_4:
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_4] ; value=10
	fcompp
	fstsw ax
	test ax, 0000000100000000b ; c0
	jnz LABEL_5
	fld dword [CTE_FLT_0] ; value=1.0
	fstp dword [VAR_termino]
	fild word [CTE_INT_1] ; value=1
	fistp word [VAR_CONTADOR2]
	LABEL_2:
	fild word [VAR_CONTADOR2]
	fild word [VAR_CONTADOR]
	fcompp
	fstsw ax
	test ax, 0000000100000000b ; c0
	jnz LABEL_3
	fld dword [VAR_termino]
	fild word [VAR_CONTADOR2]
	fdivp
	fstp dword [VAR_termino]
	fild word [VAR_CONTADOR2]
	fild word [CTE_INT_1] ; value=1
	faddp
	fistp word [VAR_CONTADOR2]
	jmp LABEL_2
	LABEL_3:
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	faddp
	fistp word [VAR_CONTADOR]
	fld dword [VAR_e]
	fld dword [VAR_termino]
	faddp
	fstp dword [VAR_e]
	jmp LABEL_4
	LABEL_5:
	mov ecx, CTE_STR_22 ; value=e (
	mov edx, 3 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [VAR_CONTADOR]
	itoa 14, BUFFER_CONVERSION
	mov ecx, BUFFER_CONVERSION
	mov edx, edi
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_7 ; value= terminos): 
	mov edx, 12 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_e]
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
	mov ecx, CTE_STR_1 ; value=
	mov edx, 0 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_10 ; value=Prueba 4 (Negativos):
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_19 ; value=---------------------
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_26 ; value=Simple: 
	mov edx, 8 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_3] ; value=5
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
	mov ecx, CTE_STR_15 ; value=Neg x Neg x Neg: 
	mov edx, 17 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_3] ; value=5
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
	mov ecx, CTE_STR_28 ; value=Neg x Pos: 
	mov edx, 11 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_3] ; value=5
	fsubp
	fild word [CTE_INT_4] ; value=10
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
	mov ecx, CTE_STR_1 ; value=
	mov edx, 0 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_17 ; value=Prueba 5 (Redondeo):
	mov edx, 20 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_20 ; value=--------------------
	mov edx, 20 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_5 ; value=Todos los numeros se 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_2 ; value=redondean con precision de 
	mov edx, 27 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_16 ; value=4 digitos
	mov edx, 9 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_23 ; value=Modo de redondeo: 
	mov edx, 18 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_12 ; value=Nearest Integer (even)
	mov edx, 22 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_31 ; value=Redondeo de 0.00001: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_6] ; value=1.0E-5
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
	mov ecx, CTE_STR_30 ; value=Redondeo de 0.00004: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_7] ; value=4.0E-5
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
	mov ecx, CTE_STR_3 ; value=Redondeo de 0.00005: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_4] ; value=5.0E-5
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
	mov ecx, CTE_STR_4 ; value=Redondeo de 0.00006: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_5] ; value=6.0E-5
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
	mov ecx, CTE_STR_6 ; value=Redondeo de 0.00009: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_9] ; value=9.0E-5
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
	mov ecx, CTE_STR_1 ; value=
	mov edx, 0 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_18 ; value=Prueba 6 (Plustrunc):
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_19 ; value=---------------------
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_1] ; value=1.5
	fSetRC RC_ZERO
	frndint
	fSetRC RC_NEAREST
	fld dword [CTE_FLT_8] ; value=10.1
	fSetRC RC_ZERO
	frndint
	fSetRC RC_NEAREST
	faddp
	fld dword [CTE_FLT_3] ; value=100.9
	fSetRC RC_ZERO
	frndint
	fSetRC RC_NEAREST
	faddp
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
	dw 5
CTE_INT_4:
	dw 10
CTE_FLT_0:
	dd 1.0
CTE_FLT_1:
	dd 1.5
CTE_FLT_2:
	dd 3.1415927
CTE_FLT_3:
	dd 100.9
CTE_FLT_4:
	dd 5.0E-5
CTE_FLT_5:
	dd 6.0E-5
CTE_FLT_6:
	dd 1.0E-5
CTE_FLT_7:
	dd 4.0E-5
CTE_FLT_8:
	dd 10.1
CTE_FLT_9:
	dd 9.0E-5
CTE_STR_0:
	db "Prueba 1 (Fibonacci):"
CTE_STR_1:
	db ""
CTE_STR_2:
	db "redondean con precision de "
CTE_STR_3:
	db "Redondeo de 0.00005: "
CTE_STR_4:
	db "Redondeo de 0.00006: "
CTE_STR_5:
	db "Todos los numeros se "
CTE_STR_6:
	db "Redondeo de 0.00009: "
CTE_STR_7:
	db " terminos): "
CTE_STR_8:
	db "FIB("
CTE_STR_9:
	db ") = "
CTE_STR_10:
	db "Prueba 4 (Negativos):"
CTE_STR_11:
	db "--------------------------"
CTE_STR_12:
	db "Nearest Integer (even)"
CTE_STR_13:
	db "Prueba 3 (Nro. de Euler):"
CTE_STR_14:
	db "Prueba 2 (Circunferencia):"
CTE_STR_15:
	db "Neg x Neg x Neg: "
CTE_STR_16:
	db "4 digitos"
CTE_STR_17:
	db "Prueba 5 (Redondeo):"
CTE_STR_18:
	db "Prueba 6 (Plustrunc):"
CTE_STR_19:
	db "---------------------"
CTE_STR_20:
	db "--------------------"
CTE_STR_21:
	db "-------------------------"
CTE_STR_22:
	db "e ("
CTE_STR_23:
	db "Modo de redondeo: "
CTE_STR_24:
	db "Circunferencia: "
CTE_STR_25:
	db "Area: "
CTE_STR_26:
	db "Simple: "
CTE_STR_27:
	db "Radio: "
CTE_STR_28:
	db "Neg x Pos: "
CTE_STR_29:
	db "Diametro: "
CTE_STR_30:
	db "Redondeo de 0.00004: "
CTE_STR_31:
	db "Redondeo de 0.00001: "
CTE_ESPECIAL_LF:
	db 10
section .bss
VAR_DIAMETRO:
	resd 1
VAR_e:
	resd 1
VAR_PI:
	resd 1
VAR_termino:
	resd 1
VAR_CONTADOR:
	resw 1
VAR_FIB_A:
	resw 1
VAR_CONTADOR2:
	resw 1
VAR_FIB_B:
	resw 1
BUFFER_CONVERSION:
	resb 15
