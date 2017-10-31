.MODEL LARGE
.386
.STACK 200h
.DATA
	VAR_SUMA dd ?
	VAR_ASD dw ?
	VAR_DX dd ?
	VAR_CX dd ?
	VAR_BX dw ?
	VAR_AX dw ?
	VAR_CONTADOR dw ?
	VAR_PROMEDIO dd ?
	VAR_ACTUAL dw ?
	VAR_RESULT dw ?
	CTE_INT_0 dw 0
	CTE_INT_1 dw 1
	CTE_INT_2 dw 2
	CTE_INT_3 dw 3
	CTE_INT_4 dw 999
	CTE_INT_5 dw 92
	CTE_INT_6 dw 31
	CTE_FLOAT_0 dd 99.0
	CTE_FLOAT_1 dd 99999.99
	CTE_FLOAT_2 dd 333.3333
	CTE_FLOAT_3 dd 0.9999
	CTE_FLOAT_4 dd 0.342
	CTE_STR_0 db "asldk fh sjf", '$'
	CTE_STR_1 db "@sdADaSjfla%dfg", '$'
	CTE_STR_2 db "2 > 3", '$'
	CTE_STR_3 db "asd", '$'
	CTE_STR_4 db "SOY TRUE", '$'
	CTE_STR_5 db "SOY FALSE", '$'
	CTE_STR_6 db "Hola mundo", '$'
	aux_int dw ?
	aux_float dd ?
.CODE
	mov dx, CTE_STR_6 ; value = "Hola mundo"
	mov ah, 09h
	int 21h
	flid CTE_INT_0 ; value = 0
	flid VAR_CONTADOR
	fstp ST(1)
	flid CTE_INT_4 ; value = 999
	flid VAR_ACTUAL
	fstp ST(1)
	flid CTE_INT_2 ; value = 2
	fld VAR_SUMA
	fstp ST(1)
	flid VAR_CONTADOR
	flid CTE_INT_1 ; value = 1
	faddp
	flid VAR_CONTADOR
	fstp ST(1)
	LABEL_0:
	flid VAR_CONTADOR
	flid CTE_INT_5 ; value = 92
	fcom
	jg (LABEL_1)
	flid VAR_CONTADOR
	flid CTE_INT_1 ; value = 1
	faddp
	flid VAR_CONTADOR
	fstp ST(1)
	flid VAR_CONTADOR
	fld CTE_FLOAT_4 ; value = 0.342
	fdivp
	flid VAR_CONTADOR
	flid VAR_CONTADOR
	fmulp
	faddp
	flid VAR_ACTUAL
	fstp ST(1)
	fld VAR_SUMA
	flid VAR_ACTUAL
	faddp
	fld VAR_SUMA
	fstp ST(1)
	jmp (LABEL_0)
	LABEL_1:
	flid VAR_ACTUAL
	flid CTE_INT_2 ; value = 2
	fcom
	jle (LABEL_2)
	mov dx, CTE_STR_2 ; value = "2 > 3"
	mov ah, 09h
	int 21h
	LABEL_2:
	flid VAR_ACTUAL
	flid CTE_INT_3 ; value = 3
	fcom
	jge (LABEL_8)
	flid VAR_ACTUAL
	fld CTE_FLOAT_1 ; value = 99999.99
	fcom
	jl (LABEL_3)
	mov dx, CTE_STR_4 ; value = "SOY TRUE"
	mov ah, 09h
	int 21h
	LABEL_3:
	flid VAR_ACTUAL
	fld CTE_FLOAT_0 ; value = 99.0
	fcom
	jg (LABEL_4)
	mov dx, CTE_STR_5 ; value = "SOY FALSE"
	mov ah, 09h
	int 21h
	LABEL_4:
	flid VAR_ACTUAL
	fld CTE_FLOAT_3 ; value = 0.9999
	fcom
	je (LABEL_5)
	mov dx, CTE_STR_1 ; value = "@sdADaSjfla%dfg"
	mov ah, 09h
	int 21h
	LABEL_5:
	flid VAR_ACTUAL
	flid CTE_INT_3 ; value = 3
	fcom
	jne (LABEL_6)
	mov dx, CTE_STR_0 ; value = "asldk fh sjf"
	mov ah, 09h
	int 21h
	LABEL_6:
	flid VAR_ACTUAL
	flid CTE_INT_6 ; value = 31
	fcom
	je (LABEL_7)
	mov dx, CTE_STR_3 ; value = "asd"
	mov ah, 09h
	int 21h
	LABEL_7:
	jmp (LABEL_9)
	LABEL_8:
	fld CTE_FLOAT_2 ; value = 333.3333
	flid VAR_ACTUAL
	fstp ST(1)
	LABEL_9:
	flid VAR_ACTUAL
	flid VAR_ACTUAL
	faddp
	fisttp aux_int
	fild aux_int
	flid VAR_ACTUAL
	flid VAR_ACTUAL
	fmulp
	fisttp aux_int
	fild aux_int
	faddp
	fld VAR_CX
	fisttp aux_int
	fild aux_int
	faddp
	flid VAR_RESULT
	fstp ST(1)
