.MODEL LARGE
.386
.STACK 200h
.DATA
	VAR_DIAMETRO dd ?
	VAR_e dd ?
	VAR_PI dd ?
	VAR_termino dd ?
	VAR_CONTADOR dw ?
	VAR_FIB_A dw ?
	VAR_CONTADOR2 dw ?
	VAR_FIB_B dw ?
	CTE_INT_0 dw 0
	CTE_INT_1 dw 1
	CTE_INT_2 dw 2
	CTE_INT_3 dw 5
	CTE_INT_4 dw 10
	CTE_FLT_0 dd 1.0
	CTE_FLT_1 dd 1.5
	CTE_FLT_2 dd 3.1415927
	CTE_FLT_3 dd 100.9
	CTE_FLT_4 dd 5.0E-5
	CTE_FLT_5 dd 6.0E-5
	CTE_FLT_6 dd 1.0E-5
	CTE_FLT_7 dd 4.0E-5
	CTE_FLT_8 dd 10.1
	CTE_FLT_9 dd 9.0E-5
	CTE_STR_0 db "Prueba 1 (Fibonacci):", '$'
	CTE_STR_1 db "", '$'
	CTE_STR_2 db "redondean con precision de ", '$'
	CTE_STR_3 db "Redondeo de 0.00005: ", '$'
	CTE_STR_4 db "Redondeo de 0.00006: ", '$'
	CTE_STR_5 db "Todos los numeros se ", '$'
	CTE_STR_6 db "Redondeo de 0.00009: ", '$'
	CTE_STR_7 db " terminos): ", '$'
	CTE_STR_8 db "FIB(", '$'
	CTE_STR_9 db ") = ", '$'
	CTE_STR_10 db "Prueba 4 (Negativos):", '$'
	CTE_STR_11 db "--------------------------", '$'
	CTE_STR_12 db "Nearest Integer (even)", '$'
	CTE_STR_13 db "Prueba 3 (Nro. de Euler):", '$'
	CTE_STR_14 db "Prueba 2 (Circunferencia):", '$'
	CTE_STR_15 db "Neg x Neg x Neg: ", '$'
	CTE_STR_16 db "4 digitos", '$'
	CTE_STR_17 db "Prueba 5 (Redondeo):", '$'
	CTE_STR_18 db "Prueba 6 (Plustrunc):", '$'
	CTE_STR_19 db "---------------------", '$'
	CTE_STR_20 db "--------------------", '$'
	CTE_STR_21 db "-------------------------", '$'
	CTE_STR_22 db "e (", '$'
	CTE_STR_23 db "Modo de redondeo: ", '$'
	CTE_STR_24 db "Circunferencia: ", '$'
	CTE_STR_25 db "Area: ", '$'
	CTE_STR_26 db "Simple: ", '$'
	CTE_STR_27 db "Radio: ", '$'
	CTE_STR_28 db "Neg x Pos: ", '$'
	CTE_STR_29 db "Diametro: ", '$'
	CTE_STR_30 db "Redondeo de 0.00004: ", '$'
	CTE_STR_31 db "Redondeo de 0.00001: ", '$'
	CTE_ESPECIAL_LF db 13, 10, '$'
	BUFFER_CONVERSION db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	aux_int dw ?
	aux_float dd ?
.CODE
	mov dx, CTE_STR_0 ; value=Prueba 1 (Fibonacci):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_19 ; value=---------------------
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
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
	mov dx, CTE_STR_8 ; value=FIB(
	mov ah, 09h
	int 21h
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	faddp
	mov dx, CTE_STR_9 ; value=) = 
	mov ah, 09h
	int 21h
	fild word [VAR_FIB_B]
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	faddp
	fistp word [VAR_CONTADOR]
	jmp LABEL_0
	LABEL_1:
	mov dx, CTE_STR_1 ; value=
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_14 ; value=Prueba 2 (Circunferencia):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_11 ; value=--------------------------
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	fld dword [CTE_FLT_2] ; value=3.1415927
	fstp dword [VAR_PI]
	fild word [CTE_INT_3] ; value=5
	fstp dword [VAR_DIAMETRO]
	mov dx, CTE_STR_29 ; value=Diametro: 
	mov ah, 09h
	int 21h
	fld dword [VAR_DIAMETRO]
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_27 ; value=Radio: 
	mov ah, 09h
	int 21h
	fld dword [VAR_DIAMETRO]
	fild word [CTE_INT_2] ; value=2
	fdivp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_24 ; value=Circunferencia: 
	mov ah, 09h
	int 21h
	fld dword [VAR_PI]
	fld dword [VAR_DIAMETRO]
	fmulp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_25 ; value=Area: 
	mov ah, 09h
	int 21h
	fld dword [VAR_PI]
	fld dword [VAR_DIAMETRO]
	fmulp
	fild word [CTE_INT_2] ; value=2
	fdivp
	fld dword [VAR_DIAMETRO]
	fmulp
	fild word [CTE_INT_2] ; value=2
	fdivp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_1 ; value=
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_13 ; value=Prueba 3 (Nro. de Euler):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_21 ; value=-------------------------
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
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
	mov dx, CTE_STR_22 ; value=e (
	mov ah, 09h
	int 21h
	fild word [VAR_CONTADOR]
	mov dx, CTE_STR_7 ; value= terminos): 
	mov ah, 09h
	int 21h
	fld dword [VAR_e]
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_1 ; value=
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_10 ; value=Prueba 4 (Negativos):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_19 ; value=---------------------
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_26 ; value=Simple: 
	mov ah, 09h
	int 21h
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_3] ; value=5
	fsubp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_15 ; value=Neg x Neg x Neg: 
	mov ah, 09h
	int 21h
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
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_28 ; value=Neg x Pos: 
	mov ah, 09h
	int 21h
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_3] ; value=5
	fsubp
	fild word [CTE_INT_4] ; value=10
	fmulp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_1 ; value=
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_17 ; value=Prueba 5 (Redondeo):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_20 ; value=--------------------
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_5 ; value=Todos los numeros se 
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_2 ; value=redondean con precision de 
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_16 ; value=4 digitos
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_23 ; value=Modo de redondeo: 
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_12 ; value=Nearest Integer (even)
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_31 ; value=Redondeo de 0.00001: 
	mov ah, 09h
	int 21h
	fld dword [CTE_FLT_6] ; value=1.0E-5
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_30 ; value=Redondeo de 0.00004: 
	mov ah, 09h
	int 21h
	fld dword [CTE_FLT_7] ; value=4.0E-5
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_3 ; value=Redondeo de 0.00005: 
	mov ah, 09h
	int 21h
	fld dword [CTE_FLT_4] ; value=5.0E-5
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_4 ; value=Redondeo de 0.00006: 
	mov ah, 09h
	int 21h
	fld dword [CTE_FLT_5] ; value=6.0E-5
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_6 ; value=Redondeo de 0.00009: 
	mov ah, 09h
	int 21h
	fld dword [CTE_FLT_9] ; value=9.0E-5
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_1 ; value=
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_18 ; value=Prueba 6 (Plustrunc):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_19 ; value=---------------------
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
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
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
