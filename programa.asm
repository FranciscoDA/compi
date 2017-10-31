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
	CTE_STR_5 db "Hola mundo", '$'
.CODE
mov dx, CTE_STR_5
fld CTE_INT_0
fld VAR_6
fld CTE_INT_4
fld VAR_8
fld CTE_INT_2
fld VAR_0
fld VAR_6
fld CTE_INT_1
fld VAR_6
fld VAR_6
fld CTE_INT_5
fld VAR_6
fld CTE_INT_1
fld VAR_6
fld VAR_6
fld CTE_FLOAT_4
fld VAR_6
fld VAR_6
fld VAR_8
fld VAR_0
fld VAR_8
fld VAR_0
fld VAR_8
fld CTE_INT_2
mov dx, CTE_STR_2
fld VAR_8
fld CTE_INT_3
fld VAR_8
fld CTE_FLOAT_1
mov dx, CTE_STR_4
fld VAR_8
fld CTE_FLOAT_0
mov dx, CTE_STR_4
fld VAR_8
fld CTE_FLOAT_3
mov dx, CTE_STR_1
fld VAR_8
fld CTE_INT_3
mov dx, CTE_STR_0
fld VAR_8
fld CTE_INT_6
mov dx, CTE_STR_3
fld CTE_FLOAT_2
fld VAR_8
fld VAR_8
fld VAR_8
fld VAR_8
fld VAR_8
fld VAR_3
fld VAR_9
