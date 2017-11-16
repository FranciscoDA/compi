
.DATA
CW_IN dw ?
TMP dw ?

.CODE

;===========================
;Conditional fpu jump macros
; %1=16 bit register to compare
; %2=destination label
MACRO fjg reg, lab
	test reg, 0000000100000000b ; c0;
	jnz lab
ENDM fjg
MACRO fjl reg, lab
	test reg, 0000000100000000b ; c0;
	jz lab
ENDM fjl
MACRO fje reg, lab
	test reg, 0100000000000000b ; c3
	jnz lab
ENDM fje
MACRO fjne reg, lab
	test reg, 0100000000000000b ; c3
	jz lab
ENDM fjne
MACRO fjge reg, lab
	fjg reg, lab
	fje reg, lab
ENDM fjge
MACRO fjle reg, lab
	fjl reg, lab
	fje reg, lab
ENDM fjle

;=======================================
;Set the RC flag in the fpu control word
; %1=new CR flag
MACRO fSetRC 1
	fstcw [CW_IN]
	mov ax, [CW_IN]
	and ax, 0xF3FF
	or ax, %1 ; round down RC flag
	mov [CW_IN], ax
	fldcw [CW_IN] ; set control word
ENDM fSetRC
DEFINE RC_NEAREST 0x0000 ; round towards nearest int
DEFINE RC_NEGATIVE 0x0400 ; round towards negative inf
DEFINE RC_POSITIVE 0x0800 ; round towards positive inf
DEFINE RC_ZERO 0x0C00 ; round towards zero

MACRO fpow
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
	fstp st0 ; st0=result
ENDM fpow
