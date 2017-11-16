
%macro writeToBuffer 4
	cmp %3, %1
	jae %4
	mov [%2+%3], dl
	inc edi
%endmacro

%macro __digtoa 4
	section .bss
	%%BUF resw 1
	section .text
	fld dword [VAR_TEN]
	fld st1 ; st2=dividend st1=10 st0=dividend
	fprem ; st2=dividend st1=10 st0=dividend%10

	fistp word [%%BUF] ; st1=dividend st0=10


	fdiv st1, st0 ; st1=dividend/10 st0=10
	fstp st0 ; st0=dividend/10
	frndint

	mov dl, [%%BUF]
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

section .data
VAR_TEN dd 10.0

section .text
;====================================================================
; Converts a floating point operand at the top of the fpu stack into
; a string and returns the length of the formatted string in EAX
; Signature: int ftoa (int bufSize, char* buf, int minWidth, int precision)
ftoa:
	push ebp
	mov ebp, esp
	sub esp, __BITS__/8*1 ; 1 local

	mov ebx, [ebp + __BITS__/8*3] ; ebx=buf

	mov esi, 0
	mov edi, 0

	ftst
	fstsw ax
	fjle ax, .nonegative

	mov dl, '-'
	inc esi ; dont reverse minus sign
	fchs ; st0 = -st0
	writeToBuffer [ebp + __BITS__/8*2], ebx, edi, .return

	.nonegative:
	; float specific part: take the decimal part and place separator
	mov eax, [ebp + __BITS__/8*5] ; eax=precision
	fld1
	.multloop:
		cmp eax, 0
		jle .breakmultloop
		fmul dword [VAR_TEN]
		dec eax
	jmp .multloop
	.breakmultloop:

	fmulp ; st0=dividend*(10^%3)
	fSetRC RC_NEAREST
	frndint
	fSetRC RC_ZERO
	mov eax, [ebp + __BITS__/8*5] ; eax=precision
	.divloop:
		cmp eax, 0
		jle .breakdivloop
		__digtoa [ebp + __BITS__/8*2], ebx, edi, .return
		dec eax
	jmp .divloop
	.breakdivloop:
	mov dl, '.'
	writeToBuffer [ebp + __BITS__/8*2], ebx, edi, .return
	; end float specific part

	__itoa [ebp + __BITS__/8*2], ebx, edi, .return

	.return:

	fstp st0 ;
	fSetRC RC_NEAREST ; restore rounding mode


	push edi
	push ecx
	mov ecx, edi
	sub ecx, esi
	lea esi, [ebx+esi]
	push ecx
	push esi
	call strnrev
	pop ecx
	pop edi

	.trimzeros:
		dec edi
		mov dl, [ebx+edi]
		cmp dl, '0'
	je .trimzeros
	cmp dl, '.'
	jne .restorecount
	inc edi
	.restorecount:
	inc edi

	mov eax, edi
	mov esp, ebp
	pop ebp
	ret __BITS__/8*4

;====================================================================
; Converts an integer operand at the top of the fpu stack into
; a string and returns the length of the formatted string in EAX
; Signature: int ftoa (int bufSize, char* buf)
itoa:
	push ebp
	mov ebp, esp

	mov esi, 0
	mov edi, 0

	mov ecx, [ebp + __BITS__/8*2] ; ecx bufSize
	mov ebx, [ebp + __BITS__/8*3] ; ebx=buf

	ftst
	fstsw ax
	fjle ax, .nonegative

	mov dl, '-'
	inc esi ; dont reverse minus sign
	fchs ; st0 = -st0
	writeToBuffer ecx, ebx, edi, .return

	.nonegative:
	__itoa ecx, ebx, edi, .return

	.return:
	fstp st0 ; pop the dividend
	fSetRC RC_NEAREST ; restore control word

	pushad
	mov ecx, edi
	sub ecx, esi
	lea esi, [ebx+esi]
	push ecx
	push esi
	call strnrev
	popad
	mov eax, edi ; set return value

	mov esp, ebp
	pop ebp
	ret __BITS__/8*2
