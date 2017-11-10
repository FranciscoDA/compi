
section .bss
CW_IN resw 1
CW_OUT resw 1

section .text

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

;set the RC flag in the fpu control word
;arg1=CR
%macro RC_set 1
	fstcw [CW_IN]
	mov ax, [CW_IN]
	and ax, 0xF3FF
	or ax, %1 ; round down RC flag
	mov [CW_OUT], ax
	fldcw [CW_OUT] ; set control word
%endmacro
%define RC_nearest 0x0000
%define RC_negInf 0x0400
%define RC_posInf 0x0800
%define RC_zero 0x0C00

;reverse string at memory address in range [esi;edi)
;arg1=variable with string to reverse
%macro reverse 1
	; if in 64 bit mode, push rdi,rsi else assume 32 bit and push edi,esi
	%if __BITS__ == 64
		push rdi
		push rsi
	%else
		push edi
		push esi
	%endif
	%%loop:
	dec edi
	mov al, [%1+esi]
	xchg al, [%1+edi]
	xchg al, [%1+esi]
	inc esi
	cmp edi, esi
	jle %%finish
	jmp %%loop
	%%finish:
	%if __BITS__ == 64
		pop rsi
		pop rdi
	%else
		pop esi
		pop edi
	%endif
%endmacro

;convert the integer number at the top of the stack into a string
;arg1 = buffer size
;arg2 = output buffer variable
;input integer=st0
%macro itoa 2
	section .data
	%%VAR_TEN dd 10.0

	section .bss
	%%BUF resd 1

	section .text
	RC_set RC_zero

	; start at index 0, length 0
	mov esi, 0
	mov edi, 0

	fldz ; st1 = dividend st0 = 0
	fcomp ; st0 = dividend
	fstsw ax
	fjge %%nonegative ; if dividend >=0 don't print minus sign

	mov dl, '-'
	mov  [%2 + edi], dl
	inc edi
	fchs ; st0 = -st0
	mov esi, 1 ; dont reverse minus sign

	%%nonegative:
	fld dword [%%VAR_TEN] ; st1=dividend st0=10

	%%beginloop:
	fld st1 ; st2=dividend st1=10 st0=dividend
	fprem ; st2=dividend st1=10 st0=dividend%10

	fistp word [%%BUF] ; st1=dividend st0=10 st0=dividend
	mov dl, [%%BUF]
	add dl, '0'
	mov [%2 + edi], dl
	inc edi
	cmp edi, %1
	jge %%exit

	fdiv st1, st0 ; st1=dividend/10 st0=10
	fxch ; st1=10 st0=dividend/10
	frndint
	fldz ; st2=10 st1=dividend/10 st0=0
	fcomp ; st1=10 st0=dividend/10
	fstsw ax
	fxch ; st1=dividend/10 st0=10
	fjle %%exit ; exit if dividend/10 was <=0
	jmp %%beginloop

	%%exit:
	; clear stack
	fstp st0
	fstp st0

	fldcw [CW_IN] ; restore control word

	reverse %2 ; reverse the resulting string
%endmacro

;convert the fp number at the top of the stack into a string
;arg1 = buffer size
;arg2 = output buffer variable
;arg3 = precision
;input integer=st0
%macro ftoa 3
	section .data
	%%VAR_TEN dd 10.0

	section .bss
	%%BUF resd 1

	section .text
	RC_set RC_zero

	; start at index 0, length 0
	mov esi, 0
	mov edi, 0

	fldz ; st1 = dividend st0 = 0
	fcomp ; st0 = dividend
	fstsw ax
	fjge %%nonegative ; if dividend >=0 don't print minus sign

	mov dl, '-'
	mov  [%2 + edi], dl
	inc edi
	fchs ; st0 = -st0
	mov esi, 1 ; don't reverse minus sign

	%%nonegative:
	mov ecx, %3
	fld dword [%%VAR_TEN] ; st1=dividend st0=10

	%%multloop:
	cmp ecx, 0
	jle %%beginrealloop
	fmul st1, st0 ; st1=dividend*10 st0=10
	dec ecx
	jmp %%multloop

	%%beginrealloop:
	fld st1 ; st2=dividend st1=10 st0=dividend
	fprem ; st2=dividend st1=10 st0=dividend%10

	; write character to memory
	fistp word [%%BUF] ; st1=dividend st0=10
	mov dl, [%%BUF]
	add dl, '0'
	mov [%2 + edi], dl
	inc edi
	cmp edi, %1
	jge %%exit

	fdiv st1, st0 ; st1=dividend/10 st0=10

	; separator character
	cmp edi, %3
	jl %%beginrealloop
	mov dl, '.'
	mov [%2 + edi], dl
	inc edi
	cmp edi, %1
	jge %%exit

	%%beginintegerloop:
	fld st1 ; st2=dividend st1=10 st0=dividend
	fprem ; st2=dividend st1=10 st0=dividend%10

	fistp word [%%BUF] ; st1=dividend st0=10
	mov dl, [%%BUF]
	add dl, '0'
	mov [%2 + edi], dl
	inc edi
	cmp edi, %1
	jge %%exit

	fdiv st1, st0 ; st1=dividend/10 st0=10
	fxch ; st1=10 st0=dividend/10
	frndint
	fldz ; st2=10 st1=dividend/10 st0=1
	fcomp ; st1=10 st0=dividend/10
	fstsw ax
	fxch ; st1=dividend/10 st0=10
	fjle %%exit ; exit if dividend/10 was <1
	jmp %%beginintegerloop

	; clear the values in the stack (including dividend)
	%%exit:
	fstp st0 ; st0=dividend
	fstp st0 ; stack is clear

	fldcw [CW_IN] ; restore control word

	reverse %2 ; reverse the resulting string
%endmacro




