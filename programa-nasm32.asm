; compile with: nasm -felf32 programa-nasm32.asm && ld programa-nasm32.o
; 32-bit linux only
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
	mov ecx, CTE_STR_23 ; value=---------------------
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
	fild word [CTE_INT_10] ; value=10
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
	mov ecx, CTE_STR_9 ; value=FIB(
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
	mov ecx, CTE_STR_10 ; value=) = 
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
	mov ecx, CTE_STR_18 ; value=Prueba 2 (Circunferencia):
	mov edx, 26 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_14 ; value=--------------------------
	mov edx, 26 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_3] ; value=3.1415927
	fstp dword [VAR_PI]
	fild word [CTE_INT_6] ; value=5
	fstp dword [VAR_DIAMETRO]
	mov ecx, CTE_STR_41 ; value=Diametro: 
	mov edx, 10 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_DIAMETRO]
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_37 ; value=Radio: 
	mov edx, 7 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_DIAMETRO]
	fild word [CTE_INT_2] ; value=2
	fdivp
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_33 ; value=Circunferencia: 
	mov edx, 16 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_PI]
	fld dword [VAR_DIAMETRO]
	fmulp
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_34 ; value=Area: 
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
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_16 ; value=Prueba 3 (Nro. de Euler):
	mov edx, 25 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_28 ; value=-------------------------
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
	fild word [CTE_INT_10] ; value=10
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
	mov ecx, CTE_STR_29 ; value=e (
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
	mov ecx, CTE_STR_8 ; value= terminos): 
	mov edx, 12 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_e]
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_11 ; value=Prueba 4 (Negativos):
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_23 ; value=---------------------
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_35 ; value=Simple: 
	mov edx, 8 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_6] ; value=5
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
	mov ecx, CTE_STR_19 ; value=Neg x Neg x Neg: 
	mov edx, 17 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_6] ; value=5
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
	mov ecx, CTE_STR_38 ; value=Neg x Pos: 
	mov edx, 11 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_6] ; value=5
	fsubp
	fild word [CTE_INT_10] ; value=10
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
	mov ecx, CTE_STR_22 ; value=Prueba 5 (Redondeo):
	mov edx, 20 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_24 ; value=--------------------
	mov edx, 20 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_6 ; value=Todos los numeros se 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_2 ; value=redondean con precision de 
	mov edx, 27 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_20 ; value=4 digitos
	mov edx, 9 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_30 ; value=Modo de redondeo: 
	mov edx, 18 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_15 ; value=Nearest Integer (even)
	mov edx, 22 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_43 ; value=Redondeo de 0.00001: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_7] ; value=1.0E-5
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_42 ; value=Redondeo de 0.00004: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_8] ; value=4.0E-5
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_4 ; value=Redondeo de 0.00005: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_5] ; value=5.0E-5
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_5 ; value=Redondeo de 0.00006: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_6] ; value=6.0E-5
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_7 ; value=Redondeo de 0.00009: 
	mov edx, 21 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_10] ; value=9.0E-5
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_44 ; value=Prueba 6 (Surtidos):
	mov edx, 20 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_24 ; value=--------------------
	mov edx, 20 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_3 ; value=PLUSTRUNC 
	mov edx, 10 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_13 ; value=1.5, 10.1, 100.9 = 
	mov edx, 19 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [CTE_FLT_1] ; value=1.5
	fSetRC RC_ZERO
	frndint
	fSetRC RC_NEAREST
	fld dword [CTE_FLT_9] ; value=10.1
	fSetRC RC_ZERO
	frndint
	fSetRC RC_NEAREST
	faddp
	fld dword [CTE_FLT_4] ; value=100.9
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
	mov ecx, CTE_STR_31 ; value=12345 % 7 = 
	mov edx, 12 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_9] ; value=12345
	fild word [CTE_INT_7] ; value=7
	fxch
	fprem
	fxch
fstp st0
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
	mov ecx, CTE_STR_39 ; value=SQRT(2) = 
	mov edx, 10 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_2] ; value=2
	fsqrt
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_36 ; value=2^0.5 = 
	mov edx, 8 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_2] ; value=2
	fld dword [CTE_FLT_2] ; value=0.5
	fpow
	ftoa 14, BUFFER_CONVERSION
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
	mov ecx, CTE_STR_27 ; value=2^3^2 = 
	mov edx, 8 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_25 ; value=2^(3^2) = 
	mov edx, 10 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fild word [CTE_INT_2] ; value=2
	fild word [CTE_INT_3] ; value=3
	fild word [CTE_INT_2] ; value=2
	fpow
	fpow
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
	mov ecx, CTE_STR_40 ; value=Prueba 7 (Trigonometria):
	mov edx, 25 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_28 ; value=-------------------------
	mov edx, 25 ; msg length
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
	mov ecx, CTE_STR_32 ; value=Radianes   
	mov edx, 11 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_26 ; value=Grados     
	mov edx, 11 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_12 ; value=Seno       
	mov edx, 11 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_17 ; value=Coseno  
	mov edx, 8 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_ESPECIAL_LF ; line break
	mov edx, 1 ; length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	LABEL_6:
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_8] ; value=8
	fcompp
	fstsw ax
	test ax, 0000000100000000b ; c0
	jnz LABEL_7
	test ax, 0100000000000000b ; c3
	jnz LABEL_7
	fld dword [VAR_PI]
	fild word [VAR_CONTADOR]
	fmulp
	fild word [CTE_INT_4] ; value=4
	fdivp
	fstp dword [VAR_angulo]
	fld dword [VAR_angulo]
	ftoa 14, BUFFER_CONVERSION
	mov ecx, BUFFER_CONVERSION
	mov edx, edi
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_21 ; value=   
	mov edx, 3 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_angulo]
	fild word [CTE_INT_5] ; value=180
	fmulp
	fld dword [VAR_PI]
	fdivp
	ftoa 14, BUFFER_CONVERSION
	mov ecx, BUFFER_CONVERSION
	mov edx, edi
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_21 ; value=   
	mov edx, 3 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_angulo]
	fsin
	ftoa 14, BUFFER_CONVERSION
	mov ecx, BUFFER_CONVERSION
	mov edx, edi
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	mov ecx, CTE_STR_21 ; value=   
	mov edx, 3 ; msg length
	mov eax, 0x4 ; sys_write
	mov ebx, 1 ; fd=stdout
	int 0x80
	fld dword [VAR_angulo]
	fcos
	ftoa 14, BUFFER_CONVERSION
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
	jmp LABEL_6
	LABEL_7:
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
	dw 3
CTE_INT_4:
	dw 4
CTE_INT_5:
	dw 180
CTE_INT_6:
	dw 5
CTE_INT_7:
	dw 7
CTE_INT_8:
	dw 8
CTE_INT_9:
	dw 12345
CTE_INT_10:
	dw 10
CTE_FLT_0:
	dd 1.0
CTE_FLT_1:
	dd 1.5
CTE_FLT_2:
	dd 0.5
CTE_FLT_3:
	dd 3.1415927
CTE_FLT_4:
	dd 100.9
CTE_FLT_5:
	dd 5.0E-5
CTE_FLT_6:
	dd 6.0E-5
CTE_FLT_7:
	dd 1.0E-5
CTE_FLT_8:
	dd 4.0E-5
CTE_FLT_9:
	dd 10.1
CTE_FLT_10:
	dd 9.0E-5
CTE_STR_0:
	db "Prueba 1 (Fibonacci):"
CTE_STR_1:
	db ""
CTE_STR_2:
	db "redondean con precision de "
CTE_STR_3:
	db "PLUSTRUNC "
CTE_STR_4:
	db "Redondeo de 0.00005: "
CTE_STR_5:
	db "Redondeo de 0.00006: "
CTE_STR_6:
	db "Todos los numeros se "
CTE_STR_7:
	db "Redondeo de 0.00009: "
CTE_STR_8:
	db " terminos): "
CTE_STR_9:
	db "FIB("
CTE_STR_10:
	db ") = "
CTE_STR_11:
	db "Prueba 4 (Negativos):"
CTE_STR_12:
	db "Seno       "
CTE_STR_13:
	db "1.5, 10.1, 100.9 = "
CTE_STR_14:
	db "--------------------------"
CTE_STR_15:
	db "Nearest Integer (even)"
CTE_STR_16:
	db "Prueba 3 (Nro. de Euler):"
CTE_STR_17:
	db "Coseno  "
CTE_STR_18:
	db "Prueba 2 (Circunferencia):"
CTE_STR_19:
	db "Neg x Neg x Neg: "
CTE_STR_20:
	db "4 digitos"
CTE_STR_21:
	db "   "
CTE_STR_22:
	db "Prueba 5 (Redondeo):"
CTE_STR_23:
	db "---------------------"
CTE_STR_24:
	db "--------------------"
CTE_STR_25:
	db "2^(3^2) = "
CTE_STR_26:
	db "Grados     "
CTE_STR_27:
	db "2^3^2 = "
CTE_STR_28:
	db "-------------------------"
CTE_STR_29:
	db "e ("
CTE_STR_30:
	db "Modo de redondeo: "
CTE_STR_31:
	db "12345 % 7 = "
CTE_STR_32:
	db "Radianes   "
CTE_STR_33:
	db "Circunferencia: "
CTE_STR_34:
	db "Area: "
CTE_STR_35:
	db "Simple: "
CTE_STR_36:
	db "2^0.5 = "
CTE_STR_37:
	db "Radio: "
CTE_STR_38:
	db "Neg x Pos: "
CTE_STR_39:
	db "SQRT(2) = "
CTE_STR_40:
	db "Prueba 7 (Trigonometria):"
CTE_STR_41:
	db "Diametro: "
CTE_STR_42:
	db "Redondeo de 0.00004: "
CTE_STR_43:
	db "Redondeo de 0.00001: "
CTE_STR_44:
	db "Prueba 6 (Surtidos):"
CTE_ESPECIAL_LF:
	db 10
section .bss
VAR_DIAMETRO:
	resd 1
VAR_e:
	resd 1
VAR_PI:
	resd 1
VAR_angulo:
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
