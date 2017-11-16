
section .data
VAR_TEN dd 10.0

section .text
;====================================================================
; Converts a floating point operand at the top of the fpu stack into
; a string and returns the length of the formatted string in ax
; Signature: int ftoa (int bufSize, char* buf, int minWidth, int precision)
ftoa:
	push bp
	mov bp, sp
	sub sp, __BITS__/8*1 ; 1 local

	mov bx, [bp + __BITS__/8*3] ; bx=buf

	mov si, 0
	mov di, 0

	ftst
	fstsw ax
	fjle ax, .nonegative

	mov dl, '-'
	inc si ; dont reverse minus sign
	fchs ; st0 = -st0
	writeToBuffer [bp + __BITS__/8*2], bx, di, .return

	.nonegative:
	; float specific part: take the decimal part and place separator
	mov ax, [bp + __BITS__/8*5] ; ax=precision
	fld1
	.multloop:
		cmp ax, 0
		jle .breakmultloop
		fmul dword [VAR_TEN]
		dec ax
	jmp .multloop
	.breakmultloop:

	fmulp ; st0=dividend*(10^%3)
	fSetRC RC_NEAREST
	frndint
	fSetRC RC_ZERO
	mov ax, [bp + __BITS__/8*5] ; ax=precision
	.divloop:
		cmp ax, 0
		jle .breakdivloop
		__digtoa [bp + __BITS__/8*2], bx, di, .return
		dec ax
	jmp .divloop
	.breakdivloop:
	mov dl, '.'
	writeToBuffer [bp + __BITS__/8*2], bx, di, .return
	; end float specific part

	__itoa [bp + __BITS__/8*2], bx, di, .return

	.return:

	fstp st0 ;
	fSetRC RC_NEAREST ; restore rounding mode


	push di
	push cx
	mov cx, di
	sub cx, si
	lea si, [bx+si]
	push cx
	push si
	call strnrev
	pop cx
	pop di

	.trimzeros:
		dec di
		mov dl, [bx+di]
		cmp dl, '0'
	je .trimzeros
	cmp dl, '.'
	jne .restorecount
	inc di
	.restorecount:
	inc di

	mov ax, di
	mov sp, bp
	pop bp
	ret __BITS__/8*4

;====================================================================
; Converts an integer operand at the top of the fpu stack into
; a string and returns the length of the formatted string in ax
; Signature: int ftoa (int bufSize, char* buf)
itoa:
	push bp
	mov bp, sp

	mov si, 0
	mov di, 0

	mov cx, [bp + __BITS__/8*2] ; cx bufSize
	mov bx, [bp + __BITS__/8*3] ; bx=buf

	ftst
	fstsw ax
	fjle ax, .nonegative

	mov dl, '-'
	inc si ; dont reverse minus sign
	fchs ; st0 = -st0
	writeToBuffer cx, bx, di, .return

	.nonegative:
	__itoa cx, bx, di, .return

	.return:
	fstp st0 ; pop the dividend
	fSetRC RC_NEAREST ; restore control word

	pushad
	mov cx, di
	sub cx, si
	lea si, [bx+si]
	push cx
	push si
	call strnrev
	popad
	mov ax, di ; set return value

	mov sp, bp
	pop bp
	ret __BITS__/8*2
