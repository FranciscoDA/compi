

;public fjg, fjl, fje, fjne, fjge, fjle, fSetRC, fpow, RC_NEAREST, RC_NEGATIVE, RC_POSITIVE, RC_ZERO

.DATA
CW_IN dw ?
TMP dw ?

.CODE

;===========================
;Conditional fpu jump macros
; %1=16 bit register to compare
; %2=destination label
fjg MACRO reg, lab
	test reg, 0000000100000000b ; c0;
	jnz lab
ENDM fjg
fjl MACRO reg, lab
	test reg, 0000000100000000b ; c0;
	jz lab
ENDM fjl
fje MACRO reg, lab
	test reg, 0100000000000000b ; c3
	jnz lab
ENDM fje
fjne MACRO reg, lab
	test reg, 0100000000000000b ; c3
	jz lab
ENDM fjne
fjge MACRO reg, lab
	fjg reg, lab
	fje reg, lab
ENDM fjge
fjle MACRO reg, lab
	fjl reg, lab
	fje reg, lab
ENDM fjle

;=======================================
;Set the RC flag in the fpu control word
; %1=new CR flag
fSetRC MACRO flag
	fstcw [CW_IN]
	mov ax, [CW_IN]
	and ax, 0f3ffh
	or ax, flag ; round down RC flag
	mov [CW_IN], ax
	fldcw [CW_IN] ; set control word
ENDM fSetRC
RC_NEAREST equ 0000h ; round towards nearest int
RC_NEGATIVE equ 0400h ; round towards negative inf
RC_POSITIVE equ 0800h ; round towards positive inf
RC_ZERO equ 0C00h ; round towards zero

fpow MACRO
	fxch ;st1=exponent st0=base
	fyl2x ; st0=fyl2x

	fist word [TMP]
	fisub word [TMP] ; st0=decimals
	f2xm1 ; st0=f2xm1
	fld1
	faddp ; st0=f2x
	fild word [TMP] ; st1=f2x st0=integers
	fxch ; st1=integers st1=f2x
	fscale ; st1=integers st0=f2x*2^integers
	fxch
	fstp st(0) ; st0=result
ENDM fpow
