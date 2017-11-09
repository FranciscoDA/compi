
;arg1 = buffer size
;arg2 = output buffer variable
;input=st0
%macro itoa 2
	section .data
	%%VAR_TEN dd 10.0
	%%VAR_ITEN dw 10
	section .bss
	%%BUF resd 1
	%%CW_IN resw 1
	%%CW_OUT resw 1

	section .text
	fstcw [%%CW_IN]
	mov ax, [%%CW_IN]
	and ax, 0xF3FF
	or ax, 0x0400 ; round down
	mov [%%CW_OUT], ax
	fldcw [%%CW_OUT] ; round down
	mov edi, 0 ; start at idx 0
	fldz ; st1 = dividend st0 = 0
	fcomp ; st0 = dividend
	fstsw ax

	; test if dividend was >0
	test ax, 0000000100000000b ; c0;
	jnz %%nonegative
	; test if dividend was =0
	test ax, 0100000000000000b ; c3
	jnz %%nonegative

	mov dl, '-'
	mov  [%2 + edi], dl
	inc edi
	fchs ; st0 = -st0

	%%nonegative:
	%%beginloop:
	fld dword [%%VAR_TEN] ; st1=dividend st0=10

	fld st1 ; st2=dividend st1=10 st0=dividend
	fprem ; st2=dividend st1=10 st0=dividend%10

	fistp word [%%BUF] ; st1=dividend st0=10
	mov dx, [%%BUF]
	add dx, '0'
	mov [%2 + edi], dl
	inc edi
	cmp edi, %1
	jge %%exitbysize

	fdivp ; st0=dividend/10
	fld1 ; st1=dividend/10 st0=1
	fcomp ; st0=dividend/10
	fstsw ax
	; test if dividend/10 was >0
	test ax, 0000000100000000b ; c0;
	jz %%exitbyzero
	jmp %%beginloop
	%%exitbysize:
	fstp st0 ; pop 10 in st0
	%%exitbyzero:
	fstp st0 ; pop dividend in st0
	fldcw [%%CW_IN]

	; now reverse the resulting string
	mov esi, 0
	%%repeat_reverse_loop:
	dec edi
	mov al, [%2+esi]
	xchg al, [%2+edi]
	xchg al, [%2+esi]
	inc esi
	cmp edi, esi
	jle %%finish
	jmp %%repeat_reverse_loop
	%%finish:
	add edi,esi
%endmacro
