.MODEL LARGE
.386
.STACK 200h
.DATA
	VAR_CONTADOR dw ?
	VAR_FIB_A dw ?
	VAR_FIB_B dw ?
	CTE_INT_0 dw 0
	CTE_INT_1 dw 1
	CTE_INT_2 dw 5
	CTE_FLT_0 dd 3.5
	CTE_STR_0 db "FIB(", '$'
	CTE_STR_1 db ") = ", '$'
	CTE_STR_2 db "Fin: ", '$'
	CTE_STR_3 db "Hola mundo", '$'
	CTE_ESPECIAL_LF db 13, 10, '$'
	BUFFER_CONVERSION db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	aux_int dw ?
	aux_float dd ?
.CODE
	mov dx, CTE_STR_3 ; value=Hola mundo
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
	mov dx, CTE_STR_0 ; value=FIB(
	mov ah, 09h
	int 21h
	fild word [VAR_CONTADOR]
	fild word [CTE_INT_1] ; value=1
	faddp
	mov dx, CTE_STR_1 ; value=) = 
	mov ah, 09h
	int 21h
	fild word [VAR_FIB_A]
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
	mov dx, CTE_STR_2 ; value=Fin: 
	mov ah, 09h
	int 21h
	fld dword [CTE_FLT_0] ; value=3.5
	mov dx, CTE_ESPECIAL_LF ; line break
	mov ah, 09h
	int 21h
