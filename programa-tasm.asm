.MODEL LARGE
.386
.STACK 200h
INCLUDE macros/tasm.asm
.DATA
	VAR_DIAMETRO dd ?
	VAR_e dd ?
	VAR_PI dd ?
	VAR_angulo dd ?
	VAR_termino dd ?
	VAR_CONTADOR dw ?
	VAR_FIB_A dw ?
	VAR_CONTADOR2 dw ?
	VAR_FIB_B dw ?
	CTE_INT_0 dw 0
	CTE_INT_1 dw 1
	CTE_INT_2 dw 2
	CTE_INT_3 dw 3
	CTE_INT_4 dw 4
	CTE_INT_5 dw 180
	CTE_INT_6 dw 5
	CTE_INT_7 dw 7
	CTE_INT_8 dw 8
	CTE_INT_9 dw 12345
	CTE_INT_10 dw 10
	CTE_FLT_0 dd 1.0
	CTE_FLT_1 dd 1.5
	CTE_FLT_2 dd 0.5
	CTE_FLT_3 dd 3.1415927
	CTE_FLT_4 dd 100.9
	CTE_FLT_5 dd 5.0E-5
	CTE_FLT_6 dd 6.0E-5
	CTE_FLT_7 dd 1.0E-5
	CTE_FLT_8 dd 4.0E-5
	CTE_FLT_9 dd 10.1
	CTE_FLT_10 dd 9.0E-5
	CTE_STR_0 db "Prueba 1 (Fibonacci):", '$'
	CTE_STR_1 db "", '$'
	CTE_STR_2 db "redondean con precision de ", '$'
	CTE_STR_3 db "PLUSTRUNC ", '$'
	CTE_STR_4 db "Redondeo de 0.00005: ", '$'
	CTE_STR_5 db "Redondeo de 0.00006: ", '$'
	CTE_STR_6 db "Todos los numeros se ", '$'
	CTE_STR_7 db "Redondeo de 0.00009: ", '$'
	CTE_STR_8 db " terminos): ", '$'
	CTE_STR_9 db "FIB(", '$'
	CTE_STR_10 db ") = ", '$'
	CTE_STR_11 db "Prueba 4 (Negativos):", '$'
	CTE_STR_12 db "Seno       ", '$'
	CTE_STR_13 db "1.5, 10.1, 100.9 = ", '$'
	CTE_STR_14 db "--------------------------", '$'
	CTE_STR_15 db "Nearest Integer (even)", '$'
	CTE_STR_16 db "Prueba 3 (Nro. de Euler):", '$'
	CTE_STR_17 db "Coseno  ", '$'
	CTE_STR_18 db "Prueba 2 (Circunferencia):", '$'
	CTE_STR_19 db "Neg x Neg x Neg: ", '$'
	CTE_STR_20 db "4 digitos", '$'
	CTE_STR_21 db "   ", '$'
	CTE_STR_22 db "Prueba 5 (Redondeo):", '$'
	CTE_STR_23 db "---------------------", '$'
	CTE_STR_24 db "--------------------", '$'
	CTE_STR_25 db "2^(3^2) = ", '$'
	CTE_STR_26 db "Grados     ", '$'
	CTE_STR_27 db "2^3^2 = ", '$'
	CTE_STR_28 db "-------------------------", '$'
	CTE_STR_29 db "e (", '$'
	CTE_STR_30 db "Modo de redondeo: ", '$'
	CTE_STR_31 db "12345 % 7 = ", '$'
	CTE_STR_32 db "Radianes   ", '$'
	CTE_STR_33 db "Circunferencia: ", '$'
	CTE_STR_34 db "Area: ", '$'
	CTE_STR_35 db "Simple: ", '$'
	CTE_STR_36 db "2^0.5 = ", '$'
	CTE_STR_37 db "Radio: ", '$'
	CTE_STR_38 db "Neg x Pos: ", '$'
	CTE_STR_39 db "SQRT(2) = ", '$'
	CTE_STR_40 db "Prueba 7 (Trigonometria):", '$'
	CTE_STR_41 db "Diametro: ", '$'
	CTE_STR_42 db "Redondeo de 0.00004: ", '$'
	CTE_STR_43 db "Redondeo de 0.00001: ", '$'
	CTE_STR_44 db "Prueba 6 (Surtidos):", '$'
	BUFFER_CONVERSION db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	aux_int dw ?
	aux_float dd ?
.CODE
MAIN:
	mov ax, SEG BUFFER_CONVERSION
	mov ds, ax
	mov es, ax
	finit
	lea dx, [CTE_STR_0] ; value=Prueba 1 (Fibonacci):
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_23] ; value=---------------------
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	fild CTE_INT_0 ; value=0
	fistp VAR_CONTADOR
	fild CTE_INT_1 ; value=1
	fistp VAR_FIB_A
	fild CTE_INT_0 ; value=0
	fistp VAR_FIB_B
	LABEL_0:
	fild VAR_CONTADOR
	fild CTE_INT_10 ; value=10
	fcompp
	fstsw ax
	test ax, 0000000100000000b ; c0
	jnz LABEL_1
	test ax, 0100000000000000b ; c3
	jnz LABEL_1
	fild VAR_FIB_A
	fild VAR_FIB_B
	faddp
	fistp VAR_FIB_A
	fild VAR_FIB_A
	fild VAR_FIB_B
	fsubp
	fistp VAR_FIB_B
	lea dx, [CTE_STR_9] ; value=FIB(
	mov ah, 09h
	int 21h
	fild VAR_CONTADOR
	fild CTE_INT_1 ; value=1
	faddp
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_10] ; value=) = 
	mov ah, 09h
	int 21h
	fild VAR_FIB_B
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	fild VAR_CONTADOR
	fild CTE_INT_1 ; value=1
	faddp
	fistp VAR_CONTADOR
	jmp LABEL_0
	LABEL_1:
	lea dx, [CTE_STR_1] ; value=
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_18] ; value=Prueba 2 (Circunferencia):
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_14] ; value=--------------------------
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	fld CTE_FLT_3 ; value=3.1415927
	fstp VAR_PI
	fild CTE_INT_6 ; value=5
	fstp VAR_DIAMETRO
	lea dx, [CTE_STR_41] ; value=Diametro: 
	mov ah, 09h
	int 21h
	fld VAR_DIAMETRO
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_37] ; value=Radio: 
	mov ah, 09h
	int 21h
	fld VAR_DIAMETRO
	fild CTE_INT_2 ; value=2
	fdivp
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_33] ; value=Circunferencia: 
	mov ah, 09h
	int 21h
	fld VAR_PI
	fld VAR_DIAMETRO
	fmulp
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_34] ; value=Area: 
	mov ah, 09h
	int 21h
	fld VAR_PI
	fld VAR_DIAMETRO
	fmulp
	fild CTE_INT_2 ; value=2
	fdivp
	fld VAR_DIAMETRO
	fmulp
	fild CTE_INT_2 ; value=2
	fdivp
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_1] ; value=
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_16] ; value=Prueba 3 (Nro. de Euler):
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_28] ; value=-------------------------
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	fild CTE_INT_1 ; value=1
	fistp VAR_CONTADOR
	fild CTE_INT_1 ; value=1
	fstp VAR_e
	LABEL_4:
	fild VAR_CONTADOR
	fild CTE_INT_10 ; value=10
	fcompp
	fstsw ax
	test ax, 0000000100000000b ; c0
	jnz LABEL_5
	fld CTE_FLT_0 ; value=1.0
	fstp VAR_termino
	fild CTE_INT_1 ; value=1
	fistp VAR_CONTADOR2
	LABEL_2:
	fild VAR_CONTADOR2
	fild VAR_CONTADOR
	fcompp
	fstsw ax
	test ax, 0000000100000000b ; c0
	jnz LABEL_3
	fld VAR_termino
	fild VAR_CONTADOR2
	fdivp
	fstp VAR_termino
	fild VAR_CONTADOR2
	fild CTE_INT_1 ; value=1
	faddp
	fistp VAR_CONTADOR2
	jmp LABEL_2
	LABEL_3:
	fild VAR_CONTADOR
	fild CTE_INT_1 ; value=1
	faddp
	fistp VAR_CONTADOR
	fld VAR_e
	fld VAR_termino
	faddp
	fstp VAR_e
	jmp LABEL_4
	LABEL_5:
	lea dx, [CTE_STR_29] ; value=e (
	mov ah, 09h
	int 21h
	fild VAR_CONTADOR
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_8] ; value= terminos): 
	mov ah, 09h
	int 21h
	fld VAR_e
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_1] ; value=
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_11] ; value=Prueba 4 (Negativos):
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_23] ; value=---------------------
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_35] ; value=Simple: 
	mov ah, 09h
	int 21h
	fild CTE_INT_0 ; value=0
	fild CTE_INT_6 ; value=5
	fsubp
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_19] ; value=Neg x Neg x Neg: 
	mov ah, 09h
	int 21h
	fild CTE_INT_0 ; value=0
	fild CTE_INT_6 ; value=5
	fsubp
	fild CTE_INT_0 ; value=0
	fild CTE_INT_2 ; value=2
	fsubp
	fmulp
	fild CTE_INT_0 ; value=0
	fild CTE_INT_1 ; value=1
	fsubp
	fmulp
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_38] ; value=Neg x Pos: 
	mov ah, 09h
	int 21h
	fild CTE_INT_0 ; value=0
	fild CTE_INT_6 ; value=5
	fsubp
	fild CTE_INT_10 ; value=10
	fmulp
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_1] ; value=
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_22] ; value=Prueba 5 (Redondeo):
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_24] ; value=--------------------
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_6] ; value=Todos los numeros se 
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_2] ; value=redondean con precision de 
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_20] ; value=4 digitos
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_30] ; value=Modo de redondeo: 
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_15] ; value=Nearest Integer (even)
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_43] ; value=Redondeo de 0.00001: 
	mov ah, 09h
	int 21h
	fld CTE_FLT_7 ; value=1.0E-5
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_42] ; value=Redondeo de 0.00004: 
	mov ah, 09h
	int 21h
	fld CTE_FLT_8 ; value=4.0E-5
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_4] ; value=Redondeo de 0.00005: 
	mov ah, 09h
	int 21h
	fld CTE_FLT_5 ; value=5.0E-5
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_5] ; value=Redondeo de 0.00006: 
	mov ah, 09h
	int 21h
	fld CTE_FLT_6 ; value=6.0E-5
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_7] ; value=Redondeo de 0.00009: 
	mov ah, 09h
	int 21h
	fld CTE_FLT_10 ; value=9.0E-5
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_1] ; value=
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_44] ; value=Prueba 6 (Surtidos):
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_24] ; value=--------------------
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_3] ; value=PLUSTRUNC 
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_13] ; value=1.5, 10.1, 100.9 = 
	mov ah, 09h
	int 21h
	fld CTE_FLT_1 ; value=1.5
	fSetRC RC_ZERO
	frndint
	fSetRC RC_NEAREST
	fld CTE_FLT_9 ; value=10.1
	fSetRC RC_ZERO
	frndint
	fSetRC RC_NEAREST
	faddp
	fld CTE_FLT_4 ; value=100.9
	fSetRC RC_ZERO
	frndint
	fSetRC RC_NEAREST
	faddp
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_31] ; value=12345 % 7 = 
	mov ah, 09h
	int 21h
	fild CTE_INT_9 ; value=12345
	fild CTE_INT_7 ; value=7
	fxch
	fprem
	fxch
	fstp st(0)
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_39] ; value=SQRT(2) = 
	mov ah, 09h
	int 21h
	fild CTE_INT_2 ; value=2
	fsqrt
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_36] ; value=2^0.5 = 
	mov ah, 09h
	int 21h
	fild CTE_INT_2 ; value=2
	fld CTE_FLT_2 ; value=0.5
	fpow
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_27] ; value=2^3^2 = 
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_25] ; value=2^(3^2) = 
	mov ah, 09h
	int 21h
	fild CTE_INT_2 ; value=2
	fild CTE_INT_3 ; value=3
	fild CTE_INT_2 ; value=2
	fpow
	fpow
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call itoa
lea bx, [BUFFER_CONVERSION]
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_1] ; value=
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_40] ; value=Prueba 7 (Trigonometria):
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	lea dx, [CTE_STR_28] ; value=-------------------------
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	fild CTE_INT_0 ; value=0
	fistp VAR_CONTADOR
	lea dx, [CTE_STR_32] ; value=Radianes   
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_26] ; value=Grados     
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_12] ; value=Seno       
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_17] ; value=Coseno  
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	LABEL_6:
	fild VAR_CONTADOR
	fild CTE_INT_8 ; value=8
	fcompp
	fstsw ax
	test ax, 0000000100000000b ; c0
	jnz LABEL_7
	test ax, 0100000000000000b ; c3
	jnz LABEL_7
	fld VAR_PI
	fild VAR_CONTADOR
	fmulp
	fild CTE_INT_4 ; value=4
	fdivp
	fstp VAR_angulo
	fld VAR_angulo
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_21] ; value=   
	mov ah, 09h
	int 21h
	fld VAR_angulo
	fild CTE_INT_5 ; value=180
	fmulp
	fld VAR_PI
	fdivp
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_21] ; value=   
	mov ah, 09h
	int 21h
	fld VAR_angulo
	fsin
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	lea dx, [CTE_STR_21] ; value=   
	mov ah, 09h
	int 21h
	fld VAR_angulo
	fcos
push 4
push 10
lea bx, [BUFFER_CONVERSION]
push bx
push 14
call ftoa
add bx, ax
mov byte ptr [bx], '$'
	lea dx, [BUFFER_CONVERSION]
	mov ah, 09h
	int 21h
	mov ah, 02h
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	fild VAR_CONTADOR
	fild CTE_INT_1 ; value=1
	faddp
	fistp VAR_CONTADOR
	jmp LABEL_6
	LABEL_7:
	mov ax, 4C00h ; sys_exit
	int 21h
END MAIN
