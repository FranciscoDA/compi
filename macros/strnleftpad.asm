;========================================
;Left-pad a string with character in dl
;Signature: void strnleftpad(int count, char* src, int minWidth, char padChar)
strnleftpad:
	push ebp
	mov ebp, esp

	mov ecx, [ebp + __BITS__/8*4] ; ecx=minWidth
	sub ecx, [ebp + __BITS__/8*2] ; ecx-=count

	pushad
	mov eax, [ebp + __BITS__/8*2] ; ecx=count
	push eax
	mov ebx, [ebp + __BITS__/8*3] ; ebx=src
	push ebx
	lea ebx, [ebx + ecx]
	push ebx
	call strncpy
	popad

	mov ebx, [ebp + __BITS__/8*3]
	mov ecx, [ebp + __BITS__/8*4] ; ecx=minWidth
	mov eax, [ebp + __BITS__/8*2]
	sub ecx, eax ; ecx-=count
	mov edx, [ebp + __BITS__/8*5] ; edx=padChar
	.padloop:
		cmp ecx, 0
		jle .breakpadloop
		mov [ebx+ecx], dl
		dec ecx
		jmp .padloop
	.breakpadloop:

	mov esp, ebp
	pop ebp
	ret __BITS__/8*4

