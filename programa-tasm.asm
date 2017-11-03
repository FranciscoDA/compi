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
	CTE_STR_0 db "Hola mundo", '$'
	aux_int dw ?
	aux_float dd ?
.CODE
	mov dx, CTE_STR_0 ; value=Hola mundo
	mov ah, 09h
	int 21h
