.MODEL LARGE
.386
.STACK 200h
.DATA
	VAR_PI dd ?
	VAR_DIAMETRO dd ?
	VAR_CONTADOR dw ?
	VAR_FIB_A dw ?
	VAR_FIB_B dw ?
	CTE_INT_0 dw 0
	CTE_INT_1 dw 1
	CTE_INT_2 dw 2
	CTE_INT_3 dw 4
	CTE_INT_4 dw 5
	CTE_INT_5 dw 10
	CTE_FLT_0 dd 3.1415927
	CTE_STR_0 db "", '$'
	CTE_STR_1 db "---------------------", '$'
	CTE_STR_2 db "FIB(", '$'
	CTE_STR_3 db ") = ", '$'
	CTE_STR_4 db "Circunferencia: ", '$'
	CTE_STR_5 db "Prueba 3 (Negativos):", '$'
	CTE_STR_6 db "Area: ", '$'
	CTE_STR_7 db "Prueba 1 (Enteros):", '$'
	CTE_STR_8 db "Radio: ", '$'
	CTE_STR_9 db "Prueba 2 (Reales):", '$'
	CTE_STR_10 db "Diametro: ", '$'
	CTE_STR_11 db "-------------------", '$'
	CTE_STR_12 db "------------------", '$'
	CTE_ESPECIAL_LF db 13, 10, '$'
	BUFFER_CONVERSION db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	aux_int dw ?
	aux_float dd ?
.CODE
	mov dx, CTE_STR_7 ; value=Prueba 1 (Enteros):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_11 ; value=-------------------
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
	mov dx, CTE_STR_2 ; value=FIB(
	mov ah, 09h
	int 21h
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	faddp
	mov dx, CTE_STR_3 ; value=) = 
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
	mov dx, CTE_STR_0 ; value=
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_9 ; value=Prueba 2 (Reales):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_12 ; value=------------------
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	fld dword [CTE_FLT_0] ; value=3.1415927
	fstp dword [VAR_PI]
	fild word [CTE_INT_4] ; value=5
	fstp dword [VAR_DIAMETRO]
	mov dx, CTE_STR_10 ; value=Diametro: 
	mov ah, 09h
	int 21h
	fld dword [VAR_DIAMETRO]
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_8 ; value=Radio: 
	mov ah, 09h
	int 21h
	fld dword [VAR_DIAMETRO]
	fild word [CTE_INT_2] ; value=2
	fdivp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_4 ; value=Circunferencia: 
	mov ah, 09h
	int 21h
	fld dword [VAR_PI]
	fld dword [VAR_DIAMETRO]
	fmulp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_6 ; value=Area: 
	mov ah, 09h
	int 21h
	fld dword [VAR_PI]
	fld dword [VAR_DIAMETRO]
	fmulp
	fld dword [VAR_DIAMETRO]
	fmulp
	fild word [CTE_INT_3] ; value=4
	fdivp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_0 ; value=
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_5 ; value=Prueba 3 (Negativos):
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_1 ; value=---------------------
	mov ah, 09h
	int 21h
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_4] ; value=5
	fsubp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
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
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	fild word [CTE_INT_0] ; value=0
	fild word [CTE_INT_4] ; value=5
	fsubp
	fild word [CTE_INT_5] ; value=10
	fmulp
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
