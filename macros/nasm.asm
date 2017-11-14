
section .data
VAR_TEN dd 10.0
VAR_PRECISION dw 4

section .bss
CW_IN resw 1

section .text

%include "macros/strnreverse.asm"

;conditional jump instructions expect status word in ax
%macro fjg 1
	test ax, 0000000100000000b ; c0;
	jnz %1
%endmacro
%macro fjl 1
	test ax, 0000000100000000b ; c0;
	jz %1
%endmacro
%macro fje 1
	test ax, 0100000000000000b ; c3
	jnz %1
%endmacro
%macro fjne 1
	test ax, 0100000000000000b ; c3
	jz %1
%endmacro
%macro fjge 1
	fjg %1
	fje %1
%endmacro
%macro fjle 1
	fjl %1
	fje %1
%endmacro

;=======================================
;Set the RC flag in the fpu control word
; %1=new CR flag
%macro fSetRC 1
	fstcw [CW_IN]
	mov ax, [CW_IN]
	and ax, 0xF3FF
	or ax, %1 ; round down RC flag
	mov [CW_IN], ax
	fldcw [CW_IN] ; set control word
%endmacro
%define RC_NEAREST 0x0000 ; round towards nearest int
%define RC_NEGATIVE 0x0400 ; round towards negative inf
%define RC_POSITIVE 0x0800 ; round towards positive inf
%define RC_ZERO 0x0C00 ; round towards zero

;================================================================
;Convert the integer number at the top of the stack into a string
; %1 = buffer size
; %2 = output buffer variable
; st0 = input
%macro itoa 2
	section .text
	; start at index 0, length 0
	mov esi, 0
	mov edi, 0

	ftst
	fstsw ax
	fjle %%nonegative

	mov dl, '-'
	inc esi ; dont reverse minus sign
	fchs ; st0 = -st0
	writeToBuffer %1, %2, %%exit

	%%nonegative:
	__itoa %1, %2
	%%exit:
	fstp st0 ; pop the dividend
	fSetRC RC_NEAREST ; restore control word

	push esi
	push ecx
	mov ecx, edi
	sub ecx, esi
	lea esi, [%2]
	push ecx
	push esi
	call strnreverse
	pop ecx
	pop esi
%endmacro

;===========================================================
;Convert the fp number at the top of the stack into a string
; %1 = buffer size
; %2 = output buffer variable
; st0 = number
%macro ftoa 2
	section .bss
	%%BUF resw 1
	section .text
	; start at index 0, length 0
	mov esi, 0
	mov edi, 0

	ftst
	fstsw ax
	fjle %%nonegative

	mov dl, '-'
	inc esi ; dont reverse minus sign
	fchs ; st0 = -st0
	writeToBuffer %1, %2, %%exit

	%%nonegative:
	; float specific part: take the decimal part and place separator
	mov ecx, [VAR_PRECISION]
	fld1
	%%multloop:
		fmul dword [VAR_TEN]
	loop %%multloop
	fmulp ; st0=dividend*(10^%3)
	fSetRC RC_NEAREST
	frndint
	fSetRC RC_ZERO
	mov ecx, [VAR_PRECISION]
	%%divloop:
		fld dword [VAR_TEN]
		fld st1 ; st2=dividend*(10^%3) st1=10 st0=dividend*(10^%3)
		fprem
		fistp word [%%BUF]
		fdiv st1, st0
		fstp st0 ; st0=dividend
		mov dl, [%%BUF]
		add dl, '0'
		writeToBuffer %1, %2, %%exit
	loop %%divloop
	mov dl, '.'
	writeToBuffer %1, %2, %%exit
	; end float specific part

	__itoa %1, %2

	%%exit:
	fstp st0 ;
	fSetRC RC_NEAREST ; restore rounding mode

	push esi
	push ecx
	mov ecx, edi
	sub ecx, esi
	lea esi, [%2+esi]
	push ecx
	push esi
	call strnreverse
	pop ecx
	pop esi
	;strnreverse %2 ; reverse the resulting string

	%%trimzeros:
	dec edi
	mov dl, [%2+edi]
	cmp dl, '0'
	je %%trimzeros
	cmp dl, '.'
	jne %%restorelength
	inc edi
	%%restorelength:
	inc edi
%endmacro

;==========================================================
;Converts a positive integer to string into the dest buffer
;Requires RC flag set to round towards zero
; %1 = max edi
; %2 = dest buffer
; st0 = number
; edi = dest index
%macro __itoa 2
	section .bss
	%%BUF resw 1

	section .text
	fSetRC RC_ZERO
	fld dword [VAR_TEN]
	%%begin:
	fld st1 ; st2=dividend st1=10 st0=dividend
	fprem ; st2=dividend st1=10 st0=dividend%10

	fistp word [%%BUF] ; st1=dividend st0=10
	mov dl, [%%BUF]
	add dl, '0'
	writeToBuffer %1, %2, %%exit

	fdiv st1, st0 ; st1=dividend/10 st0=10
	fxch ; st1=10 st0=dividend/10
	frndint
	ftst
	fstsw ax
	fxch ; st1=dividend/10 st0=10
	fjge %%exit ; exit if dividend/10 was <=0
	jmp %%begin
	%%exit:
	fstp st0 ; st0=dividend
%endmacro

;=======================================================
;Writes a character to a string buffer and increases EDI
; %1 = Buffer size
; %2 = Buffer
; %3 = Label to jump to on overflow
; edi = Destination index
; dl = Character
%macro writeToBuffer 3
	cmp edi, %1
	jge %3
	mov [%2 + edi], dl
	inc edi
%endmacro

%macro fpow 0
	section .bss
	%%TMP resw 1
	section .text
	fxch ;st1=exponent st0=base
	fyl2x ; st0=fyl2x

	fist word [%%TMP]
	fisub word [%%TMP] ; st0=decimals
	f2xm1 ; st0=f2xm1
	fld1
	faddp ; st0=f2x
	fild word [%%TMP] ; st1=f2x st0=integers
	fxch ; st1=integers st1=f2x
	fscale ; st1=integers st0=f2x*2^integers
	fxch
	fstp st0 ; st0=result
%endmacro
