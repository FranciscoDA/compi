.MODEL LARGE
.386
.STACK 200h
.DATA
	VAR_SUMA dw ?
	VAR_ASD dd ?
	VAR_DX dw ?
	VAR_CX dw ?
	VAR_BX dd ?
	VAR_AX dw ?
	VAR_CONTADOR dw ?
	VAR_PROMEDIO dw ?
	VAR_ACTUAL dd ?
	VAR_RESULT dd ?
	CTE_INT_0 dw 0
	CTE_INT_1 dw 1
	CTE_INT_2 dw 2
	CTE_INT_3 dw 3
	CTE_INT_4 dw 999
	CTE_INT_5 dw 92
	CTE_INT_6 dw 31
	CTE_FLT_0 dd 99.0
	CTE_FLT_1 dd 99999.99
	CTE_FLT_2 dd 333.3333
	CTE_FLT_3 dd 0.9999
	CTE_FLT_4 dd 0.342
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
	mov dx, CTE_STR_6 ; value=Hola mundo
	mov ah, 09h
	int 21h
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
	mov dx, CTE_STR_2 ; value=2 > 3
	mov ah, 09h
	int 21h
	LABEL_2:
	fld VAR_ACTUAL
	fild CTE_INT_3 ; value=3
	cmp
	jge LABEL_8
	fld VAR_ACTUAL
	fld CTE_FLT_1 ; value=99999.99
	cmp
	je LABEL_3
	mov dx, CTE_STR_4 ; value=SOY TRUE
	mov ah, 09h
	int 21h
	LABEL_3:
	fld VAR_ACTUAL
	fld CTE_FLT_0 ; value=99.0
	cmp
	jg LABEL_4
	mov dx, CTE_STR_5 ; value=SOY FALSE
	mov ah, 09h
	int 21h
	LABEL_4:
	fld VAR_ACTUAL
	fld CTE_FLT_3 ; value=0.9999
	cmp
	je LABEL_5
	mov dx, CTE_STR_1 ; value=@sdADaSjfla%dfg
	mov ah, 09h
	int 21h
	LABEL_5:
	fld VAR_ACTUAL
	fild CTE_INT_3 ; value=3
	cmp
	jne LABEL_6
	mov dx, CTE_STR_0 ; value=asldk fh sjf
	mov ah, 09h
	int 21h
	LABEL_6:
	fld VAR_ACTUAL
	fild CTE_INT_6 ; value=31
	cmp
	je LABEL_7
	mov dx, CTE_STR_3 ; value=asd
	mov ah, 09h
	int 21h
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
