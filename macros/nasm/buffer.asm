
section .bss
TMP resw 1

section .text

%macro writeToBuffer 4
	cmp %3, %1
	jae %4
	mov [%2+%3], dl
	inc %3
%endmacro

%macro __digtoa 4
	fld dword [VAR_TEN]
	fld st1 ; st2=dividend st1=10 st0=dividend
	fprem ; st2=dividend st1=10 st0=dividend%10

	fistp word [TMP] ; st1=dividend st0=10


	fdiv st1, st0 ; st1=dividend/10 st0=10
	fstp st0 ; st0=dividend/10
	frndint

	mov dl, [TMP]
	add dl, '0'
	writeToBuffer %1, %2, %3, %4
%endmacro

;==========================================================
;Converts a positive integer to string into the dest buffer
;Requires RC flag set to round towards zero
; %1 = max edi
; %2 = dest buffer
; st0 = number
; edi = dest index
%macro __itoa 4
	fSetRC RC_ZERO
	%%begin:
	__digtoa %1, %2, %3, %4
	ftst
	fstsw ax
	fjge ax, %%exit ; exit if dividend/10 was <=0
	jmp %%begin
	%%exit:
%endmacro
