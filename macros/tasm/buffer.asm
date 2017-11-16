
.DATA
TMP dw ?

.CODE
MACRO writeToBuffer bufS, buf, bufI, lab
	cmp bufI, bufS
	jae lab
	mov [buf+bufI], dl
	inc bufI
ENDM writeToBuffer

MACRO __digtoa bufS, buf, bufI, lab
	fld dword [VAR_TEN]
	fld st1 ; st2=dividend st1=10 st0=dividend
	fprem ; st2=dividend st1=10 st0=dividend%10

	fistp word [TMP] ; st1=dividend st0=10


	fdiv st1, st0 ; st1=dividend/10 st0=10
	fstp st0 ; st0=dividend/10
	frndint

	mov dl, [TMP]
	add dl, '0'
	writeToBuffer bufS, buf, bufI, lab
ENDM __digtoa

;==========================================================
;Converts a positive integer to string into the dest buffer
;Requires RC flag set to round towards zero
; %1 = max edi
; %2 = dest buffer
; st0 = number
; edi = dest index
MACRO __itoa bufS, buf, bufI, lab
	fSetRC RC_ZERO
	%%begin:
	__digtoa bufS, buf, bufI, lab
	ftst
	fstsw ax
	fjge ax, %%exit ; exit if dividend/10 was <=0
	jmp %%begin
	%%exit:
ENDM __itoa
