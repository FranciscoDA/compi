
section .bss
CW_IN resw 1

section .text

;===========================
;Conditional fpu jump macros
; %1=16 bit register to compare
; %2=destination label
%macro fjg 2
	test %1, 0000000100000000b ; c0;
	jnz %2
%endmacro
%macro fjl 2
	test %1, 0000000100000000b ; c0;
	jz %2
%endmacro
%macro fje 2
	test %1, 0100000000000000b ; c3
	jnz %2
%endmacro
%macro fjne 2
	test %1, 0100000000000000b ; c3
	jz %2
%endmacro
%macro fjge 2
	fjg %1, %2
	fje %1, %2
%endmacro
%macro fjle 2
	fjl %1, %2
	fje %1, %2
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
